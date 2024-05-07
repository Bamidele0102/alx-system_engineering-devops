#!/usr/bin/python3
"""
Query Reddit API and return the total number of subscribers
for a given subreddit
"""

import requests


def number_of_subscribers(subreddit):
    """
    get number of subscribers for a given subreddit
    return 0 if invalid subreddit given
    """
    url = "https://www.reddit.com/r/{}/about.json".format(subreddit)
    headers = {"User-Agent": "Mozilla/5.0"}
    response = requests.get(url, headers=headers, allow_redirects=False)
    if response.status_code == 200:
        data = response.json()
        subscribers = data['data']['subscribers']
        return subscribers
    else:
        return 0
