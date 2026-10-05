# Global Datacenter Design Explorer — Product Requirements Document

**Version:** 1.1  
**Date:** 2026-10-05  
**Status:** Ready for implementation; research findings and investment verdict remain open  
**Primary audience:** Implementation agent and course project team  
**Primary product user:** University consortium investment committee  
**Scope:** Course-complete website with modest polish, reproducible analysis, documentation, and auditable logs

## 1. Implementation contract

Build an evidence-backed decision-support website for a university consortium evaluating shared AI infrastructure. Compare **build and own**, **lease compute**, and **phased hybrid** over ten years. Start with the assignment's **20 MW IT load, PUE 1.25, and 25 MW total facility load**. Compare **Ireland, Finland, and Canada**, with no preferred winner or investment hypothesis.

The final system must let the committee inspect the engineering concept, test bounded assumptions, trace conclusions to evidence, and ask a registered-user-only AI adviser questions grounded in current database records. The adviser explains the analysis; deterministic application code calculates it. Documentation and logs are required deliverables, not optional cleanup.

### 1.1 Authority and interpretation

1. The supplied **Lesson 06 — Build a DataCenter Challenge.pdf** is the assignment authority. Page references below use physical PDF page numbers.
2. The user's choices in this PRD establish product decisions within that assignment. The 2026-09-29 lecture transcript clarifies the immediate website/login work and API-key setup; it does not explicitly cancel the PDF's broader deliverables.
3. Additional implementation choices are specified here as defaults. Change them only when platform constraints or verified evidence justify it; record deviations in the implementation log, with an optional ADR for significant decisions.
4. Use current Sites skills and official platform documentation when implementing authentication, D1, hosting, and OpenAI integration. Conceptual snippets in the assignment are not guaranteed executable configuration.
5. Do not ask the user to reconfirm decisions already specified. Continue independent work when credentials or source access block a component; document the blocker and never mark it complete without verification.

### 1.2 Agreed decisions

| Topic | Decision |
|---|---|
| Geography | Ireland, Finland, Canada; select the preferred country only after analysis |
| Primary persona | Investment committee |
| Product balance | Approximately equal emphasis on investment and technical design |
| Initial scale | 20 MW IT × 1.25 PUE = 25 MW facility; scale is a bounded sensitivity input |
| Investment hypothesis | None; apply the same workload and model conventions to all alternatives |
| Country factors | Grid, electricity economics, policy/regulation, environment, technical suitability, connectivity, ecosystem |
| Financial interaction | Small, bounded control set and named stress cases |
| AI | Assignment-aligned, evidence-grounded Q&A with controlled retrieval and energy calculation |
| Recommendation | Explicit BUILD / LEASE / HYBRID / INSUFFICIENT EVIDENCE with rationale and limitations |
| Ambition | Satisfy the assignment cleanly; avoid extra product components |

### 1.3 Explicit non-goals

No construction-ready design, professional certification, investment-grade underwriting, autonomous investment decisions, GPU scheduler, live facility control, arbitrary web-search agent, document/vector ingestion platform, multi-agent orchestration, member billing system, complex workflow approvals, custom password authentication, or general-purpose financial modeling studio. No automated generation of final slides or memo inside the website. The standalone presentation and memo are pending instructor confirmation; do not generate them or block website completion on them until confirmed.

### 1.4 Requirement status and lecture clarification

| Category | Treatment |
|---|---|
| Website and engineering requirements | Retain the PDF's functional requirements and Step 26 engineering submission checklist; the lecture emphasizes building the website, persistent data, routes, registration, login, and roles |
| User-selected product features | Three-country set, investment-committee focus, bounded dynamic analysis, explicit limited-analysis recommendation, and documentation/log emphasis remain in scope |
| Pending course deliverables | Standalone five-minute investment presentation and two-page memo; keep tracked but do not make website acceptance depend on them |

Lecture anchors: 00:00:56–00:01:00 (website deliverable); 00:02:51–00:02:58 (Lessons 6/7 and homework build the website); 00:44–00:47 (API key creation and secret storage); 00:52:57–00:53:05 (extend existing website); 01:21:10–01:23:22 (get login working, investigate data and routes). The lecture does not prove that the presentation/memo were cancelled. Record instructor clarification if received.

## 2. Problem, objective, and definition of success

The proposal begins with expressed member interest but **no signed long-term computing commitments**. The utility connection price, required upgrades, and energization date are unknown. Universities have different training, teaching, and inference needs; ownership, allocation, and member charges are undecided. Preserve these assignment facts as evidence gaps rather than silently replacing them with optimistic assumptions.

The website succeeds when a committee can answer:

- Does demonstrated demand justify the baseline scale?
- Which country and indicative region merit further diligence, and why?
- What would the consortium own, lease, and contract for?
- What are the costs, risks, and operational consequences under the base case and required stress cases?
- Which three findings could reverse the recommendation?
- Can every material claim and calculation be traced and reproduced?

**Completion requires:** a published Sites application with persistent D1 data; three-country comparison; ten-year model; base and two required stress cases; protected AI adviser; a working genuine external API; verified evidence; successful deployed tests; and the confirmed website/engineering documentation and submission artifacts listed in §15. The standalone investment presentation and memo are pending confirmation and excluded from the website completion gate. An attractive static mockup or simulated API does not satisfy completion.

## 3. Users, access, and core journeys

Single consortium/team for the MVP. Retain `team_id` for ownership checks; do not build multi-team management.

| User state / role | Read design, evidence, scenarios | AI adviser | Add/refresh evidence | Change canonical design / roles |
|---|---|---|---|---|
| Visitor | Yes, subject to deployment audience | No | No | No |
| Authenticated, unregistered | Yes | No; show registration prompt | No | No |
| Registered viewer | Yes | Yes | No | No |
| Editor | Yes | Yes | Yes, within team | No |
| Team administrator | Yes | Yes | Yes | Yes, within team |

Public/read-only application routes must not require registration. Sites deployment audience is separate from application authorization: configure the requested course audience using supported platform controls; document if the hosting audience itself requires sign-in. Test a visitor state inside the allowed audience. Do not claim internet-public access unless deployed and verified that way.

### 3.1 Committee review

Open Overview → inspect recommendation and limitations → compare countries → inspect design/failure paths → test scenarios → open linked claims/sources → sign in and register to ask the adviser → use the findings to evaluate the proposal.

### 3.2 Evidence maintenance

Editor signs in → opens Evidence maintenance → adds a verified source/metric/claim or refreshes the approved API → server validates and persists a new version → pages show the new retrieval time → downstream analysis recomputes against that snapshot → mutation and refresh outcome are logged.

