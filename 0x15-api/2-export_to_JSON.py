#!/usr/bin/python3
"""Using the task #0 to extend the Python script
    to export data in the JSON format.
"""
import json
import requests
import sys

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 script.py [employee_id]")
        sys.exit(1)

    url = "https://jsonplaceholder.typicode.com/"
    user_id = sys.argv[1]

    user_response = requests.get(url + "users/{}".format(user_id))
    todos_response = requests.get(url + "todos", params={"userId": user_id})

    if user_response.status_code != 200 or todos_response.status_code != 200:
        print("Error: Unable to retrieve data.")
        sys.exit(1)

    user_data = user_response.json()
    todos_data = todos_response.json()

    user_tasks = []
    for todo in todos_data:
        user_tasks.append({
            "task": todo["title"],
            "completed": todo["completed"],
            "username": user_data["username"]
        })

    output_data = {user_id: user_tasks}
    output_file = "{}.json".format(user_id)

    with open(output_file, "w") as file:
        json.dump(output_data, file)

    print("Data exported to {} successfully.".format(output_file))
