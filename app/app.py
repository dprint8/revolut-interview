from flask import Flask, request, jsonify
from datetime import datetime
import os

import sqlite3

app = Flask(__name__)

# DB setup
conn = sqlite3.connect(':memory:', check_same_thread=False)

conn.execute('''CREATE TABLE users
             (username TEXT PRIMARY KEY NOT NULL,
             date_of_birth DATE NOT NULL);''')
conn.commit()

# API to save/update user's name and date of birth
@app.route('/hello/<username>', methods=['PUT'])
def save_user_info(username):
    data = request.get_json()
    date_of_birth = data.get('dateOfBirth')

    # Validate username and date format
    if not username.isalpha():
        return jsonify({"error": "Username must contain only letters"}), 400

    try:
        dob = datetime.strptime(date_of_birth, '%Y-%m-%d').date()
    except ValueError:
        return jsonify({"error": "Invalid date format (YYYY-MM-DD)"}), 400

    if dob >= datetime.today().date():
        return jsonify({"error": "Date of birth must be before today"}), 400

    # Save user
    cursor = conn.cursor()
    cursor.execute('INSERT OR REPLACE INTO users (username, date_of_birth) VALUES (?, ?)', (username, date_of_birth))
    conn.commit()

    return '', 204


@app.route('/hello/<username>', methods=['GET'])
def get_hello_message(username):
    cursor = conn.cursor()
    cursor.execute('SELECT date_of_birth FROM users WHERE username=?', (username,))
    row = cursor.fetchone()

    if row is None:
        return jsonify({"error": "User not found"}), 404

    date_of_birth = row[0]
    days_until = (datetime.strptime(date_of_birth, '%Y-%m-%d').date() - datetime.today().date()).days

    if days_until == 0:
        message = f"Hello, {username}! Happy birthday!"
    else:
        message = f"Hello, {username}! Your birthday is in {days_until} day(s)"

    return jsonify({"message": message})

@app.route('/health', methods=['GET'])
def health_check():
    return '', 200

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0', port=80)