### 3.3 Baseline revision

Administrator revises canonical assumptions with a reason → optimistic version check prevents overwriting newer changes → immutable design revision is recorded → default analysis and subsequent adviser requests use the revision → change appears in the decision log. A visitor's scenario controls never mutate the canonical baseline.

## 4. Information architecture and interface

Use five top-level pages matching the assignment. Put Economics/Scenarios within Overview and technical details within Initial Design. Put small authorized maintenance forms within Evidence; do not add an admin product suite.

| Route | Required content |
|---|---|
| `/` Overview | Proposed country/indicative region or “not selected”; recommendation; evidence readiness; 20 MW IT/PUE/facility/annual-energy cards; alternatives comparison; bounded scenario controls; required stress cases; top three uncertainties; disclaimer |
| `/countries` Country Comparison | Three-country matrix; definitions, units, vintages, sources; policy constraints; grid screening; indicative regions; gaps; screening rationale |
| `/design` Initial Design | Power/cooling/network/storage/GPU block diagram; assumptions; demand-to-capacity bridge; ownership/contract split; largest-component and 48-hour grid-failure paths; governance and financing summary |
| `/evidence` Evidence | Filterable claims and metrics; sources; provenance; dates; uncertainty; authorized add/refresh forms; evidence snapshot/version |
| `/adviser` Ask the Adviser | Login/registration status; suggested questions; conversation; real source citations; facts/assumptions/unknowns; design limitation statement |

### 4.1 Shared UX rules

- Restrained typography, generous spacing, clear tables, consistent units, readable charts. No elaborate animation or decorative assets required.
- Support desktop at 1440 px and mobile at 390 px without clipped controls; wide comparison tables may scroll in a labeled region.
- Recommendation is never color-only. Evidence badges use text: fact, assumption, calculation, design decision, unknown.
- Every material number has a source/claim link or calculation explanation. Show reporting period separately from retrieval time.
- Use missing/unknown states, never a fake zero or invented estimate. A working draft may include clearly labeled assumptions with rationale.
- Show loading, empty, partial-data, stale-data, unauthorized, validation, and service-unavailable states.
- Charts: annual ten-year cash cost by alternative, cost per productive GPU-hour by case, and energy-source mix when compatible data exist. Tables remain available for exact values.
- “Reset to baseline” restores controls. Recommendation updates after a successful calculation; show which country, scenario, design revision, evidence snapshot, and model version produced it.
- Disclaimer next to verdict and on adviser: **“This analysis is limited to the evidence and assumptions shown. It provides decision support, not financial, regulatory, or engineering certification. Users and the investment committee should make their own decisions after independent review.”**

## 5. Country comparison and research requirements

### 5.1 Candidate rationale

These are research hypotheses, not verified findings or rankings:

| Candidate | Reason to investigate | Critical diligence |
|---|---|---|
| Ireland | Test a country with an established data-center market against potentially restrictive electricity-connection and permitting conditions | Current connection policy, regional capacity, renewable requirements, tariff scope, permitting, and latency to member institutions |
| Finland | Test a Nordic location where climate and energy conditions may support cooling and operating economics | Actual regional connection capacity/dates, winter vs annual energy availability, electricity prices, heat reuse feasibility, and regulatory obligations |
| Canada | Test a North American alternative with substantial provincial differences in electricity, climate, and policy | Province-specific tariffs and grid eligibility, capacity allocation, water/permitting, sovereignty requirements, network latency, and currency |

**Do not copy policy claims or numeric statistics from earlier conversation into verified records.** Verify current primary sources during implementation; policy status can change. National figures support screening; they cannot establish a site's tariff, permit, grid capacity, or connection date.

Choose one indicative region per country during research and explain the choice in a decision record. Do not fabricate a utility quote or committed connection offer. The consortium is located in whichever country is ultimately selected; cross-country comparison is location screening, not a requirement to create an international university consortium.

### 5.2 Common comparison framework

| Dimension | Required fields | Role in decision |
|---|---|---|
| Grid feasibility | Connection process, available capacity if verified, timeline, upgrades, reliability, constraint/gap | Hard feasibility screen |
| Policy and regulation | Connection rules, permits, planning/zoning, data protection/sovereignty, environmental assessment, applicable incentives/obligations | Hard screen where relevant; costs and risks otherwise |
| Electricity economics | Large-user tariff or labeled proxy, tariff date, energy/network charges, currency, taxes included/excluded | Model input with limitations |
| Energy and carbon | Generation mix, reported carbon intensity, annual vs hourly coverage | Environmental screening; no claim of 24/7 matching from annual data |
| Cooling and water | Climate proxy, cooling concept, water requirement/availability, restrictions | Technical suitability and constraint |
| Existing ecosystem | Reported data-center count, reported capacity or electricity consumption, definition and coverage | Required comparison evidence; incompatible counts must be labeled |
| Connectivity/security | Network concept, indicative latency, data locality and security needs | Workload suitability |
| Delivery/economics | Land/construction estimate, staffing, ownership/lease options, regional comparability | Cost and deliverability |

Display all dimensions; avoid an opaque weighted country score. Use `pass / conditional / fail / unknown` for feasibility, with citations and explanations. Mark unknown electricity/grid/policy findings explicitly. A preferred country may be a **conditional research preference**, never a claim of site readiness.

### 5.3 Evidence minimum and freshness

Assignment minimum: at least **three human-verified source records overall** and **one genuine external API**. Product target: at least one primary-source policy/grid record and one energy/electricity record for each country, plus demand and cost assumptions. Report unmet targets rather than inventing coverage. Include Epoch AI (`https://epoch.ai`) in the research source inventory where relevant, as suggested by the assignment.

Source preference: utilities/grid operators/regulators; official statistical agencies; government permitting and policy documents; published provider pricing; reputable research with clear definitions. Record publication/effective dates and retrieval time. Define freshness thresholds per metric in the data dictionary; historical annual data are not “stale” solely because they were published last year. Distinguish aged evidence, failed latest refresh, and known policy changes.

Use a single low-complexity energy-data adapter first. Candidate: World Bank API for country electricity-generation indicators if its actual response, coverage, and definitions meet the requirement; otherwise choose another documented official/approved energy API. The implementation agent must verify a real request and record the exact endpoint, parameters, license, response shape, available years, units, and limitations. The PRD does not assert that a particular indicator is available. Avoid adding several adapters unless the first cannot provide meaningful coverage.

## 6. Demand, design, financing, and governance

### 6.1 Demand-to-capacity bridge

