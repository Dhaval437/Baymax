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

When reply text exists but synthesis is still running, explicitly show “Reply text ready — creating its audio…” so text availability is not confused with speaker readiness.

## Phone connection and update page — 18 October 2026

Source: public/phone-setup.html, embedded in firmware/MiniBaymax/SetupPage.h by assembly/prepare-phone-setup.mjs.

Uses the established #f5f4ef background, #fffefa panels, #243b3a primary text, #536760 secondary text, 1px #dce2d8 borders and #eaf0e5 status surfaces. Cards have 24px radius/padding; fields/buttons have 12px radius and minimum 48px touch targets. Primary actions are #254e43, hover #173b31. Focus is 3px #bf8654 with 3px offset. Error notices use #fff0e7 with #713b22 text. Segoe UI/Arial, 27px title, 20px panel headings, 16px body, 13px helper text. Numbered setup sections have small uppercase labels.

Status always includes text and polite live feedback. All robot/network text uses textContent. Explicitly distinguish Wi-Fi connection from a reachable conversation server. Passwords remain in memory only and are cleared after submission/locking; no localStorage, analytics, fonts or remote scripts. Design-preview mode must be conspicuously labelled and disable controls. The phone page uses separate setup authentication; it does not expose the conversation token.
