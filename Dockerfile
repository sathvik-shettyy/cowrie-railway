FROM cowrie/cowrie:latest

USER root

# add flask for dashboard only
RUN pip install flask

WORKDIR /app

COPY dashboard.py .
COPY cowrie /etc/cowrie

EXPOSE 2222 2223 8080

CMD ["cowrie", "start"]
