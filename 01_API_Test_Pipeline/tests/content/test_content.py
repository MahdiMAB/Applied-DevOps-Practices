import os
import requests

API_URL = "http://api:8000"

# Liste des phrases à tester
test_sentence = [
    {"sentence": "life is beautiful", "expected_result": 1},
    {"sentence": "that sucks", "expected_result": -1}
]

log_output = '''
============================
    Content test
============================ \n'''

# affichage des résultats
for test in test_sentence:  
    response = requests.get(
        f"{API_URL}/v1/sentiment",
        params={"username": "alice", "password": "wonderland", "sentence": test["sentence"]}
    )
    result = response.json().get("score", 0) 
    status = "SUCCESS" if (result > 0 and test["expected_result"] > 0) or (result < 0 and test["expected_result"] < 0) else "FAILURE"
    log_output += f"Test '{test['sentence']}': Expected {test['expected_result']}, Got {result} → {status}\n"

print(log_output)

# Sauvegarder les logs dans api_test.log
if os.getenv("LOG") == "1":
    with open("api_test.log", "a") as log_file:
        log_file.write(log_output)

