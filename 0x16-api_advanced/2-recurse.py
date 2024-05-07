#!/usr/bin/python3

import requests


def recurse(subreddit, hot_list=None, after=None):
    """
    Recursively fetches titles of hot articles for a given subreddit.

    Args:
        subreddit (str): The name of the subreddit to fetch
        hot articles from.
        hot_list (list): A list to accumulate titles of
        hot articles. Defaults to None.
        after (str): A token indicating the start of
        the next page of results. Defaults to None.

    Returns:
        list: A list containing the titles of all hot articles
        for the given subreddit.
        If no results are found for the subreddit, returns None.
    """
    if hot_list is None:
        hot_list = []

    url = f"https://www.reddit.com/r/{subreddit}/hot.json"
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) '
                      'AppleWebKit/537.36 (KHTML, like Gecko) '
                      'Chrome/58.0.3029.110 Safari/537.3'
    }
    params = {'limit': 100, 'after': after}
    response = requests.get(url, headers=headers, params=params)

    if response.status_code == 200:
        data = response.json()
        posts = data['data']['children']
        for post in posts:
            hot_list.append(post['data']['title'])
        after = data['data']['after']
        if after is not None:
            return recurse(subreddit, hot_list, after)
        else:
            return hot_list
    else:
        return None
