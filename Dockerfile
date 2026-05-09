FROM python:3.11-slim

RUN useradd -m cowrieuser

RUN apt-get update && apt-get install -y \
    git \
    gcc \
    libssl-dev \
    libffi-dev \
    build-essential \
    procps \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

# INSTALL STABLE RELEASE (NOT master branch)
RUN git clone --depth 1 https://github.com/cowrie/cowrie.git

WORKDIR /opt/cowrie

RUN python3 -m venv cowrie-env

RUN /opt/cowrie/cowrie-env/bin/pip install --upgrade pip

# IMPORTANT FIX: install properly as package
RUN /opt/cowrie/cowrie-env/bin/pip install .

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir flask

COPY dashboard.py .
COPY start.sh .

COPY cowrie /opt/cowrie/etc

RUN chown -R cowrieuser:cowrieuser /opt/cowrie /app

USER cowrieuser

EXPOSE 2222 2223 8080

CMD ["bash", "./start.sh"]
