FROM python:3.11-slim

RUN useradd -m cowrie

RUN apt-get update && apt-get install -y \
    git gcc libssl-dev libffi-dev build-essential procps net-tools \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

# install Cowrie properly
RUN git clone https://github.com/cowrie/cowrie.git

WORKDIR /opt/cowrie

# IMPORTANT: create venv INSIDE correct directory
RUN python3 -m venv /opt/cowrie/venv

RUN /opt/cowrie/venv/bin/pip install --upgrade pip
RUN /opt/cowrie/venv/bin/pip install -r requirements.txt
RUN /opt/cowrie/venv/bin/pip install flask

WORKDIR /app

COPY dashboard.py .
COPY start.sh .

RUN chmod +x start.sh

USER cowrie

EXPOSE 2222 8080

CMD ["bash", "./start.sh"]
