# Datacenter Design Explorer
Course decision-support application implementing PRD 1.1 for Ireland, Finland and Canada. Five routes, versioned D1 evidence/design, Sites Sign in with ChatGPT, viewer/editor/admin roles, deterministic 10-year scenarios, approved World Bank refresh, protected grounded OpenAI adviser.

## Current status
See docs/implementation-log.md and docs/requirements-tests.md for observed results and outstanding gates. No datacenter Site existed; the existing Bean There Boston Site is an unrelated product and was preserved. A separate Site was registered. The investment verdict is INSUFFICIENT EVIDENCE; cost/demand/tariffs are explicit illustrative assumptions. No site or signed commitment is invented.

## Setup
Node >=22.13.0. `npm ci` (or supported Sites installer), `npm run db:generate`, `npx tsc --noEmit`, `npm run dev -- --host 127.0.0.1`.
D1 logical binding `DB` is in `.openai/hosting.json`. Production migrations in `drizzle/` are applied by Sites publish. Seed separately with admin POST `/api/seed`; it is idempotent and does not change existing records. Registration can precede seed; an allowlisted authenticated administrator initializes data.
Local: build once for Wrangler configuration, then `node --experimental-strip-types scripts/local-seed.mjs`; `npx wrangler d1 execute DB --local --config dist/server/wrangler.json --persist-to .wrangler/state --file drizzle/0000_unknown_argent.sql`; repeat command with `.sites-runtime/seed.sql`. Local Sites sign-in is explicitly simulated with `seedy@sites.test`; never deploy a header bypass.

## Verify
`npm test > reports/tests/unit.tap`
`python3 tests/schema.py`
`node scripts/integration-test.mjs` (local preview running; local identity simulation distinct from production SIWC)
`npx tsc --noEmit`
`node <Sites-plugin-root>/scripts/build-site.mjs`
Production publish uses `<Sites-plugin-root>/scripts/site-workflow.mjs` with source credential on hidden stdin, then native save/deploy. Never put publishing tokens in shell arguments, files, commits or logs.

## Server configuration
Set through Sites environment tools, never hosting.json or frontend: `OPENAI_API_KEY` secret, `OPENAI_MODEL` (gpt-4.1-mini), `ADMIN_EMAIL` secret (allowlisted trusted Sites identity), `AI_ENABLED=false` to disable provider calls, `AI_TOKEN_TARGET` soft target. OpenAI Developers plugin handles secure key creation. No API key is committed. Frontend receives availability only.

## Deliverables
`docs/` architecture/API, data sources, model, requirements/tests, PRD and chronological log. `reports/` sanitized tests/usage/refresh. `submission/` confirmed engineering package, editable diagrams, request walkthrough and video shot list. Actual two-minute recording and personal explanation require team participation. Five-minute investment presentation/two-page memo are pending instructor confirmation and are not generated.

## Public repository and live website
Live website: https://datacenter-design-explorer.yinuozhao959.chatgpt.site
This is an independent public source snapshot with a fresh initial commit. The separate Sites publishing checkout retains its history. Production secrets remain in Sites; .env.local and .dev.vars are ignored. Copy .env.example for local configuration and keep actual credentials out of Git. Anonymous visitors can read the comparison and scenarios; the adviser requires registration and trusted server-side roles. The course assignment PDF and its verbatim extracted text are excluded from this public repository.
