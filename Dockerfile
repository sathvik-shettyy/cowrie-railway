FROM python:3.11-slim

RUN apt-get update && apt-get install -y net-tools

RUN useradd -m cowrie

RUN apt-get update && apt-get install -y \
    git gcc libssl-dev libffi-dev build-essential procps \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

# Install Cowrie cleanly
RUN git clone https://github.com/cowrie/cowrie.git

WORKDIR /opt/cowrie

RUN python3 -m venv venv
RUN ./venv/bin/pip install --upgrade pip
RUN ./venv/bin/pip install -r requirements.txt

RUN ./venv/bin/pip install flask

WORKDIR /app

COPY dashboard.py .
COPY start.sh .
COPY cowrie /opt/cowrie/etc

RUN chmod +x start.sh

USER cowrie

EXPOSE 2222 2223 8080

CMD ["bash", "./start.sh"]
