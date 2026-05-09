from flask import Flask
import sqlite3
import os

app = Flask(__name__)

DB_PATH = "/opt/cowrie/var/lib/cowrie/cowrie.db"

HTML = """
<!DOCTYPE html>
<html>
<head>
    <title>Cowrie Dashboard</title>

    <meta http-equiv="refresh" content="15">

    <style>
        body {
            background: #0f172a;
            color: #e2e8f0;
            font-family: Arial;
            padding: 20px;
        }

        h1 {
            color: #38bdf8;
        }

        .card {
            background: #1e293b;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        td, th {
            border: 1px solid #334155;
            padding: 10px;
            text-align: left;
        }

        tr:nth-child(even) {
            background: #1e293b;
        }

        .small {
            color: #94a3b8;
            font-size: 14px;
        }
    </style>
</head>

<body>

    <h1>🐮 Cowrie Honeypot Dashboard</h1>

    <div class="card">
        <p class="small">
            Auto refresh every 15 seconds
        </p>
    </div>

    {table}

</body>
</html>
"""

@app.route("/")
def home():

    if not os.path.exists(DB_PATH):
        return """
        <h1>🐮 Cowrie Dashboard</h1>
        <p>Database not created yet.</p>
        <p>Wait for SSH/Telnet attacks.</p>
        """

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    try:
        cursor.execute("""
            SELECT
                ip,
                username,
                password,
                timestamp
            FROM auth
            ORDER BY timestamp DESC
            LIMIT 50
        """)

        rows = cursor.fetchall()

        table = """
        <div class='card'>
        <h2>Recent Login Attempts</h2>

        <table>
            <tr>
                <th>IP Address</th>
                <th>Username</th>
                <th>Password</th>
                <th>Timestamp</th>
            </tr>
        """

        for row in rows:
            table += f"""
            <tr>
                <td>{row[0]}</td>
                <td>{row[1]}</td>
                <td>{row[2]}</td>
                <td>{row[3]}</td>
            </tr>
            """

        table += "</table></div>"

    except Exception as e:
        table = f"""
        <div class='card'>
            <h2>Database Error</h2>
            <p>{str(e)}</p>
        </div>
        """

    conn.close()

    return HTML.format(table=table)

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8080))
    app.run(host="0.0.0.0", port=port)
