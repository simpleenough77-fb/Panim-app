#!/usr/bin/env python3
"""Build docs/BRAND-ASSET-MAP.json: for every brand file copied into this project, record the source path
inside Brand v1.0.1, its SHA-256 as listed in the approved MANIFEST.json, the SHA-256 of the destination copy,
and whether they match. Read-only on Brand. Usage: make-brand-map.py <brand-release-dir> <project-dir>"""
import hashlib, json, sys
from pathlib import Path
rel, proj = Path(sys.argv[1]), Path(sys.argv[2])
manifest = json.loads((rel / "MANIFEST.json").read_text())
listed = {r["path"]: r["sha256"] for r in manifest["files"]}
pairs = [
 ("platforms/ios/PanimIcons.xcassets/Contents.json", "Panim/PanimIcons.xcassets/Contents.json"),
 ("platforms/ios/PanimIcons.xcassets/AppIcon.appiconset/Contents.json", "Panim/PanimIcons.xcassets/AppIcon.appiconset/Contents.json"),
 ("platforms/ios/PanimIcons.xcassets/AppIcon.appiconset/panim-any-1024.png", "Panim/PanimIcons.xcassets/AppIcon.appiconset/panim-any-1024.png"),
 ("platforms/ios/PanimIcons.xcassets/AppIcon.appiconset/panim-dark-1024.png", "Panim/PanimIcons.xcassets/AppIcon.appiconset/panim-dark-1024.png"),
 ("platforms/ios/PanimIcons.xcassets/AppIcon.appiconset/panim-tinted-1024.png", "Panim/PanimIcons.xcassets/AppIcon.appiconset/panim-tinted-1024.png"),
 ("tokens/fonts/Atkinson.ttf", "Panim/Resources/Fonts/Atkinson.ttf"),
 ("tokens/fonts/Atkinson.OFL.txt", "Panim/Resources/Fonts/Atkinson.OFL.txt"),
 ("tokens/fonts/Atkinson.METADATA.pb", "notices/Atkinson.METADATA.pb"),
 ("tokens/fonts/SOURCES.json", "notices/SOURCES.json"),
 ("ASSET-LICENSE.md", "notices/ASSET-LICENSE.md"),
 ("THIRD-PARTY-NOTICES.md", "notices/THIRD-PARTY-NOTICES.md"),
 ("tokens/panim.tokens.json", "brand/panim.tokens.json"),
 ("MANIFEST.json", "brand/BRAND-v1.0.1-MANIFEST.json"),
]
rows, ok = [], True
for src, dst in pairs:
    d = hashlib.sha256((proj / dst).read_bytes()).hexdigest()
    s = listed.get(src)  # MANIFEST.json itself is not listed; compared to pinned manifest hash below
    if src == "MANIFEST.json":
        s = "618d01ba5440289630caef6303b5d11cced2565ce6b61e144f37f26b68b2970d"
    match = (s == d)
    ok &= match
    rows.append({"source": "Panim-Brand/releases/v1.0.1/" + src, "source_sha256_per_manifest": s, "destination": dst, "destination_sha256": d, "identical": match})
out = {"brand_release": "1.0.1", "manifest_sha256": "618d01ba5440289630caef6303b5d11cced2565ce6b61e144f37f26b68b2970d",
       "all_identical": ok, "files": rows,
       "note": "Bytes copied unchanged. Wordmark not used in the app yet. Tokens are copied for reference; translation to native resources happens in M3."}
(proj / "docs" / "BRAND-ASSET-MAP.json").write_text(json.dumps(out, indent=2) + "\n")
print("all_identical:", ok, "files:", len(rows))
sys.exit(0 if ok else 1)
