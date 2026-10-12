# Sports Performance Analyzer

A complete, production-quality sports analytics platform that uses machine learning to analyze and compare player performance across Basketball, Football (Soccer), and Cricket.

## Features

- **Multi-Sport Support**: Analyze players from Football, Basketball, and Cricket
- **KPI Modeling**: Compute Relevance, Consistency, and Contribution scores using PCA and weighted algorithms
- **User Roles**: Normal User and Club Owner/Coach with different permissions
- **Single Player Analysis**: Input individual player stats and get instant KPI analysis
- **Bulk Upload**: Upload CSV files with multiple players for batch analysis (Coach only)
- **Analytics Dashboard**: View KPI cards, comparison charts, and searchable player tables
- **Historical Comparison**: Compare player results to sport averages

## Tech Stack

**Backend:**
- Flask (Python 3.10+)
- SQLite Database
- scikit-learn (PCA, StandardScaler, MinMaxScaler)
- pandas, numpy
- joblib (model persistence)

**Frontend:**
- React 19
- React Router
- Recharts (data visualization)
- Shadcn UI components
- Tailwind CSS
- Axios

## Installation & Setup

### Backend Setup

For Windows, you can use the included `SETUP_WINDOWS.bat` and `START_BACKEND.bat` files.

```bash
cd backend

# Create virtual environment (optional)
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Initialize database
python -c "from database import init_db; init_db()"

# Train models (required first time)
python train_football_models.py
python train_basketball_models.py
python train_cricket_models.py

# Start server
python app.py
```

Backend runs on `http://127.0.0.1:5001`

### Frontend Setup

```bash
cd frontend

# Install dependencies
npm install
# or
yarn install

# Start development server
npm start
# or
yarn start
```

Frontend runs on `http://localhost:3000`

## Usage

### Login Credentials

**Normal User:**
- Username: `normaluser`
- Password: `password123`
- Can: Add single players, view database

**Club Owner/Coach:**
- Username: `coach`
- Password: `password123`
- Can: Add single players, bulk upload CSV, view database

### Single Player Analysis

1. Login with any user account
2. Select sport (Football/Basketball/Cricket)
3. Click "Add Single Player"
4. Fill in player stats
5. Click "Analyze Player"
6. View KPI results and charts

### Bulk Upload (Coach Only)

1. Login as coach
2. Click "Bulk Upload"
3. Select CSV file matching the sport format
4. Preview data
5. Click "Upload and Analyze"
6. View results summary

## CSV Format

### Football
Required columns:
```
player_name,team,minutes,goals,assists,shots,shots_on_target,pass_accuracy,key_passes,tackles,interceptions,dribbles,xg
```

### Basketball
Required columns:
```
player_name,team,minutes,points,assists,rebounds,steals,blocks,turnovers,three_pointers,field_goals_attempted,free_throws_attempted
```

### Cricket
Required columns:
```
player_name,team,runs,balls,fours,sixes,strike_rate,wickets,overs,runs_conceded,economy,maidens,catches
```

Sample CSV files are provided in `backend/data/`.

## API Endpoints

### Authentication
- `POST /api/login` - User login
- `POST /api/logout` - User logout

### Player Analysis
- `GET /api/` - Health check
- `POST /api/analyze_player` - Analyze single player
- `POST /api/upload_file` - Bulk upload CSV
- `GET /api/view_database` - Get all players (filterable by sport)
- `GET /api/player_history` - Get player's historical data
- `GET /api/dashboard_stats` - Get aggregated KPI statistics

## KPI Calculations

### Relevance (0-100)
- Based on PCA (Principal Component Analysis) of key performance features
- Standardized using StandardScaler → PCA → MinMaxScaler
- Represents overall statistical importance

### Contribution (0-100)
- Weighted sum of impactful stats (goals, assists, points, runs, etc.)
- Sport-specific formulas
- Scaled 0-100 using MinMaxScaler

### Consistency (0-100)
- Calculated from historical player data
- Uses mean/(1+std) formula
- Default: 50 for single entries

### Combined Score
```
Combined = 0.5 × Relevance + 0.35 × Contribution + 0.15 × Consistency
```

### Performance Categories
- **Good**: Combined ≥ 66
- **Average**: 40 ≤ Combined < 66
- **Poor**: Combined < 40

## Project Structure

```
.
├── backend/
│   ├── app.py                    # Flask application
│   ├── database.py               # SQLite operations
│   ├── requirements.txt          # Python dependencies
│   ├── processors/               # Sport-specific processors
│   │   ├── football_processor.py
│   │   ├── basketball_processor.py
│   │   └── cricket_processor.py
│   ├── models/                   # Trained ML models (joblib)
│   ├── data/                     # Sample CSV datasets
│   ├── train_football_models.py  # Football model training
│   ├── train_basketball_models.py
│   ├── train_cricket_models.py
│   ├── train_models.py          # All-sports training
│   └── bootstrap.py             # Clean local initialization + dataset seed
│
├── frontend/
│   ├── public/
│   ├── src/
│   │   ├── App.js               # Main app component
│   │   ├── App.css              # Global styles
│   │   ├── pages/               # Page components
│   │   │   ├── Login.js
│   │   │   ├── Dashboard.js
│   │   │   ├── SinglePlayer.js
│   │   │   └── BulkUpload.js
│   │   └── components/ui/       # Shadcn UI components
│   └── package.json
│
└── README.md
```

## Model Training

Models are trained on sample datasets located in `backend/data/`. To retrain:

```bash
cd backend
python train_football_models.py
python train_basketball_models.py
python train_cricket_models.py
```

Training creates:
- `{sport}_scaler.joblib` - StandardScaler for features
- `{sport}_pca.joblib` - PCA model
- `{sport}_contribution_scaler.joblib` - Contribution scaler
- `{sport}_consistency_scaler.joblib` - Consistency scaler
- `{sport}_features.json` - Feature list

## Testing

### Backend Testing
```bash
cd backend

# Test health endpoint
curl http://127.0.0.1:5001/api/

# Test login
axios.post("http://127.0.0.1:5001/api/login", {
  username,
  password,
  role
});



### Frontend Testing
- Manual testing through UI
- Playwright tests can be added for automation

## Troubleshooting

**Models not found error:**
```bash
python train_football_models.py
python train_basketball_models.py
python train_cricket_models.py
```

**Database not initialized:**
```bash
python -c "from database import init_db; init_db()"
```

**Port already in use:**
- Change port in `app.py`: `app.run(port=5001)`

## Future Enhancements

- Add more sophisticated consistency calculations with rolling windows
- Implement player comparison feature
- Add export functionality (PDF reports)
- Implement advanced filtering and sorting
- Add more sports (Tennis, Baseball, etc.)
- Deploy to production with gunicorn/nginx

## License

MIT License

## Contributors

Built with Emergent AI


### Physical Fitness Attributes
The analyzer includes exactly three major physical fitness attributes: VO2 Max, 30m Sprint Time, and Strength Index (0-100). They are available in all three sport datasets, single-player entry, and bulk CSV upload. Fitness contributes 10% to the final Combined Score. Sample fitness values are illustrative.
