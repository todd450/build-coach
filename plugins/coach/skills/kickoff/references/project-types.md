# Project types: recommended approaches

For each project type, pick the row that matches the **least experienced builder** (the user themself if they work alone). Prefer the approach with the fastest path to something they can show working. A project can always grow into a heavier stack later.

## Web app / prototype (MVP for a startup idea, internal tool, customer-facing demo)
| Comfort with code | Recommend | Why |
|---|---|---|
| None / some | **Streamlit (Python)** for data-driven or form-driven tools. A **single HTML/CSS/JS page** for landing pages and clickable mockups. | Runs with one command, no build tooling, free hosting (Streamlit Community Cloud, GitHub Pages). |
| Comfortable | **Next.js + a hosted database (e.g., Supabase)**, deployed on Vercel | A real product architecture with accounts and data. More moving parts, so expect setup time. |

Folders: `app/` (or `src/`), `assets/`, `docs/`.
Verify: Claude runs it locally and the user clicks through the main flow after every step. Ask Claude to take a screenshot or use the app's preview browser.
Milestone 1 idea: one screen working end-to-end with fake data.

## Data analysis (market sizing, customer data, survey results, forecasting)
| Comfort with code | Recommend | Why |
|---|---|---|
| None / some | **Python scripts + pandas + charts saved as PNG**, with Claude explaining each step in comments | Scripts are easier to re-run and review than notebooks. The charts drop straight into the deck. |
| Comfortable | **Jupyter notebooks** for exploration, plus scripts for the final pipeline, maybe a Streamlit dashboard | Interactive exploration, plus a reproducible final result. |

Folders: `data/raw/` (never modified), `data/private/` (confidential, gitignored), `analysis/`, `outputs/charts/`.
Verify: sanity-check totals against the source, have Claude state every assumption, and spot-check 5 rows by hand. Ask "what could make this conclusion wrong?"
Milestone 1 idea: load the data, then print row counts, columns, and obvious data-quality issues.

## Automation / workflow (connect tools, process documents, generate reports)
| Comfort with code | Recommend | Why |
|---|---|---|
| None / some | **A Python script run by hand**, reading and writing local CSV or Excel files | No accounts or servers. Easy to demo live. |
| Comfortable | **Python + APIs** (Google Sheets, Slack, a CRM), maybe a scheduled job or a Claude API call | Shows real integration, but needs API keys. Set up `.env` first. |

Folders: `scripts/`, `input/`, `output/`.
Verify: run on a small sample first, compare against doing it by hand, and log what the script did.
Milestone 1 idea: process one sample file end-to-end.

## Business deliverable (financial model, research report, market map, deck support)
| Comfort with code | Recommend | Why |
|---|---|---|
| Any | **Markdown documents for research and writing**, plus **Python that generates Excel models** (openpyxl) when a model needs real formulas | Claude edits text and code well. Generated spreadsheets keep live formulas the team can audit. |

Folders: `research/` (one file per source or topic, with links), `model/`, `drafts/`.
Verify: every number traces to a cited source or a stated assumption, and Claude lists its sources. Do a "red team" pass: ask Claude, in a fresh session, to argue the opposite.
Milestone 1 idea: research brief with sources, plus the outline of the final deliverable.

## Not sure yet
Start with a **discovery milestone**: `research/` and `ideas/` folders, plus a PLAN.md whose first milestone is "Choose deliverable type by {{date}}." Suggest prompts that use Claude as a sparring partner: "Give me three ways we could build this, with the effort and risk of each."
