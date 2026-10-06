# Country price and feasibility research — model 1.3.0

Researched 2026-10-05; retrieval timestamps are UTC. Primary records S11–S27 and claims C21–C34 extend the evidence inventory. Old records remain as history; C21 supersedes the original shared cost assumptions C11, C29 supersedes the earlier Finland connection snapshot C6. All new records are agent reviewed, not human verified.

## Implemented price inputs

| Country | Original electricity basis | USD/kWh | Published rental benchmark USD/billed GPU-hour |
|---|---|---:|---:|
| Ireland | 0.1724 EUR/kWh; 2025-S2 Eurostat band IF, excluding VAT/recoverable taxes | 0.19464994 | 8.376; Azure North Europe NC40ads H100 v5 |
| Finland | 0.06484999999999999 EUR/kWh; 2025-S2 Eurostat band IF ex-tax energy/network + 2026 class I tax/fee | 0.07321954 | 4.500; Nebius eu-north1 H100 NVLink |
| Canada | 0.13 CAD/kWh; Hydro-Québec proposed average new >5MW data-centre rate; planning policy scenario | 0.09300329 | 7.912; AWS Canada Central p5.48xlarge, 8 H100 GPUs |

Electricity prices are planning proxies, not 25 MW utility offers. Eurostat band IF covers 70,000–149,999 MWh annual consumption; the modeled baseline consumes roughly 162 GWh/year after commissioning, above this band. Finland's larger band was unavailable for this vintage. The same IF definition is used for Ireland/Finland instead of inventing a missing large-user value; this limitation is visible.

## Facts, calculations and assumptions

**Published facts:** Eurostat 2025-S2 Ireland VAT-excluded price 0.1724 EUR/kWh, Finland ex-tax 0.0416 EUR/kWh. Finnish datacentres move to class I electricity tax July 1, 2026; current class I energy tax plus security-of-supply fee totals 0.02325 EUR/kWh. Finland proxy is therefore 0.06485 EUR/kWh, a mixed-vintage calculation, not a directly published delivered price. Québec's CAD 0.13/kWh average is a proposed >5 MW datacenter rate; final approval was not verified. It is explicitly used as a policy planning scenario, not an approved tariff.

**FX calculation:** Bank of Canada annual 2025 averages: 1 USD=1.3978 CAD and 1 EUR=1.5782 CAD. USD/CAD=1/1.3978; USD/EUR=1.5782/1.3978. Fixed annual-average FX supports reproducibility; not today's spot conversion. All prices are held constant over the ten-year model; no inflation adjustment between reporting vintages is inferred.

**Rental selection:** Non-interruptible Linux public consumption benchmarks, no spot/low-priority or commitment discount. Ireland: Azure North Europe NC40ads_H100_v5, 8.376 USD/VM-hour, one H100 NVL 94 GB. Canada: AWS Canada Central p5.48xlarge Linux shared on-demand, 63.296 USD/VM-hour, eight H100 GPUs; 63.296/8=7.912 USD/GPU-hour. Finland: Nebius eu-north1 H100 NVLink, current October 1, 2026 rate 4.50 USD/GPU-hour; older 3.85 and promotional prices excluded. Each is a price observation; no quota allocation or sufficient cluster size is confirmed.

**Workload and contract assumptions:** Published allocated GPU-hours are converted to productive reference hours using a fixed 95% fraction. Lease cost = productive leased hours / 0.95 × regional benchmark × 1.10. The 10% service allowance remains an assumption, not a vendor breakdown; storage/egress, software, discounts and reservation minima can exceed it. Hardware and multi-GPU training performance differ: Ireland's single NVL94 is not validated as SXM80/InfiniBand equivalent. Keeping a common reference workload is a screening assumption, with equivalence explicitly unverified. Cancellable consumption and instant elasticity remain assumptions. All leased bridge and overflow use the same regional price and conversion as lease-only.

**Alternative candidates:** OVHcloud's lower H100 PCIe price in CAD storefront is recorded as C34; storefront currency does not prove Québec-region availability or training equivalence. It is not silently substituted for an eight-GPU training benchmark. AWS Ireland returned no p5.48xlarge regional rows, and Azure Ireland no ND96isr_H100_v5 consumption rows; absence in the queried dataset is recorded, not a general impossibility claim. Provider choice, cluster fit and negotiated terms could reverse country screening.

## Québec reference tariff and policy risk

Hydro-Québec current April 2026 Rate LG (non-industrial ≥5 MW category) lists CAD16.571/kW-month demand plus CAD0.04324/kWh energy. At an assumed flat 74% load factor, effective reference price = 0.04324 + 16.571×12/(8760×0.74), approximately CAD0.0739/kWh. This calculation omits minimum-demand, connection, tax and other adjustments; eligibility for a new datacenter is not confirmed. The proposed datacenter rate and project-selection process make automatic LG eligibility unsafe to assume. Docket R-4333-2026 was inspected; a final approved tariff was not verified. Do not portray either an LG reference or the policy proposal as a binding offer.

## Feasibility screening and overall recommendation

Latest Fingrid statement reports almost fully reserved additional connection capacity in many regions; northern opportunities do not establish a southern/Uusimaa site offer. Ireland connection constraints retain their source-linked policy context. National mix statistics cannot establish hourly supply or readiness. Member locations and workloads are unspecified, so latency remains unknown. Irish DPC requires processor agreements and location/transfer safeguards; no universal Ireland/EEA-only rule is invented. Canadian private-sector outsourcing guidance does not resolve university-specific provincial/public-sector rules.

Overall selection ranks the nine country/strategy combinations by modeled discounted cost, without a weighted country score. Finland–HYBRID is the current provisional minimum. Base strategies: Ireland BUILD, Finland HYBRID, Canada BUILD. Delay: HYBRID in all three. Half utilization: Ireland HYBRID, Finland LEASE, Canada HYBRID. No result is preset and no canonical approved country is written. The top box labels a conditional screening preference for diligence, not investment approval. Finland's base hybrid/build boundary is close (about USD4.589/billed GPU-hour compared with USD4.50 benchmark), so the result is fragile. Stress results and rental frontier expose this rather than claiming robustness.

## Verification and refresh boundaries

Raw public API snapshots and failed retrieval outcomes are in reports/research/. Eurostat and price-list calls were real network integrations, not mocks. StatFin PxWeb requests returned HTTP400; Eurostat's country data was used instead. The website's automatic refresh remains the single approved World Bank adapter required by PRD; current pricing inventory is manually researched/versioned. No autonomous scraper, extra controls or unsupported site offers were added. Evidence synchronization is administrator-only, idempotent by keys, appends current pricing revision when needed and preserves controls/selected country and historical revisions. Writes and audit events share a D1 batch. Secrets, private identities and raw adviser questions are excluded from reports.