Represent training, teaching, and inference in a small demand table: institution or anonymized group, workload type, annual productive GPU-hours, concurrency, availability/security requirements, commitment status, source/assumption, and limitation. Do not invent signed members or commitments. Sum annual demand and explain workload compatibility with the chosen reference GPU class.

Choose one reference GPU class and equivalent leased service for the MVP. Record per-GPU system power including allocated host/network power; installed count; usable fraction; productive utilization; memory/interconnect/storage expectations; replacement cycle; and comparability limitations. Do not equate differently capable GPU-hours without a documented adjustment. If equivalent service pricing is missing, cost ranking is incomplete.

Explain how demand maps to IT load and why 25 MW might be oversized or appropriate. Include capacity reserved for small institutions and training-vs-teaching priority as policy assumptions; no live scheduling implementation.

### 6.2 Engineering concept

Cover utility/grid intake; transformers/distribution; UPS ride-through; backup generation/fuel; cooling; GPU racks; storage; network paths. For each, store concept, capacity assumption, redundancy, ownership/contract party, supporting claims, and unresolved validation. Initial design must include both a physical block diagram and a failure-path explanation.

Required failure cases:

1. **Largest electrical component failure:** identify the largest component, assumed redundancy, affected load, failover path, recovery, and unverified limits.
2. **48-hour grid outage:** identify power/fuel/cooling support, load shedding, critical vs full workload availability, fuel resupply dependencies, and restart/backlog effects. Do not infer 48-hour operation from a short UPS duration.

If onsite solar, wind, gas, or storage is proposed, show capacity, dispatchable contribution, duration/fuel limit, assumptions, and hourly adequacy gaps. Annual generation alone does not prove uptime. Record data needed to verify the uptime target: hourly load/generation, outage frequencies, dispatch/maintenance, equipment failure/failover, and fuel/cooling/network continuity.

### 6.3 Construction and procurement timing

Record a small milestone table for permitting/site work, grid offer and energization, construction completion, GPU order/delivery/installation, backup equipment, and service opening. For each record the timing assumption/source, dependency, uncertainty and effect of delay. Explain which technology assumptions may change before commissioning and why procurement need not occur immediately. Keep hardware purchases and financing draws aligned with the model's documented timeline; no project-management scheduler is required.

### 6.4 Ownership, finance, and governance

Use concise tables rather than extra interactive systems:

- For each alternative, specify who owns facility and GPU fleet, who supplies operations/grid/cooling/network, and who bears delay, utilization, and member-withdrawal risk.
- Identify evidence needed before development equity, construction debt, and equipment financing: member commitments, site/permit diligence, utility offer, cost estimate, lender terms, and hardware/vendor terms.
- Propose allocation quotas/reservations, overflow access, usage-based member pricing, protections for smaller institutions, new-member admission, and conflict resolution. All are design decisions, not approved agreements.
- Include existing university/commercial capacity and distributed compute as alternatives, and impacts on ratepayers, energy, water, and permitting.

## 7. Deterministic financial and energy model

### 7.1 Model boundary and reproducibility

Educational ten-year cash-cost model, not investment-grade forecasting. Use one shared calculation library in browser preview, backend, adviser energy tool, tests, and submission exports. Backend is authoritative. Pure functions return yearly rows, totals, assumptions, limitations, and recommendation inputs. Reject NaN, infinity, incompatible units, and missing required inputs.

Time convention: `t=0` development/pre-opening; `t=1..10` years after the common decision date. Record commissioning at month granularity for the initial delay. All alternatives satisfy the same annual productive workload; add leased overflow/bridge where owned capacity is inadequate. Never lower demand simply to make a smaller facility cheaper.

Base currency: USD, constant prices at a documented reference year. Convert local tariffs using a dated FX source/assumption and show the original currency. No inflation, taxes, salvage value, or grants unless explicitly documented; baseline salvage and grants are zero assumptions. Discount rate is visible but fixed in the MVP; it is not automatically a debt interest rate.

Freeze `model_version`, `design_revision`, `evidence_snapshot_id`, canonical inputs, normalized scenario inputs, assumptions IDs, and deterministic input hash for every saved report/test fixture. Missing critical inputs yield partial outputs and INSUFFICIENT EVIDENCE, not a fabricated complete model.

### 7.2 Bounded controls

Controls apply only to the visitor's scenario; the administrator edits the canonical baseline separately. Bounds are product constraints, not sourced engineering limits.

| Input | Default | Allowed range / step |
|---|---|---|
| IT load | 20 MW | 5–30 MW; 1 MW steps |
| Productive GPU utilization | Research-backed or labeled baseline assumption `u0` | 10–90%; 5 percentage-point steps; exact `u0/2` permitted in stress case |
| PUE | 1.25 | 1.10–1.60; 0.05 steps |
| Electricity-price multiplier | 1.00 × country tariff/proxy | 0.50–2.00; 0.10 steps |
| GPU acquisition-cost multiplier | 1.00 × documented base | 0.75–1.50; 0.05 steps |
| Facility construction-cost multiplier | 1.00 × documented base | 0.75–1.50; 0.05 steps |
| Grid delay | 0 months relative to baseline opening | 0, 6, 12, 18, 24 months |

Expose country selection separately. Keep rates, GPU type, hybrid ownership share, refresh schedule, staffing model, and power profile as visible fixed assumptions. Do not add controls without documenting a requirement and scope tradeoff. Clearly say “25 MW facility baseline” rather than labeling 20 MW IT as the facility rating.

### 7.3 Power and workload equations

For the assignment's nameplate/full-load calculation:

```text
facility_power_mw = it_load_mw * pue
annual_nameplate_energy_gwh = facility_power_mw * 8760 / 1000
baseline = 20 * 1.25 * 8760 / 1000 = 219 GWh/year
```

Actual operating electricity must not blindly equal nameplate electricity or scale directly with GPU utilization. Use a documented simplified idle/active profile:

```text
average_it_mw = installed_it_mw * (idle_power_fraction + (1-idle_power_fraction) * utilization)
operating_energy_kwh = average_it_mw * pue * operating_hours * 1000
```

This is a coarse assumption, not a measured power curve; show nameplate and modeled consumption separately. For owned installed GPUs:

```text
installed_gpus = floor((installed_it_mw * 1000 - non_gpu_it_kw) / system_kw_per_gpu)
available_gpu_hours = installed_gpus * usable_fraction * available_hours
productive_owned_hours = min(demand_hours, available_gpu_hours * utilization)
leased_overflow_hours = max(0, demand_hours - productive_owned_hours)
```

