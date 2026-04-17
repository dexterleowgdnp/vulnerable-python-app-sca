FROM python:3.8.10-slim

LABEL maintainer="SCA Lab"
LABEL version="1.0"
LABEL description="Vulnerable Python app for SCA testing"

WORKDIR /app

RUN pip install --upgrade pip==21.3.1

RUN apt-get update && apt-get install -y \
    gcc \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

RUN useradd -m -u 1000 appuser && chown -R appuser:appuser /app
USER appuser

EXPOSE 5001

CMD ["python", "app.py"]
