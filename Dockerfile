# Dockerfile (raíz del repo)
FROM python:3.11-slim

# Utilidades mínimas
RUN apt-get update && apt-get install -y --no-install-recommends curl \
  && rm -rf /var/lib/apt/lists/*

ENV PYTHONUNBUFFERED=1 PIP_NO_CACHE_DIR=1 PORT=8080
WORKDIR /app

# Instala deps primero para mejor cache
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia todo el código; esto deja tu carpeta /app/app con main.py adentro
COPY . .

# Arranque: escucha en 0.0.0.0 y en $PORT que Cloud Run te inyecta
CMD ["sh", "-lc", "uvicorn app.main:app --host 0.0.0.0 --port ${PORT}"]
