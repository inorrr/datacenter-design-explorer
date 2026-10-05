# Architecture and API contracts
Browser React five pages → same-origin Vinext Worker routes → centralized prepared D1 repositories. Adviser adds server-only OpenAI Responses calls. Dispatcher owns `/signin-with-chatgpt`, `/signout-with-chatgpt` and `/callback`; the app owns no passwords or tokens. Private hosting audience is distinct from registration/roles. SIWC sign-in identifies a user; course registration persists viewer access only, except the explicitly deployment-allowlisted initial administrator.

`app/api/[...path]/route.ts` delegates all routes to `lib/server/api.ts`. `{request_id,data,meta}` success; `{request_id,error:{code,message}}` app failures. Platform access/origin rejection may be plain text before the Worker. All app errors are sanitized, no provider bodies/stack traces. No-store on app API responses.

| Route | Method | Access / contract |
|---|---|---|
| health | GET | Minimal health/model |
| snapshot | GET | Current design, countries, sources, claims, metric history, evidence hash |
| countries | GET | Three seeded countries |
| countries/:id/metrics | GET | Versioned country metrics |
| design | GET | Current D1 design |
| evidence | GET | Claims/sources/metrics; UI filtering |
| scenarios/evaluate | POST | Visitor: strict allowlisted inputs, optional expected_revision and include_sensitivity; returns custom/base/delay/half, hash/revision/model |
| register | POST | SIWC identity; course_section + rules_agreed=true; role/team/identity browser fields rejected, idempotent viewer |
| me | GET | SIWC identity; registration/role/AI availability |
| seed | POST | Admin; idempotent stable seed keys, separate from migrations |
| evidence/sources | POST | Editor/admin; HTTPS URL, publisher/title/scope/limitations + reason; records human review attribution |
| evidence/metrics | POST | Editor/admin; country/name/finite nullable value/approved unit/period/source/definition/limitation/reason; optional supersedes_id |
| evidence/claims | POST | Editor/admin; allowlisted type/text/source_ids/rationale/uncertainty/reason; optional country/supersedes_id |
| evidence/refresh | POST | Editor/admin; adapter_id=worldbank-renewables only; bounded timeout, no arbitrary URL; preserve old timestamps on error |
| design | PATCH | Admin; expected_revision + reason + strict canonical IT/PUE/country inputs; optimistic revision, 409 conflict |
| users/:id/role | PATCH | Admin; same-team role; atomic last-admin protection |
| adviser | POST | Registered viewer/editor/admin; question <=2000 characters, <=6 conversation turns, serialized <=12000 chars; current snapshot each request |
| maintenance | GET | Editor/admin; refresh/audit; AI token aggregate for admin only |

401 missing identity; 403 unregistered/role/team denial; 400 validation; 409 stale revision/last admin; 429 adviser rate; 503 DB/upstream/provider/grounding unavailable. Platform strips forged identity headers in local simulation; production trusts only Sites dispatcher headers. Same-origin write check prevents cross-site writes. D1 source FK checks and validated source lists preserve citations. No public users/audit/AI usage views.

## Adviser
Authorize → persistent ten-requests/ten-minutes check → insert usage start → retrieve exact current D1 snapshot → untrusted evidence delimiters + fixed instructions → server Responses API → up to five read-only calls → structured citation validation (source and linked claim) → one correction at most → persist actual usage → answer. Tools: current design, country metrics, claims, source details, deterministic energy, approved last-valid external observations. The external tool reads stored observations with a fallback disclosure; only editor refresh writes externally fetched data. No arbitrary SQL/URL/filesystem/write tools. 30-second total timeout, 1000 output tokens; records capped by request/retrieval size. An invalid or unsupported citation is refused. Certification is out of scope. No transcript retention. UI uses safe text rendering and only validated HTTPS sources.

## Persistence and recovery
Schema in db/schema.ts; generated migrations in drizzle/, never runtime DDL. Data seed is separate and idempotent. Mutations and audit metadata are batched. Old claims and metrics retained; canonical revisions snapshot exact evidence IDs. Deployment archives use verified pushed commit. Revert by publishing known-good source; database histories remain. Re-run seed safely to fill missing keys, never rewrite an applied migration.

## Diagrams
Editable physical system and application architecture sources in submission/. Physical capacity and failure paths are concepts, not engineered/validated ratings. Browser request walkthrough in submission/request-walkthrough.md.

Adviser retrieval capped to 30 claims/metrics/sources each, complete request serialized character cap36,000 (conservative proxy for12,000 tokens), six recent turns, maximum5 read-only tools. Fixture orchestration tested by injected fake provider; no production mock toggle exists. AI_TOKEN_TARGET gives a soft warning, AI_ENABLED=false blocks calls. Exact semantic prompt-injection resistance requires real-provider tests.
