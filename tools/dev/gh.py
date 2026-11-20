#!/usr/bin/env python3
"""Small GitHub helper for driving CI without a browser. No secrets in this file.

    export GITHUB_TOKEN=...          # a token with repo + workflow scope
    python tools/dev/gh.py runs                    # latest runs on the branch
    python tools/dev/gh.py dispatch check          # run compile-check (tasks: check, regen,
                                                   #   back-translate, back-translate-nllb)
    python tools/dev/gh.py watch                   # wait for the newest run, print steps
    python tools/dev/gh.py why [RUN_ID]            # failed-step annotations of a run

Branch defaults to `languages`; override with GITHUB_BRANCH. CI log downloads are
blocked in the agent sandbox, so failures are read from check-run annotations.
"""
import json
import os
import sys
import time
import urllib.error
import urllib.request

REPO = os.environ.get("GITHUB_REPO", "bpprojectsz/Atrament-Aesthetic-Notepad")
BRANCH = os.environ.get("GITHUB_BRANCH", "languages")
WORKFLOW = "compile-check.yml"


def call(method, path, body=None):
    token = os.environ.get("GITHUB_TOKEN")
    if not token:
        sys.exit("Set GITHUB_TOKEN first (ask the project owner).")
    req = urllib.request.Request(
        f"https://api.github.com/repos/{REPO}{path}",
        method=method,
        data=json.dumps(body).encode() if body is not None else None,
        headers={
            "Authorization": f"Bearer {token}",
            "Accept": "application/vnd.github+json",
            "Content-Type": "application/json",
        },
    )
    try:
        with urllib.request.urlopen(req, timeout=30) as r:
            text = r.read().decode()
            return r.status, (json.loads(text) if text else {})
    except urllib.error.HTTPError as e:
        return e.code, e.read().decode()[:300]


def runs(n=5):
    _, d = call("GET", f"/actions/runs?branch={BRANCH}&per_page={n}")
    for r in d["workflow_runs"]:
        print(r["id"], r["name"], r["status"], r["conclusion"], r["head_sha"][:7], r["created_at"])
    return d["workflow_runs"]


def dispatch(task="check"):
    status, _ = call(
        "POST", f"/actions/workflows/{WORKFLOW}/dispatches",
        {"ref": BRANCH, "inputs": {"task": task}},
    )
    print("dispatch", task, "->", status, "(204 = started)")
    time.sleep(20)
    return runs(1)[0]["id"]


def steps(run_id):
    _, d = call("GET", f"/actions/runs/{run_id}/jobs")
    for j in d["jobs"]:
        print(j["name"], j["status"], j["conclusion"])
        for s in j["steps"]:
            if s["conclusion"] not in ("success", "skipped"):
                print("   ", s["number"], s["name"], s["status"], s["conclusion"])
    return d["jobs"]


def watch(run_id=None, limit=280):
    run_id = run_id or runs(1)[0]["id"]
    end = time.time() + limit
    while time.time() < end:
        _, d = call("GET", f"/actions/runs/{run_id}")
        if d["status"] == "completed":
            print("completed:", d["conclusion"])
            break
        time.sleep(15)
    else:
        print("still running; call watch again (tool calls last 5 minutes max)")
    steps(run_id)


def why(run_id=None):
    run_id = run_id or runs(1)[0]["id"]
    for j in call("GET", f"/actions/runs/{run_id}/jobs")[1]["jobs"]:
        _, a = call("GET", f"/check-runs/{j['id']}/annotations?per_page=100")
        for x in a if isinstance(a, list) else []:
            if "Node.js" in x["message"] or "ubuntu" in x["message"]:
                continue
            print(x["title"] or "-", "|", x["message"][:1800].replace("%0A", "\n"))


if __name__ == "__main__":
    cmd = sys.argv[1] if len(sys.argv) > 1 else "runs"
    arg = sys.argv[2] if len(sys.argv) > 2 else None
    {"runs": lambda: runs(), "dispatch": lambda: dispatch(arg or "check"),
     "watch": lambda: watch(arg), "why": lambda: why(arg)}[cmd]()