Require nonnegative remaining GPU power budget and separately defined scheduled/available hours; availability must not be counted twice. Document the simplified uniform GPU fleet and throughput limitations. Baseline demand may be derived from capacity × `u0` only as a labeled planning assumption; it is not demonstrated member demand. In the half-utilization case, productive demand is half the baseline forecast with the installed fleet unchanged; recalculate profile electricity and overflow accordingly.

### 7.4 Three alternatives

| Alternative | Common treatment |
|---|---|
| Build and own | Full selected installed capacity after commissioning; own facility and GPU fleet; lease bridge/overflow to meet demand where needed |
| Lease compute | No owned facility/GPU capital; equivalent rented productive hours plus documented storage/network/support/egress/reservation costs |
| Phased hybrid | Initial owned module at 50% of selected capacity; lease bridge and overflow; fixed planned expansion to full capacity at the start of year 4 |

Use this simple fixed hybrid schedule as a labeled planning assumption, not an optimized strategy or preset winner. No utilization trigger or incremental-cost threshold is required. Document the 50% initial module, year-4 expansion, commissioning/connection dependencies, and tranche costs. Apply the same delay and demand assumptions consistently; report unused expansion capacity under the half-utilization case. If grid availability prevents scheduled expansion, defer commissioning and retain leased coverage. Do not count a replacement fleet and an expansion fleet twice for the same GPUs.

### 7.5 Costs, financing, and output definitions

Separate facility and fleet costs. Yearly rows must include facility construction, grid upgrades, GPUs, other IT/network/storage, electricity, staffing, maintenance, lease/bridge/overflow, replacement, financing charges, and total. Show non-GPU IT replacement assumptions as well. Apply GPU replacement at the documented age of each installed tranche; avoid a universal replacement year that ignores commissioning/expansion.

Financing: fixed documented debt share, interest, tenor, and draw convention. Return gross project cash outlays and a separate funding schedule (equity draws, debt draws, interest, principal, outstanding balance). Do not count capex plus debt principal twice in total economic cost. Economic cash cost counts assets/operations plus financing charges, excluding debt draws and principal transfers. Show funding requirements separately; document simplifications and unverified lender terms.

Required outputs for every alternative and case:

- **Cash before opening:** gross cash outlays up to owned commissioning, including development/construction, equipment, grid, carrying charges, and leased bridge. For lease-only use service commencement and state the different interpretation. Also show equity funding before opening separately.
- **Annual operating cost:** yearly recurring electricity/staffing/maintenance/leased service costs. Show replacements and financing separately, plus a representative operating-year total; do not hide the yearly series.
- **Cost per productive GPU-hour:** undiscounted total ten-year economic cash cost / total productive hours delivered over the same horizon. Also show discounted cost/discounted hours as a separately labeled levelized metric. Zero hours => unavailable, never zero cost.
- **Capital at risk:** owned capital committed through commissioning less assumed recoverable value, plus non-cancellable lease commitments. State recoverability and cancellation assumptions. This is an exposure proxy, not expected loss; do not mix it with operating expenditure or silently infer residual values.
- Ten-year undiscounted total, discounted cost, annual productive hours, capacity/unused hours, owned vs leased split, unmet hours, energy, and model limitations.

Unused-capacity cost is an **allocation within existing fixed ownership cost**, not an extra charge added to totals. Show `(1 - realized_owned_utilization) × attributable_fixed_ownership_cost` as a labeled proxy with the allocation convention.

### 7.6 Required cases and sensitivity

1. Base case: current canonical country/design/cost assumptions.
2. Grid delay: full grid power arrives **12 months later**. Hold workload constant, move owned commissioning/capex timing, add carrying cost and leased bridge, shorten owned operating years within the same decision-date horizon.
3. Half-utilization: productive workload is **50% of forecast**, installed capacity remains unchanged, and fixed costs remain. Recompute idle/active electricity and lease consumption; no automatic halving of staffing/capex.

Keep required cases separate from the custom scenario and calculate them for all three alternatives. Show a table with all four mandated outputs and changed recommendation. Run a deterministic one-at-a-time sweep across the existing control bounds to identify up to three recommendation-changing inputs and threshold intervals. If no reversal occurs, say so; do not invent three tipping points. Distinguish sensitivity drivers from the three material evidence gaps shown on the website.

## 8. Recommendation and evidence readiness

Recommendation is generated by deterministic rules, never chosen by the LLM. Include recommended strategy, indicative country, rationale, runner-up, top three uncertainties, assumptions, stress outcomes, and disclosure. Financial ranking is by discounted cost for equivalent delivered workload; feasibility and evidence gates take precedence.

Simple recommendation procedure:

1. Validate model inputs, equivalent delivered workload, and decision-critical evidence. Show missing/conflicting information and feasibility states explicitly.
2. Compare discounted costs for alternatives that satisfy the same workload and pass applicable feasibility checks. Show capital exposure, pre-opening cash, and stress results alongside cost rather than embedding them in an opaque score.
3. Return BUILD, LEASE, or HYBRID when a defensible preference exists; state whether it is conditional. If critical gaps prevent a defensible comparison, return INSUFFICIENT EVIDENCE while retaining any valid partial results.
4. Do not use an arbitrary percentage near-tie rule or automated multi-stage tie-breaker. Show close costs transparently and describe tradeoffs; an unresolved exact tie returns INSUFFICIENT EVIDENCE with the tied options. Numeric precision is not evidence of certainty.
5. Report changes under the required stress cases. Keep the recommendation in application code or a documented, versioned team decision supported by computed results; the adviser cannot independently change it.


“Evidence readiness” is separate from model-based ranking: `limited / adequate for screening / decision-critical gaps`. It is a checklist, not a probability or LLM confidence. Signed demand commitments and an actual utility offer are investment approval requirements; their assignment-level absence means a researched recommendation can remain conditional and final approval readiness is incomplete. Initial product baseline should therefore show INSUFFICIENT EVIDENCE until a defensible screening comparison exists; never seed a predetermined HYBRID verdict.

## 9. Persistence and data contracts

Use Sites server-backed execution with Cloudflare D1 logical binding `DB`. Define schema in `db/schema.ts`, generate SQL migrations, inspect them, apply through the current supported Sites publishing workflow, and seed separately. Never rewrite applied migrations. Use prepared parameters and a centralized repository/data-access layer. API timestamps are ISO 8601 UTC; reporting periods are explicitly defined strings.

### 9.1 Tables

Preserve the assignment's six base tables and add only structures needed for revision history and required logs.

