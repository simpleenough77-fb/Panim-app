# CLAUDE.md — Panim (iPhone/iPad)

Panim: free, open-source, noncommercial, ad-free, accessibility-first, privacy-by-default app that organizes communication around people (recognize a person → choose a clear action → hand off to a supported provider). Sole maintainer: Avi. Separate from FlexBets. Exact lines: "The people who matter. One tap away." · "Built for our parents. Free for yours." · "People, not apps."

Status: M2 foundation. Read `README.md` first; planning documents live outside this repo in `Panim-Development/WS-01-Foundation-2026-10-05-v1/` (architecture 03, data/threat model 04, provider ledger 05, milestones 06, status 07).

Rules
- Priority: safety → accessibility → privacy/security → simplicity → reliability → maintainability → polish.
- No accounts, backend, sync, analytics, ads, tracking, learning/AI, or third-party dependencies unless a recorded decision says so. Request no permission unless the feature needs it, at point of need, with a manual path when denied.
- Never log contact data, message bodies, photos, secrets or recipient-bearing URLs. Synthetic fixtures only; no real calls/messages without Avi's explicit intent.
- A launched handoff is not a completed call. Model unknown honestly; no fabricated success; no silent fallback to a chargeable route; no private APIs.
- Accessibility is acceptance: labeled large targets (48 pt min, 56 pt primary, 8 pt gap), real Dynamic Type incl. accessibility sizes, VoiceOver semantics, focus restoration, reduced motion, contrast, RTL-safe layout. Missing physical-device evidence = UNVERIFIED, never "passed".
- Brand: approved assets byte-for-byte; never redraw/retype/recolor; keep notices; tokens from `brand/panim.tokens.json`.
- Small changes, acceptance criteria before code, meaningful tests, docs with the change. Never bypass a failing check.
- Do not push, publish, change repository settings, submit to a store, or contact anyone unless Avi asks for that exact action. Preserve existing files.
- Labels: CONFIRMED DECISION, OBSERVED IMPLEMENTATION, PROPOSAL, HISTORICAL/SUPERSEDED, UNKNOWN. Provider statuses: UNVERIFIED, DOCUMENTED, PROTOTYPED, DEVICE_TESTED, UNSUPPORTED.
- Verify the date with a tool before date-stamping.

Commands: only those in README "Commands that have been run successfully". Add new ones only after running them.
Software license: Apache-2.0 (brand assets and font excluded; see NOTICE). Open decisions: contributor policy (CONTRIBUTING.md is a minimal proposal), bundle ID/signing, Android minimum SDK, first-release languages, backup stance, Jira key/CI.
