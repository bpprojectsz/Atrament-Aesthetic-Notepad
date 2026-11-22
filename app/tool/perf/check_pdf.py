"""Independent check of a probe PDF: reads it back with pypdf and compares
every page's pixels with the checksums the Dart probe wrote.

usage: check_pdf.py file.pdf file.hashes
"""
import sys

from pypdf import PdfReader

pdf_path, hashes_path = sys.argv[1], sys.argv[2]
expected = [int(x) for x in open(hashes_path).read().split()]


def fnv1a(data: bytes) -> int:
    h = 0x811C9DC5
    for b in data:
        h ^= b
        h = (h * 0x01000193) & 0xFFFFFFFF
    return h


reader = PdfReader(pdf_path)
pages = reader.pages
assert len(pages) == len(expected), f"pages: {len(pages)} != {len(expected)}"
for i, page in enumerate(pages):
    images = page.images
    assert len(images) == 1, f"page {i}: {len(images)} images"
    image = images[0].image.convert("RGB")
    assert image.size == (893, 1263), f"page {i}: size {image.size}"
    box = [float(v) for v in page.mediabox]
    assert abs(box[2] - 595.276) < 0.01 and abs(box[3] - 841.89) < 0.01, box
    got = fnv1a(image.tobytes())
    assert got == expected[i], f"page {i}: pixels differ ({got} != {expected[i]})"
print(f"OK: {len(pages)} pages read back with identical pixels")
