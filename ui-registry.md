# Prototype UI patterns

## Companion panel, conversation panel and controls

Source: public/index.html, public/style.css. Updated 28 September 2026.

| Property | Pattern |
|---|---|
| Page background | Warm off-white #f5f4ef |
| Panels | #fffefa; companion panel #eaf0e5 |
| Border | 1px solid #dce2d8 |
| Radius | Panels 24px; buttons/text fields 12px |
| Primary text | #243b3a; Segoe UI with Arial fallback |
| Secondary text | Muted green-gray #536760 to #677975 |
| Primary action | #254e43 with white text; hover #173b31 |
| Focus | 3px #bf8654 outline, offset 3px |
| Spacing | Panel padding 26–28px, layout gap 22px |
| Status | Text label plus color; polite live region |
| Disabled | Opacity .45 and explicit disabled attribute |

Use textContent for user/provider text. Keep the distinction between local microphone testing and configured online service visible. Preserve keyboard navigation and visible focus. No auto-recording or automatic cloud upload.

## Robot conversation dashboard

Source: public/robot-dashboard.html. Updated 17 October 2026.

Uses the existing warm #f5f4ef background, #fffefa cards, #eaf0e5 active/reply panels, #243b3a text, #536760 secondary text, 1px #dce2d8 borders, 24px card radius, 26px padding and 22px gaps. Green #254e43 plots actual microphone RMS; dashed amber #b07b3b marks the capture threshold. Status always has text, stale data is explicitly labelled, and graph gaps remain gaps. Timers use tabular numerals. User/provider text uses textContent. Status is a polite live region; details has a visible #bf8654 keyboard focus outline.

This robot dashboard observes the user-authorized auto-listening ESP32 through USB; it never requests the laptop microphone. Read-only browser state is loopback-only. No fabricated telemetry, response-time estimates, credentials or raw audio are displayed. Current transcript/reply are memory-only and expire after five minutes.