| Table | Required fields / constraints |
|---|---|
| `users` | id, unique authenticated_user_id, optional email, team_id, role enum, course_section, rules_agreed_at, registered_at; no passwords |
| `countries` | id, unique name, country_code, indicative_region, region_selection_claim_id nullable |
| `sources` | id, publisher, title, URL, source_type, publication/effective date, accessed_at, geographic scope, verification status/reviewer/time, limitations |
| `metrics` | id, country_id, metric_name, nullable numeric value, optional structured JSON for mix/categories, unit, period, source_id, retrieved_at, confidence/limitation, definition, geographic scope, refresh_run_id nullable, supersedes_id nullable |
| `designs` | id, team_id, selected_country_id nullable, current_revision, it_load_mw, pue, cooling/backup/network/storage strategies, summary, updated_at; foreign keys |
| `design_claims` | id, design_id, country_id nullable, text, type enum (`fact`, `assumption`, `calculation`, `design_decision`, `unknown`), source_ids via validated JSON array, status, value/unit optional, rationale, uncertainty, updated_at, supersedes_id nullable |
| `design_revisions` | id, design_id, revision, complete canonical design/model-input JSON, evidence_snapshot JSON/hash, reason, actor_id, created_at; unique design_id+revision |
| `audit_events` | append-only id, timestamp, request_id, event_type, actor_id nullable, team_id nullable, entity type/id, safe before/after metadata or revision references, outcome, error_code |
| `refresh_runs` | id, adapter_id, request_id, actor_id, started/finished timestamps, outcome, safe response hash, accepted/rejected counts, previous/new snapshot references, error_code |
| `ai_usage` | id, request_id, actor_id, model, prompt_version, design_revision, evidence IDs/hash, input/output tokens nullable, reported total nullable, duration, tool count, status, error_code, provider request id if available |

For source linkage with multiple IDs, choose either a junction table or validated JSON consistently; record the choice in the implementation log or an optional ADR. Every ID must resolve. Numeric metrics use `NULL` for missing values, never zero; structured values must pass an explicit schema. Use immutable metric/claim revisions with superseding links; no delete UI. A design revision references exact evidence record IDs, not just “latest.”

Indexes must support actual queries: unique identity and role lookup; country/metric/period/retrieval; design/type/status; revision lookup; refresh adapter/time; audit entity/time; AI actor/time. Do not create redundant indexes already covered by UNIQUE constraints.

### 9.2 Data integrity

Required schema validation includes units, finite numbers, country codes, reporting periods, accepted claim types, source metadata, actor team ownership, and source foreign keys. Generation mix fractions must use a declared basis and approximately sum to 100%, or explain missing categories. Store original units and normalized values/conversion provenance. Contradictory records remain inspectable and are flagged; latest retrieval alone does not resolve conflicting definitions.

Provide repeatable seed/import commands and schema/version checks. Seed is idempotent by stable keys. Editing canonical assumptions requires expected revision and returns `409` on conflict. Evidence writes and corresponding audit events occur in one supported transactional/batched operation.

## 10. Backend interfaces and authorization

Adapt route syntax to current Sites runtime; preserve behavior and document exact deployed routes in `docs/architecture-api.md`. Responses share `{request_id, data, meta}`; errors share `{request_id, error:{code,message}}`. Do not expose stack traces or provider bodies.

| Method / route | Authorization | Contract |
|---|---|---|
| GET `/api/countries` | Read-only | Countries and screening metadata |
| GET `/api/countries/:id/metrics` | Read-only | Versioned metrics, sources, definition, vintage, freshness |
| GET `/api/design` | Read-only | Current design and canonical inputs/revision |
| GET `/api/evidence` | Read-only | Filtered/paginated claims and source references |
| POST `/api/scenarios/evaluate` | Read-only audience; limited | Allowlisted controls + country + expected revision; deterministic result; no baseline mutation |
| POST `/api/register` | Authenticated | Course/team/rules agreement; viewer role from server; idempotent |
| GET `/api/me` | Authenticated | Registration and permissions |
| POST `/api/evidence/sources`, `/metrics`, `/claims` | Editor/admin | Validated create/supersede; reason required; audit event |
| POST `/api/evidence/refresh` | Editor/admin | Approved adapter ID; no arbitrary URL; refresh outcome and retained/new snapshot |
| PATCH `/api/design` | Administrator | Expected revision + allowlisted canonical inputs + reason |
| PATCH `/api/users/:id/role` | Administrator | Same-team allowlisted role; audit event |
| POST `/api/adviser` | Authenticated AND registered | Question + bounded conversation + scenario context; answer and validated citations |
| GET `/api/health` | Minimal public/read-only | Service health without sensitive configuration |

Return 401 for missing authentication, 403 for unregistered/insufficient-role access, 400 for invalid data, 409 for revision conflicts, 429 for rate limits, and 503 for unavailable provider dependencies. Registering never trusts browser-supplied role or authenticated identity. Bootstrap the first admin from a deployment-configured allowlisted identity; subsequent role changes are server-authorized. Prevent removal of the last administrator.

Use Sites-provided Sign in with ChatGPT. Verify identity through the platform's server capability, never a browser identity field. Enforce same-team access at every mutation and AI tool retrieval. Apply platform-supported origin/CSRF protections to mutations. No secrets/database bindings in browser bundles, logs, exports, or committed source.

## 11. External refresh behavior

Manual authorized refresh is sufficient; no scheduler needed. Use one approved adapter with fixed base URL, path/parameter allowlists, timeout (10 seconds), one bounded transient retry, schema/unit/range validation, and safe errors.

Process: authorize → create refresh run → call API → validate complete response/batch → normalize → atomically insert valid source/metric revisions and audit event → finalize run → return current data. Reject malformed batches without replacing prior valid data. A failure updates refresh-run status, not the accepted metric values or their original retrieval timestamps. Show “latest refresh failed; displaying last valid data from …”.

Deduplicate unchanged source-period values using canonical hashes/stable keys. Every successful upstream retrieval is recorded in the refresh run even if no value changed; do not create duplicate metrics unnecessarily. Missing response data is not a zero. Do not automatically replace a reviewed tariff with an unrelated national API indicator. Adapter-backed data and manually verified data have separate precedence and definitions.

The adviser may query approved stored/latest-valid data through a read-only adapter tool. It cannot refresh canonical records, edit evidence, or access arbitrary URLs on behalf of a registered viewer.

## 12. AI adviser

### 12.1 Goal and tools

Use the narrow goal described in assignment pages 18–20: help users critically understand the proposed initial design from stored design, claims, metrics, and sources; distinguish types; cite factual claims; acknowledge absent/conflicting evidence; never invent data or certify engineering.

Controlled server tools:

