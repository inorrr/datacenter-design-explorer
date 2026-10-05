# Individual request explanation — personalize before submitting
This is a factual application walkthrough, not a claim about any student's contributions.

1. Browser user signs in through Sites /signin-with-chatgpt. Sites verifies identity and forwards trusted headers; frontend cannot choose user/team/role.
2. POST /api/register validates course section/rules agreement, writes one persistent D1 user, grants viewer access only. An allowlisted initial admin is configured separately.
3. User asks a question. /api/adviser rejects unauthenticated401 and unregistered403 before any provider call.
4. Server rate-checks persistent usage, reads current D1 design/evidence snapshot, computes energy with shared deterministic code and packages records as untrusted evidence.
5. OpenAI receives a server-only authenticated Responses request, with narrow read-only tools and a limited structured output. It cannot update design or choose a new investment verdict.
6. Backend verifies cited source IDs and linked claims against retrieved D1 records, resolves titles/HTTPS links, records actual token counts, request ID, model, revision and evidence hash without raw conversation/secrets.
7. Browser renders answer, assumptions, unknowns, citations and revision. A new PUE revision changes the next request's canonical calculation; earlier snapshots remain reproducible.

Add your own name and accurately explain the part you implemented/reviewed. Do not claim individual contributions based only on this draft.
