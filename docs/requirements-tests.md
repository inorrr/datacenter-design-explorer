# PRD 1.1 requirements and observed tests
Unit/contracts: reports/tests/unit.tap, 14 passing. SQLite schema/seed check passes (fixture, not production D1). Preview integration: reports/tests/preview-integration.json; real Vinext/D1, simulated supported local SIWC identity. Deployed results are pending publication and captured separately; no claim that mocks prove real authentication/AI.

| ID | Assignment | Implementation / observed status |
|---|---|---|
| FR01 | pp7,14–15 | Five pages, baseline energy/unknown location/uncertainties; preview observed |
| FR02 | pp7,14 | Three-country full framework, definitions/vintages/proposals/gaps; incomplete human verification |
| FR03 | pp9–13 | Ten-table D1, schema migration, idempotent seed; local reload persistence observed; production pending |
| FR04 | pp15–16 | Genuine World Bank network request verified and three observations seeded locally; ≥3 human reviews pending |
| FR05 | pp16,21 | Strict adapter, failure preservation/logging implementation; malformed contract fixture passes; deployed failure check pending |
| FR06 | pp17–18,20–21 | Visitor401 and unregistered403 observed preview; real SIWC pending |
| FR07 | pp17–18,21 | Viewer-only/idempotent registration, spoof denied, editor restrictions; local simulated SIWC; deployed pending |
| FR08 | pp18–21 | Current snapshot/citation validation implemented and fixture checked; real AI pending key |
| FR09 | pp15,21 | Exact revised PUE energy unit passes; persistent canonical conflict/revision implemented; real admin check pending |
| FR10 | p21 | Untrusted evidence policy/tool allowlist/certification boundary implemented; live injection test pending key |
| FR11 | pp2–3 | Three alternatives/base/delay/half; four required outputs/yearly costs; unit and preview pass |
| FR12 | pp2–3 | Facility/fleet separation, same workload/overflow, debt/unused-cost separation; unit pass |
| FR13 | pp2–3 | Explicit evidence-gated insufficient verdict, disclaimer, no preferred country; unit/preview pass |
| FR14 | pp2–3 | Physical system/failure paths, ownership/governance/finance; website and PDF/SVG sources |
| FR15 | pp4,22 | Docs/logs/runtime audit/refresh/actual provider usage design; real AI usage pending |
| FR16 | pp11–12,22 | Sites D1/auth/runtime config/build ready; deployed verification pending |
| FR17 | pp3,22 | Two-minute shot list and factual individual walkthrough supplied; real team video/personalization required. Memo/presentation pending instructor confirmation |

No final all-tests-pass claim until relevant deployed gates have observed reports. Read implementation-log.md current state before continuing. Core read/model errors are explicit and logs are sanitized. Tests reference actual request IDs/revision/hash without personal identifiers.

## Observed production verification (initial deployment)
Published privately at https://datacenter-design-explorer.yinuozhao959.chatgpt.site, source99ef3f7edde10eace7eae6296bdbee3057c75dc3, deploymentappgdep_6ac40e28bb2c8191aa14a20347012e00. User completed real SIWC; admin registration and idempotent seed persisted. Seven deployed service checks pass (reports/tests/deployed-service.json). Production authorized World Bank refresh returned unchanged with0 accepted and retained all prior timestamps; requestbc42bc30-73d5-4a30-b572-06216e36021e, observed234ms server duration. Scenario requests observed49–54ms server duration; tested service calculation under1s end-to-end. Desktop1440/mobile390 document widths equal viewport; screenshots saved. Evidence type filter observed; source links resolve to actual recorded URLs. Current source includes fixes awaiting final republish.

Mocked adviser suite:6 passing orchestration tests (reports/tests/adviser-mocked.tap). Tests inject fake provider responses; no production mock switch. Injection test checks policy/untrusted-data separation and refusal contracts only, not live model obedience. Live PUE/citation/injection/certification tests remain blocked on OpenAI key approval. Unit/model contract14pass; local administrator route8pass. Local preview auth is simulated; deployed browser auth above is real.

## Verified final browser persistence
Production SIWC registration/admin bootstrap and seed succeeded. S10/C20 persisted through inventory synchronization. Canonical PUE 1.4 persisted across reload at revision 2, then restored to 1.25 in immutable revision 3. No country was selected by the PUE update. Local/production APIs and mocked adviser tests are distinct; live OpenAI tests remain blocked by missing server key. HTML caching regression was reproduced and corrected with no-store HTML responses.

## Secure key and real integration follow-up
2026-10-05T21:24:48.913176+00:00 — User approved secure new-key creation and local destination. OpenAI Developers created the key for Personal / Default project, saved to ignored .env.local. Key configured as a Sites secret and applied in environment revision 2. Exposed Sites service token rotated. Deployed adviser made one actual request and failed safely; direct API diagnostic returned HTTP 429 credit_balance_exhausted / insufficient_quota. Both returned no usage, so token counts remain null rather than invented zero. Successful live answers, citations and injection evaluation remain blocked until API credits are available. No secret included in source, logs or package.

## Final credit-funded verification, 5 October 2026
Credits restored. Final published source 698b1be5a5d16567f704d0637e03191fa6083721 / deployment appgdep_6ac4174e44b481919e28f2fa216f63cf / environment revision 2. Model 1.0.0, design r3, evidence hash 5afcbcdbde653c37341bfce66afcbe8fefaa1927daba06b50bb589a0d5a45423. Three real signed-in deployed adviser journeys pass: baseline formula/revision, final-policy citation, injection refusal with PUE1.4 calculation. One real-provider local controlled injection/revised-design fixture passes (mocked repository writes explicitly separated). Seven mocked adviser regressions and eight final deployed service checks pass. Historical failures are retained. Actual reported application/test tokens: 89794; two quota-rejected requests have unknown usage. The key and rotated service token are excluded from source/exports. Human review/video/personal explanation remain team actions; memo/deck remain pending confirmation.
