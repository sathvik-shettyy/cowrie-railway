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

RUN git clone https://github.com/cowrie/cowrie.git

WORKDIR /opt/cowrie

RUN python -m venv cowrie-env

RUN . cowrie-env/bin/activate && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

COPY cowrie/cowrie.cfg /opt/cowrie/etc/cowrie.cfg
COPY cowrie/userdb.txt /opt/cowrie/etc/userdb.txt

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY dashboard.py .
COPY start.sh .

RUN chmod +x start.sh

EXPOSE 2222
EXPOSE 2223
EXPOSE 8080

CMD ["./start.sh"]
