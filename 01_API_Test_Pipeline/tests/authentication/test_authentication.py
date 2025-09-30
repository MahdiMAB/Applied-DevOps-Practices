import os
import requests

API_URL = "http://api:8000"

# Liste des utilisateurs 
users = [
    {"username": "alice", "password": "wonderland", "expected_status": 200},
    {"username": "bob", "password": "builder", "expected_status": 200},
    {"username": "clementine", "password": "mandarine", "expected_status": 403}
]

# entête de l'affichage 
log_output = '''
============================
    Authentication test
============================\n'''

# affichage des résultats
for user in users:
    response = requests.get(f"{API_URL}/permissions", params=user)
    status = "SUCCESS" if response.status_code == user["expected_status"] else "FAILURE"
    log_output += f"Test {user['username']}: Expected {user['expected_status']}, Got {response.status_code} ==> {status}\n"

print(log_output)

# impression dans api_test.log
if os.getenv("LOG") == "1":
    with open("api_test.log", "a") as log_file:
        log_file.write(log_output)

