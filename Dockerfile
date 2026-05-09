FROM python:3.11-slim

RUN useradd -m cowrie

RUN apt-get update && apt-get install -y \
    git gcc libssl-dev libffi-dev build-essential procps net-tools \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN git clone https://github.com/cowrie/cowrie.git

WORKDIR /opt/cowrie

RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN pip install flask

WORKDIR /app

COPY dashboard.py .
COPY start.sh .

RUN chmod +x start.sh

USER cowrie

EXPOSE 2222 2223 8080

CMD ["bash", "./start.sh"]