- `get_design`: team derived from authenticated context, not model-supplied unrestricted team ID.
- `get_country_metrics`: allowlisted country and metric names; bounded records with sources and limitations.
- `get_design_claims`: approved/current claims for the authorized design.
- `get_sources`: resolve approved returned source IDs.
- `calculate_energy`: validated IT MW, PUE, hours; shared deterministic calculation library.
- `query_approved_external_source`: approved adapter/query only; read-only, bounded; fallback to stored data with disclosure.

No arbitrary SQL, URL retrieval, filesystem access, write tools, or open-ended financial scenario agent. The adviser can explain an already computed scenario supplied by the backend; its recommendation must match the deterministic result.

### 12.2 Request pipeline and grounding

Authorize → rate/budget check → validate input → retrieve relevant current D1 snapshot → construct instructions and evidence as clearly delimited untrusted content → call OpenAI server-side → execute allowlisted bounded tool calls → validate structured answer/citations → log usage/result → return answer.

Suggested response contract:

```json
{
  "answer": "Explanation of the initial design",
  "citations": [{"source_id": 12, "claim_ids": [34]}],
  "assumptions": ["PUE is a design assumption, not a measured outcome"],
  "uncertainties": ["Site-specific connection date is unknown"],
  "design_revision": 3,
  "model_version": "1.0.0"
}
```

Resolve citation titles/URLs on the server. Reject nonexistent or unretrieved IDs; do not quietly show invented citations. Permit one correction attempt within the total request budget; on continued grounding failure return a safe evidence-gap/error response. A no-evidence answer may have zero citations only if it states the gap and makes no unsupported factual claims. Show source identifiers such as `[S12]` as links to Evidence records. Calculation answers link to input claims and formula/model version.

Keep at most six recent turns; max question 2,000 characters, max serialized client conversation 12,000 characters; server clamps total provider input to 12,000 tokens, output to 1,000 tokens, tool calls to five, and request duration to 30 seconds. Values are initial product budgets, configurable on the server. Suggested initial per-user limit: ten adviser requests per ten minutes. Use persistent/platform-supported counters rather than a per-process map. If exact preflight token counting is unavailable, enforce conservative size bounds and document it.

Use a configurable server model supported by current official API documentation. Confirm whether instructor/platform credentials are available. If none are provided, configure a project OpenAI API key as a server-side hosted secret, following the lecture instruction to create one if needed. The PDF says the instructor supplies secrets, while the lecture explicitly discusses student key creation; record which setup is actually used. Never place the key in a prompt, repository, browser bundle, documentation, or log. Without configured credentials, show provider unavailable and keep analysis usable. Never present canned responses as a live adviser.

### 12.3 Required examples and security

Suggested questions: current PUE; reason for country preference; source of generation mix; effect of PUE 1.4 on baseline energy; largest uncertainty; what remains unknown about the grid; why the required stress case changes cost.

Treat retrieved text and user conversation as untrusted. A malicious source sentence instructing the agent to declare one country best must be ignored as an instruction. Current design is retrieved each request so a changed PUE affects later answers; do not let earlier conversation override current records. Render content safely, with validated HTTPS source links and no raw HTML injection.

## 13. Documentation and logs — mandatory engineering requirements

### 13.1 Required repository documentation

Update documentation alongside meaningful implementation changes. Keep the following compact set; use sections within files rather than creating a separate document for every concern.

| File | Required content |
|---|---|
| `README.md` | Purpose, scope/status, existing-project reuse, verified features, actual setup/migrate/seed/test/build/publish commands, environment variable names, deployed URL and limitations |
| `AGENTS.md` | Implementation constraints, workflow commands, evidence labeling, secret/log rules, and continuation instructions |
| `docs/prd.md` | This PRD and approved amendments; distinguish pending deliverables |
| `docs/architecture-api.md` | Application and physical diagrams; browser/backend/D1/OpenAI walkthrough; routes, permissions, request/response schemas, errors, registration/roles, security boundaries and deployment/recovery guidance |
| `docs/data-sources.md` | Schema/tables/enums/indexes; metric units/definitions/vintages/null handling; source/API inventory, verification, provenance, freshness, adapter contract and limitations |
| `docs/model.md` | Equations, currency/time/workload basis, cost/finance accounting, fixed hybrid schedule, stress cases, recommendation method, construction/grid/procurement timing, worked examples and unknowns |
| `docs/requirements-tests.md` | Requirement → assignment/lecture reference → implementation → test/result; commands, observed preview/deployed outcomes, screenshots/reports and blockers |
| `docs/implementation-log.md` | Chronological concise work log, decisions and current handoff state |
| `submission/README.md` | Engineering deliverable checklist and exact paths/URLs; separately track pending presentation/memo |

ADRs are optional short records for meaningful architecture/model deviations; routine choices belong in the implementation log. A separate changelog is optional. Keep diagrams editable. Document actual tested commands and behavior, not hypothetical configuration. Exclude credentials and personal identifiers from submissions. No new documentation platform, analytics dashboard, or elaborate audit subsystem is required.

### 13.2 Implementation work log

Append an entry after each meaningful work unit, including research, migrations, fixes, tests, and publication. Never fabricate activity, retroactive timestamps, or passing results. Record concise decision rationale; do not record hidden reasoning or chain-of-thought.

```markdown
### 2026-10-05T18:00:00Z — <milestone / work unit>
- Goal and requirement IDs:
- Changes and affected files:
- Evidence/source records added or changed:
- Design/model/architecture decisions and ADR links:
- Commands/checks run and observed outcomes:
- Failures, limitations, and unresolved questions:
- Commit/build/deployment reference when available:
- Next action / handoff:
```

Maintain a short current-state block at the top with completed work, next step, blockers, canonical revisions, and latest verified deployment/test references. Git history supplements this log; it does not replace it. When resuming, read PRD, current log state, and relevant ADRs before modifying code.

### 13.3 Runtime structured logs

Every API request gets a server-generated `request_id`, returned in responses and propagated to tool calls, refresh runs, audit events, and AI usage. Log JSON lines with UTC timestamp, level, event, route, method, duration, status, safe error code, version, and request ID. Record evidence/design references needed to reproduce the answer. Log denied access and validation failures without logging supplied secrets or full sensitive payloads.

Minimum events: request completed/failed; registration; evidence created/superseded; canonical design changed; role changed; refresh started/succeeded/failed; adviser started/completed/failed; invalid citation; budget/rate denial; migration/seed/deployment outcome in implementation log.

Default **do not retain raw questions, responses, auth tokens, full external bodies, emails, IP addresses, or conversation transcripts**. Store IDs/hashes and structured metadata. Do not log model reasoning. Public Evidence views must never expose audit/user/AI usage tables.

