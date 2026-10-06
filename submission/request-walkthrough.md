# Individual request explanation — current application, model 1.4.0
Personalize this explanation with your name and actual contribution before submitting.

I will trace the question “What is the current PUE?” through the application. The browser sends it to POST /api/adviser. Sites supplies the authenticated identity; the browser cannot choose its role. The backend checks both authentication and the persistent D1 registration record, then enforces the request rate limit.

The backend reads the current design, claims, country metrics and sources from Cloudflare D1. It calculates energy and the investment screening with shared deterministic code, including the robustness results. For the saved baseline, 20 MW of IT load multiplied by PUE 1.25 gives 25 MW of facility power; at full power for 8,760 hours, that is 219 GWh. This full-power figure is distinct from utilization-based modeled consumption.

The server sends relevant records and instructions to the OpenAI Responses API using a server-only credential. Evidence and conversation are treated as untrusted content. The adviser has bounded read-only tools for design, metrics, claims, source details, energy calculations and an approved external adapter. It explains the deterministic screening; it does not independently select an investment winner or approve a site.

The backend validates cited source and claim identifiers against the retrieved evidence and returns the answer, citations, assumptions and uncertainties. It records actual API token usage and audit metadata internally, without logging secrets or raw conversations. The browser displays the answer and supporting links. Routine revision/hash and usage metadata are not displayed as development content.

Changing a visitor what-if scenario does not change the saved D1 baseline. An administrator saving a baseline PUE change creates an immutable revision; subsequent adviser questions use that new canonical value. Previous snapshots remain reproducible.

My contribution was: [replace with your actual work or review].
