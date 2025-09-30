import os
import requests

API_URL = "http://api:8000"



tests = [
    {"username": "alice", "password": "wonderland", "version": "v1", "expected_status": 200},
    {"username": "alice", "password": "wonderland", "version": "v2", "expected_status": 200},
    {"username": "bob", "password": "builder", "version": "v1", "expected_status": 200},
    {"username": "bob", "password": "builder", "version": "v2", "expected_status": 403},
]

log_output = '''
============================
    Authorization test
============================
\n'''

# affichage des résultats
for test in tests:
    response = requests.get(
        f"{API_URL}/{test['version']}/sentiment",
        params={"username": test["username"], "password": test["password"], "sentence": "life is beautiful"}
    )
    status = "SUCCESS" if response.status_code == test["expected_status"] else "FAILURE"
    log_output += f"Test {test['username']} on {test['version']}: Expected {test['expected_status']}, Got {response.status_code} → {status}\n"

print(log_output)

# impression dans un api_test.log
if os.getenv("LOG") == "1":
    with open("api_test.log", "a") as log_file:
        log_file.write(log_output)

