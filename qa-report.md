# Mobile QA Report: iPhone 14 (390x844)

## Top 5 Issues
1. `index.html:126 .tabs` - Sticky tabs use `top:52px`, but the mobile `.countdown-bar` can wrap taller than 52px, so the countdown and tabs overlap while scrolling. Suggested CSS fix: in the mobile media query, set `.tabs{top:74px}` or define a shared `--countdown-h` value and use `top:var(--countdown-h)`.
2. `index.html:215 .check` - Checklist tap square is `28x28px`, below the 44px Apple HIG target. Suggested CSS fix: `.check{width:44px;height:44px}` and `@media (max-width:640px){.donow{grid-template-columns:44px 1fr}}`.
3. `index.html:251 .chip` - Filter chips are too short for touch because they only have `padding:6px 12px` around 11px text. Suggested CSS fix: `.chip{min-height:44px;padding:10px 12px}`.
4. `index.html:323 .redeem-btn` - Redeem buttons are visually button-like but likely under 44px tall with `padding:5px 9px`. Suggested CSS fix: `.redeem-btn{min-height:44px;padding:10px 12px}`.
5. `index.html:230 .donow-meta`, `index.html:304 .stop-tc`, `index.html:353 .cluster-time`, `index.html:366 .cluster li span` - Several body/support text areas are below 13px (`11px`, `12.5px`, `10px`). Suggested CSS fix: raise mobile support copy to at least `13px`, keeping only badges/labels below that if intentionally decorative.

## Pass / Fail By Tab
- Do now: FAIL - sticky overlap risk plus `.check`/inline link tap targets.
- June 7 plan: FAIL - sticky overlap risk plus `.chip`, `.redeem-btn`, and 12.5px terms text.
- Route map: FAIL - sticky overlap risk plus 10px cluster metadata.
- Skipped: FAIL - sticky overlap risk plus 10px skip status labels.

## Summary
Browser execution was blocked by the macOS sandbox before Chromium could load, so `/tmp/qa-screens/` screenshots could not be produced.
Static selector audit shows no likely 390px horizontal overflow: `.hero-grid`, `.donow`, `.timeline`, and `.skip-row` all have mobile-friendly collapse rules.
The actionable mobile failures are narrow CSS fixes: sticky tab offset, tap-target heights, and sub-13px supporting text.
