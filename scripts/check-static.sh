#!/bin/sh
# Static privacy checks for the app sources (no network code, no secrets-looking strings).
# Usage: sh scripts/check-static.sh   (run from the repository root)
set -u
fail=0
echo "== network APIs in app sources"
if grep -rEn 'URLSession|NWConnection|NWPathMonitor|CFNetwork|WKWebView|URLRequest|https?://' Panim --include='*.swift'; then
  echo "FOUND network-related code in Panim/ (review it against the privacy rules)"; fail=1
else echo "none"; fi
echo "== permission usage strings in project settings"
if grep -En 'UsageDescription' Panim.xcodeproj/project.pbxproj; then echo "FOUND"; fail=1; else echo "none"; fi
echo "== obvious secret patterns (limited interim scan; use gitleaks before any push)"
if grep -rEIn --exclude-dir=.git --exclude='*.png' --exclude='*.ttf' --exclude='*.pb' \
  -e 'AKIA[0-9A-Z]{16}' -e '-----BEGIN [A-Z ]*PRIVATE KEY-----' -e 'ghp_[A-Za-z0-9]{30,}' -e 'xox[abp]-[A-Za-z0-9-]{10,}' -e 'sk-[A-Za-z0-9]{20,}' . ; then
  echo "FOUND"; fail=1; else echo "none"; fi
[ "$fail" -eq 0 ] && echo "STATIC CHECKS PASSED" || echo "STATIC CHECKS FAILED"
exit "$fail"