Persist a minimal evidence/design change record and reason, with revision references, alongside accepted mutations. Use existing version/audit tables; no comprehensive compliance audit system is required. AI usage persistence should be attempted before returning success; if it fails, emit a structured operational error and identify incomplete usage accounting. Do not pretend a provider failure means zero tokens: use `null` when usage is unknown.

### 13.4 Token tracking, retention, and exported logs

Track actual input/output/total tokens returned by the API per request, provider model, tool count, outcome, and date. Aggregate daily and total project usage for the course documentation using an authorized script/report; no extra analytics dashboard required. Optional monetary estimates must use dated model prices and be labeled estimates; token counts are the required metric.

Track a documented project token target and simple per-request/rate limits. Report accumulated actual usage and unknown usage, warn when a configurable budget target is reached, and provide an explicit server setting to disable further AI calls. This is a soft course-project budget, not a guaranteed hard spending cap. Atomic preflight token reservations, reconciliation counters, and complex budget enforcement are optional; implement only if required by the deployment environment. Export small sanitized usage, refresh and test summaries under `reports/`.

Default retention: operational/AI usage records 30 days, evidence/design audit history for the course project's lifetime. Document the cleanup command and preserve sanitized final course snapshots; do not claim a scheduled retention job unless implemented. Credentials and `.env` files are excluded from git and exports.

## 14. Requirement traceability and acceptance tests

All rows are mandatory unless labeled pending/optional. The agent must populate `docs/requirements-tests.md` with actual implementation/test references. Tests assert behavior and failure modes, not merely that functions exist.

| ID | Requirement / acceptance condition | Assignment reference |
|---|---|---|
| FR-01 | Five core pages; initial design, exact baseline energy, location selection state and three uncertainties visible | pp. 7, 14–15 |
| FR-02 | Ireland/Finland/Canada comparison includes required metrics, definitions, dates, sources, gaps, policy/grid screening | pp. 7, 14 |
| FR-03 | Evidence, assumptions and design survive reload/redeployment; schema and seed reproducible | pp. 9–13 |
| FR-04 | Genuine external API request succeeds and persists validated data; ≥3 human-verified sources | pp. 15–16 |
| FR-05 | Failure/malformed API retains prior values/timestamps; failure banner and refresh log visible to appropriate user | pp. 16, 21 |
| FR-06 | Visitor sees read-only design; unauthorized adviser request returns 401; signed-in unregistered returns 403 | pp. 17–18, 20–21 |
| FR-07 | Registration grants viewer access only; role spoofing, cross-team access, unauthorized editing denied server-side | pp. 17–18, 21 |
| FR-08 | Adviser cites real retrieved sources; current PUE matches D1; missing/conflicting facts acknowledged | pp. 18–21 |
| FR-09 | Canonical PUE revision changes deterministic energy and next adviser answer; old snapshot still reproducible | pp. 15, 21 |
| FR-10 | Prompt-injected source does not override adviser policy; professional certification request gets design-limit explanation | p. 21 |
| FR-11 | Base, 12-month delay, half-utilization compare all alternatives and report four required outputs plus yearly costs | pp. 2–3 |
| FR-12 | Finance separates facility/GPU costs; bridge/overflow covers common demand; financing/unused-cost accounting has no double count | pp. 2–3 |
| FR-13 | Explicit recommendation follows documented gates/ranking; missing critical evidence returns INSUFFICIENT EVIDENCE; disclaimer visible | pp. 2–3 plus user decision |
| FR-14 | Physical diagram/failure cases cover largest-component failure and 48-hour outage; ownership/governance/financing documented | pp. 2–3 |
| FR-15 | Docs, work log, audit/refresh events, token usage and sanitized reports complete and traceable | pp. 4, 22 plus user emphasis |
| FR-16 | Sites publication with D1/auth/secrets; preview and deployed functional tests pass; URL captured | pp. 11–12, 22 |
| FR-17 | Two-minute demo video and individual request explanation exist with final snapshot references; standalone investment presentation/memo tracked as pending instructor confirmation | pp. 3, 22; lecture 00:02:51 |

### 14.1 Test suite

**Model unit/fixture tests:** exact `20 × 1.25 = 25 MW`, `219 GWh`, and `PUE 1.4 → 28 MW / 245.28 GWh`; zero productive hours; bounds/invalid inputs; demand fixed across scale scenarios; equivalent workload parity; delay commissioning/bridge/carrying costs; half demand with fixed installed fleet/costs; idle-power behavior; tranche replacements; fixed hybrid module/expansion schedule and grid-dependent deferral; debt principal not added to capex; unused allocation not added twice; tied/failed/missing-input recommendations and explicit conditionality; reproducible snapshot/hash.

**API/integration tests:** fresh and idempotent registration; visitor/unregistered/editor/admin matrix; role spoofing and team isolation; revision conflict; refresh success/malformed/timeout/unchanged data; migration/seed repeatability; citation validation; rate limits, usage tracking and AI-disable setting; secret absence in browser build and exported logs.

**Adviser tests:** assignment's current-PUE and revised-PUE questions; missing grid date; conflicting sources; actual supporting source resolution; injected source; certification boundary; provider unavailable; invalid citations corrected or safely refused. Use deterministic mocked provider fixtures for repeatable contract tests plus a small real-provider deployed smoke test when credentials are configured. Log real usage and do not claim mocks prove live grounding.

**UI/deployed end-to-end:** navigation, filters, source links, scenarios/reset, access states, refresh failure state, readable mobile/desktop layouts, keyboard navigation/focus/labels, no client credentials, persisted revision after reload, and a complete registered adviser journey. Capture screenshots and request/test reports.

Targets: scenario calculations respond within one second on preview/deployment for seed data; core read pages within three seconds under observed demo conditions; adviser completes within configured timeout or shows recoverable error. Measure and report environment; these are course demo targets, not uptime guarantees.

### 14.2 Definition of done

A requirement is done only when implemented, observed passing in the relevant environment, documented, and linked to a test/report. No “all tests pass” without a report. Deployment tests must reference the exact commit/deployment and evidence/model snapshot. Blocked real authentication/API/AI tests remain visibly blocked; do not silently replace them with mocks.

## 15. Implementation sequence and deliverables

### 15.1 Milestones

