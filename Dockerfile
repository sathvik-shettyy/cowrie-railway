FROM python:3.11-slim

# Create non-root user FIRST (fixes Cowrie root restriction)
RUN useradd -m cowrieuser

# System dependencies
RUN apt-get update && apt-get install -y \
    git \
    gcc \
    libssl-dev \
    libffi-dev \
    build-essential \
    libpython3-dev \
    && rm -rf /var/lib/apt/lists/*

# Working directory
WORKDIR /opt

# Clone Cowrie (stable source)
RUN git clone --depth 1 https://github.com/cowrie/cowrie.git

WORKDIR /opt/cowrie

# Create venv
RUN python3 -m venv cowrie-env

# Install Cowrie properly inside venv
RUN /opt/cowrie/cowrie-env/bin/pip install --upgrade pip
RUN /opt/cowrie/cowrie-env/bin/pip install -r requirements.txt

# App files
WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY dashboard.py .
COPY start.sh .

# Copy config folder
COPY cowrie /opt/cowrie/etc

RUN chmod +x start.sh

# Fix permissions (IMPORTANT)
RUN chown -R cowrieuser:cowrieuser /opt/cowrie /app

USER cowrieuser

EXPOSE 2222 2223 8080

CMD ["bash", "./start.sh"]
