FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    git \
    gcc \
    libssl-dev \
    libffi-dev \
    build-essential \
    libpython3-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN git clone --depth 1 https://github.com/cowrie/cowrie.git

WORKDIR /opt/cowrie

RUN python3 -m venv cowrie-env

RUN /opt/cowrie/cowrie-env/bin/pip install --upgrade pip

RUN /opt/cowrie/cowrie-env/bin/pip install .

COPY cowrie/cowrie.cfg /opt/cowrie/etc/cowrie.cfg
COPY cowrie/userdb.txt /opt/cowrie/etc/userdb.txt

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY dashboard.py .
COPY start.sh .

RUN chmod +x start.sh

EXPOSE 2222
EXPOSE 2223
EXPOSE 8080

CMD ["bash", "./start.sh"]