| Milestone | Work | Exit gate |
|---|---|---|
| M0 — Ground scope / reuse project | Copy PRD; create compact docs/log; inspect the existing Sites project and supported capabilities; identify credential setup and research gaps | Extend existing project where available; preserve identity/data; record pending deliverables |
| M1 — First working website / login | Recognizable page shell; D1 user persistence; Sign in with ChatGPT, registration, viewer/admin roles and protected mutation skeleton | Login/register/logout work; user persists; unauthorized role changes fail; document request routes |
| M2 — Evidence and analysis | Research/seed sources; add country/metric/design tables and DAL; ten-year model/fixtures, fixed hybrid, stress cases and timing assumptions | Baseline/stresses reproduce; source provenance and gaps documented; read/write route contracts explicit |
| M3 — Complete pages / external data | Five pages, bounded scenarios, diagrams, Evidence maintenance; real API refresh and failure preservation | Required views work; valid data persists; access matrix and last-valid-data tests pass |
| M4 — Adviser / minimal logging | Controlled tools, server secret/provider calls, citations, rate limits, token usage and small change/refresh logs | Grounding/injection/current-revision tests pass; usage accounted for; no secrets in exports |
| M5 — Publish / handoff | Compact docs, observed tests, deployed checks, sanitized reports and confirmed engineering submission package | Exact deployment verified; pending memo/presentation do not block website acceptance |


Reuse the website built previously if available, as demonstrated in the lecture; create a new project only when none exists or reuse is unsuitable, with a recorded reason. Commit coherent milestones when a git project exists. Do not overwrite an existing project or applied migrations. Use supported Sites publishing workflows; preserve deployment audience and document the exact source version. No need to build a new Site merely to author this PRD—the Site is the subsequent implementation deliverable.

### 15.2 Suggested repository layout

```text
README.md
AGENTS.md
src/
  pages/
  components/
  server/{routes,auth,repositories,external,adviser,logging}/
  shared/{model,schemas,types}/
db/schema.ts
db/migrations/
db/seed/
tests/{unit,integration,e2e}/
docs/
  prd.md
  architecture-api.md
  data-sources.md
  model.md
  requirements-tests.md
  implementation-log.md
  decisions/                 # optional meaningful ADRs
reports/{tests,usage,refresh}/
submission/
  README.md
  system-diagram.pdf
  demo-video.mp4
  request-walkthrough.md
  pending/                   # presentation/memo only after confirmation
.openapi-or-platform-config-as-supported
```

The last configuration entry is illustrative: document the actual Sites configuration, including `.openai/hosting.json` when used; do not create a fictitious config file. Frontend default is TypeScript/React using the supported Sites scaffold; backend uses supported server runtime and shared validation. Do not add a second database or external auth provider. Choose a simple supported test runner and browser test tool rather than introducing a large framework stack.

### 15.3 Submission package

Produce the confirmed engineering package from the **same final scenario/evidence snapshot**:

1. Published website URL and source commit/deployment references; add the URL to the shared course document if instructed.
2. Application architecture diagram plus the site's physical system diagram covering power, cooling, networking and failure paths, with editable source. Track whether the standalone one-page physical PDF is required separately; the design diagram remains website content.
3. D1 schema/migrations, functional-requirements table, external sources/API inventory, initial design and assumptions.
4. Test results and small sanitized usage/refresh summaries.
5. Two-minute demonstration video showing pages, scenarios, provenance, registration/adviser and refresh behavior.
6. Short individual browser → backend → D1 → OpenAI → cited response explanation; provide a factual draft for the team to personalize, never invent individual contributions.

**Pending instructor confirmation — not website completion gates:** the standalone two-page investment memo and five-minute investment committee presentation described in the PDF's initial challenge. Do not generate these by default. If confirmed required, produce them from the final website analysis, including the recommendation, required stress results and three findings most likely to change the recommendation. Until then, maintain their pending status in the checklist without treating their absence as an implementation blocker.

If actual video recording or user-specific individual explanation cannot be completed with available capabilities, deliver the script/shot list or draft and list the remaining action as a blocker. The engineering project is not fully submission-complete until the real required artifact exists.

## 16. Agent handoff and research blockers

The implementation agent should start without further product clarification. Research or platform details remain to be established, not guessed:

- Indicative regions and current local policy/grid constraints.
- Actual API coverage and live endpoint contract.
- Member demand and commitment evidence; workload/security/availability assumptions.
- Reference GPU and equivalent leased pricing; real tariff, cost, replacement and finance assumptions.
- Available instructor/platform credentials, or project API-key setup if none are provided; supported auth/D1 capabilities.
- Site-specific connection, cost and uptime evidence required for an approval-ready verdict.

For each gap, record the owner/next research action, affected claims/requirements, and possible impact on the recommendation. Keep the website operational with explicit unknown states. A defensible **INSUFFICIENT EVIDENCE** outcome is successful analysis; concealing missing inputs is not.

### 16.1 Final handoff report

Return the published URL, final recommendation and conditionality, tested commit/model/evidence versions, completed milestones, test report links, documentation/submission paths, usage summary, and remaining blockers. The work log must let another agent reproduce the build, explain the calculations, inspect source provenance, and continue from the exact recorded state.

## Appendix A — Assignment source map

Source: **Lesson 06 — Build a DataCenter Challenge.pdf** (provided attachment, 23 non-empty pages).

| Physical pages | Relevant content |
|---|---|
| 1–3 | Consortium challenge, starting unknowns, six decisions, required stress cases and four main deliverables |
| 4 | Finished system, persistent evidence, registered AI, token tracking |
| 6–8 | Implementation phases, minimum functional requirements, baseline assumptions |
| 9–13 | Six suggested D1 tables, claim types, indexes, Sites server architecture, migrations, verified seeds and DAL |
| 14–15 | Five pages, diagram, evidence UI and deterministic energy calculation |
| 16–17 | Genuine API, verified sources, protected refresh, server secrets and authentication |
| 18–20 | Authorization roles, narrow adviser, controlled tools, server request pipeline and citations |
| 21 | Functional tests, missing evidence, failure preservation, prompt injection |
| 22–23 | Publication checks, engineering submissions, class/homework split and provenance principle |

This PRD distinguishes assignment requirements from user decisions and additional implementation defaults. In particular, financial details, bounded controls, recommendation rules, documentation templates, and structured log contracts make the assignment implementable; they do not turn uncertain assumptions into verified investment evidence.

## Appendix B — Version 1.1 change record

Revised after reviewing the 2026-09-29 lecture transcript and the user's approved simplifications: separate pending presentation/memo from engineering acceptance; correct credential assumption; prioritize reuse and working persistent login; document route contracts and procurement timing; replace optimized hybrid/tie thresholds with a simple planning comparison; consolidate documentation; retain minimal change/refresh/token logs and make elaborate token enforcement optional. The PDF's written website analysis requirements remain in scope.
