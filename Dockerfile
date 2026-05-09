FROM python:3.11-slim

RUN useradd -m cowrie

RUN apt-get update && apt-get install -y \
    git gcc libssl-dev libffi-dev build-essential procps net-tools \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN git clone https://github.com/cowrie/cowrie.git

WORKDIR /opt/cowrie

# IMPORTANT: DO NOT USE VENV ANYMORE
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt
RUN pip3 install flask

RUN chmod +x bin/cowrie || true

WORKDIR /app

COPY dashboard.py .
COPY start.sh .

RUN chmod +x start.sh

USER cowrie

EXPOSE 2222 8080

CMD ["bash", "./start.sh"]
