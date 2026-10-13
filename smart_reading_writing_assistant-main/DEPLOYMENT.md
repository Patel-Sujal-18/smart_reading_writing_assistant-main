# Deployment

## Backend — Render
1. Create a Render Web Service from this GitHub repository.
2. Build command: `pip install -r requirements.txt`
3. Start command: `uvicorn backend:app --host 0.0.0.0 --port $PORT`
4. Copy the resulting API URL.

## Frontend — Vercel
1. Import the same repository into Vercel.
2. Set **Root Directory** to `frontend`.
3. Framework: Vite.
4. Add environment variable `VITE_API_URL` with the Render backend URL.
5. Deploy.

The final Vercel URL is the premium React UI. It calls the FastAPI backend for the actual NLP pipeline.
