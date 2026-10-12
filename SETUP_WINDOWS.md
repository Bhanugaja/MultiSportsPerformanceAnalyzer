# Sports Performance Analyzer — Windows local setup

This project follows the supplied synopsis UI: purple gradient background, white cards, Login, Add Single Player, KPI Overview, Player Records, and Analysis Results.

## 1. Prerequisites
- Python 3.10+ (3.11/3.12 is recommended for the pinned dependency set)
- Node.js 18+
- npm

## 2. Backend
Open PowerShell in `backend`:

```powershell
python -m venv venv
.\venv\Scripts\Activate.ps1
python -m pip install -r requirements.txt
python bootstrap.py --reset
python app.py
```

Backend: `http://127.0.0.1:5001`

The bootstrap command trains Football, Basketball and Cricket PCA/scaling models and imports the supplied 50-row dataset for each sport (150 player records total).

## 3. Frontend
Open a second PowerShell in `frontend`:

```powershell
npm install
npm start
```

Frontend: `http://localhost:3000`

The code defaults to `http://127.0.0.1:5001`, so no `.env` file is required. If you need another backend URL, copy `.env.example` to `.env` and edit it.

## 4. Login
- Normal User: `normaluser` / `password123`
- Club Owner/Coach: `coach` / `password123`

The coach account gets the Bulk Upload action.

## 5. Validate the API
With the backend running:

```powershell
Invoke-WebRequest http://127.0.0.1:5001/api/
```

Then use the UI to login, select a sport, add a player, and verify the KPI chart and Player Records table.

## 6. Bulk upload
Use the supplied CSVs:
- `backend/data/football_matches.csv`
- `backend/data/basketball_matches.csv`
- `backend/data/cricket_matches.csv`

The three CSVs are also supplied separately with this project and match the copies bundled under `backend/data`.
