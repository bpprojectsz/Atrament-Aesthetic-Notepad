# Device checklist (owner)

Everything below is **unverified on a real phone**. CI only simulates language settings and draws three screens with an estimated font width. Run this on a real Android phone (and an iPhone if you build iOS), then send back results in the format at the end. Nothing here needs code.

You need an APK from the "Build and Deploy" workflow (not triggered yet; batch 19) or any debug build of the `languages` branch.

## 0. Before you start

- Use a phone with Android 13 or newer if you can (per-app language, notification permission prompt).
- Test **fresh installs** for the first-launch checks: uninstall first, then change the phone language, then install.
- Turn the phone font size to the largest setting once during section 4 (the app was tested at 130%).
- Keep screenshots. A wrong glyph or a cut-off word is much easier to fix from a screenshot.

## 1. First launch follows the phone language

For each language: uninstall, set the phone language, install, open.

| Phone language | Expect |
|---|---|
| German | Whole app in German, left-to-right |
| Japanese | Japanese, no boxes (tofu) instead of characters |
| Chinese (Taiwan / Traditional) | Traditional characters (e.g. 設定, not 设置) |
| Chinese (China / Simplified) | Simplified characters |
| Arabic | Arabic, **layout mirrored** (back arrow and menus on the right) |
| Urdu | Urdu, layout mirrored |
| Hindi | Hindi, conjunct letters joined correctly |
| Tamil | Tamil, no broken/stacked letters |
| Thai | Thai, vowels and tone marks sit above/below correctly |
| A language the app lacks (none expected now) | English |

## 2. Manual choice (Settings → Language)

1. Open Settings → Language. The picker lists each language in its own script, with 43 entries. Check the order and that names are readable.
2. Pick a language that differs from the phone language. The app changes at once.
3. Close the app completely and reopen: the choice stays.
4. Choose "follow system" again: it goes back to the phone language.
5. Pick Chinese: you should see **both** "简体中文" and "繁體中文". Pick Portuguese: **both** "Português (Brasil)" and "Português (Portugal)".

## 3. Screens to look at in each of the 8 test languages

Arabic, Urdu, Hindi, Tamil, Thai, Japanese, Traditional Chinese, German.

- **Home:** note and notebook list, empty state, the new-note and new-notebook buttons.
- **Notebook screen:** title bar, note menu (rename, move, edit, export, share, delete), banner at the bottom.
- **Editor:** toolbar labels, paper style picker, typing mode, handwriting mode, back to Home.
- **Settings:** every row, including Reminders, Biometric lock, Language, Privacy choices (only if shown), Rate, Share, links, debug log.
- **Premium (Remove Ads):** scroll to the bottom; the purchase and Restore buttons must be reachable. Repeat at the largest font size.
- **Dialogs and messages:** delete confirmation, rename dialog, "saved" and error snackbars, the empty-state titles.

For each screen note:

- text cut off or overlapping
- boxes (tofu) or a different font in the middle of a word
- wrong direction (RTL languages should mirror icons, lists and back arrows; numbers stay left-to-right)
- a button whose words do not tell you what it does

## 4. Layout stress

- Largest system font size, then open Home, Settings and Premium in German, Tamil, and Arabic.
- A narrow phone or split-screen if you can.
- Dark mode and light mode for one RTL and one Indic language.

## 5. Export

- Make a note with Hindi or Japanese text and export as **PDF**. Open it in the phone's viewer and in Google Drive / Files. Text must be drawn correctly (it is an image page).
- Make a **handwriting** note and export as PDF.
- Make a long non-Latin note (about 50 pages if you can paste enough text), export as PDF, and watch for a crash or a very long wait. This exercises the new writer and the memory fix.
- Export a plain English note as PDF and TXT (uses the other, text-based path).
- Share as text from a note menu.

## 6. Reminders and notifications

- Turn on the daily verse reminder: the permission prompt wording should be in the app's language.
- Android: Settings → Apps → Atrament → Notifications: the channel name and description should be in the app's language, not English.
- Wait for (or set the time to a minute ahead) a reminder notification; tap it.

## 7. Lock and prompts

- Turn on biometric lock; the prompt and error texts should be translated.
- **iPhone only (needs an iOS build):** the Face ID prompt text, and the tracking permission prompt (appears after the first saved note), should be translated and the Face ID text must not mention a fingerprint.

## 8. Ads and consent (only meaningful with real ad IDs)

Until real AdMob IDs and a published consent message exist, only Google test ads appear and the consent form never shows.

- Banner shows on the notebook screen and Settings, **not** on Home, the editor or Premium.
- A full-screen ad appears no more than once every 9 minutes after counted actions (save, create, export, delete, Edit, share text, paper style, returning from Settings or a notebook). Do ten quick actions: no ad inside 9 minutes of the last one; the ad should come on the first action after the gap.
- Buy / restore "Remove Ads": banners and full-screen ads stop.
- Privacy choices row (EEA/UK only) reopens Google's form.

## 9. Reviews

The in-app review sheet appears after 20 saves on 3 different days, at most every 60 days, and the OS may decline to show it. Hard to test; just confirm the Rate row in Settings opens the store page (iOS needs the real App Store ID first).

## What to send back

One line per problem, like this:

`Language / screen / what is wrong / screenshot`

Example: `Tamil / Settings → Reminders / the word on the toggle is cut off / (screenshot)`

Also tell me which phone, Android or iOS version, and the font size setting you used.
