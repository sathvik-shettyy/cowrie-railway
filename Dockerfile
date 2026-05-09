FROM python:3.11-slim

RUN useradd -m cowrieuser

RUN apt-get update && apt-get install -y \
    gcc \
    libssl-dev \
    libffi-dev \
    build-essential \
    procps \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# create venv in app (simpler + stable)
RUN python3 -m venv venv

RUN ./venv/bin/pip install --upgrade pip

# install cowrie directly (IMPORTANT FIX)
RUN ./venv/bin/pip install cowrie

# flask dashboard
RUN ./venv/bin/pip install flask

COPY dashboard.py .
COPY start.sh .
COPY cowrie /opt/cowrie/etc

RUN chmod +x start.sh

USER cowrieuser

EXPOSE 2222 2223 8080

CMD ["bash", "./start.sh"]
