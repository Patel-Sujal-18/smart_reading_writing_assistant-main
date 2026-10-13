# LexiFlow — Smart Reading & Writing Assistant

A project-level implementation of the assignment **Building a Smart Reading & Writing Assistant (NLP Pipeline)**. The application uses a React/Vite premium frontend and a FastAPI Python backend. It exposes all five syllabus stages as visible, testable UI views.

## Architecture
- `frontend/` — React + Vite UI
- `backend.py` — FastAPI API server
- `pipeline.py` — stage 1 → 4 orchestration
- `stage1_spell/` — from-scratch Levenshtein + context-aware spell checking
- `stage2_syntax/` — spaCy POS/dependencies + hand-written CKY/CFG parser
- `stage3_semantics/` — NER, semantic frames, Lesk-style WordNet WSD
- `stage4_discourse/` — heuristic coreference, discourse connectives, pragmatic inference
- `data/test_samples.txt` — 10 messy test samples

## Run locally
### Backend
**Option A (Fastest via helper script):**
```cmd
.\run_backend.bat
```

**Option B (Manual via virtual environment):**
```powershell
# Activate .venv (PowerShell)
.\.venv\Scripts\Activate.ps1
uvicorn backend:app --reload --port 8000
```
*Or directly without activating:*
```powershell
.\.venv\Scripts\python.exe -m uvicorn backend:app --reload --port 8000
```

The spaCy model is installed by the requirements URL.

### Frontend
```bash
cd frontend
npm install
npm run dev
```
Open the Vite URL shown in the terminal. The frontend expects the API at `http://localhost:8000` by default. For deployment, set `VITE_API_URL` to the deployed backend URL.

## Stage Descriptions (What Each Stage Demonstrates)

### Stage 1: Spell Checking & Text Normalization
Demonstrates foundational NLP text normalization and error correction prior to downstream parsing. It features an edit-distance algorithm (Levenshtein) implemented from scratch to identify non-word errors and generate candidate corrections. In addition, an n-gram context model evaluates surrounding words to disambiguate real-word typos (e.g., *piece* vs *peace*). This stage highlights how early-stage cleaning prevents error propagation through subsequent syntactic and semantic layers.

### Stage 2: Syntactic Processing & Parsing
Demonstrates structural analysis of natural language through part-of-speech (POS) tagging and dependency parsing. It extracts grammatical relations such as subjects, objects, and head verbs using spaCy. Furthermore, it incorporates a custom Cocke-Younger-Kasami (CKY) chart parser operating over a Chomsky Normal Form (CNF) grammar to demonstrate algorithmic constituency parsing. This stage illustrates how syntax reveals hierarchical sentence structure and resolves structural ambiguities.

### Stage 3: Semantic Analysis & Word Sense Disambiguation
Demonstrates extracting literal meaning and entity semantics from text. It identifies Named Entities (such as Persons, Organizations, and Locations) and constructs predicate-argument frames to determine who did what to whom. Additionally, it implements an overlap-based Lesk algorithm using WordNet to disambiguate polysemous words (e.g., *bank*, *bat*, *light*) within context. This stage showcases how machines transition from grammatical syntax to semantic comprehension.

### Stage 4: Discourse Relations & Pragmatic Inference
Demonstrates language comprehension beyond isolated sentences by analyzing context, coherence, and speaker intent. It resolves cross-sentence pronoun coreference using a nearest-compatible antecedent heuristic. It also classifies discourse connectives into rhetorical relations such as contrast, causation, and temporal progression. Finally, rule-based speech-act heuristics detect indirect requests (e.g., identifying "Can you pass the salt?" as an imperative action rather than a question of ability).

### Stage 5: End-to-End Pipeline Integration
Demonstrates end-to-end NLP system architecture by orchestrating Stages 1 through 4 into a single, cohesive processing flow. Corrected text from Stage 1 automatically flows through syntactic, semantic, and discourse analyzers while tracking execution latency and transformation metadata. The pipeline produces structured JSON output consumed by the interactive React dashboard to visualize each stage's internal representations. This stage proves modular pipeline design, fault tolerance, and practical usability for real-world user text.

