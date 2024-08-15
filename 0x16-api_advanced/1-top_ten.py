#!/usr/bin/python3
"""Function to print hot posts on a given Reddit subreddit."""
import requests


def top_ten(subreddit):
    """Print the titles of the 10 hottest posts on a given subreddit."""
    url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
    headers = {
        "User-Agent": "linux:api-advanced:v1.0.0 (by /u/SirLeon-1)"
    }
    params = {
        "limit": 10
    }

    resp = requests.get(url, headers=headers, params=params,
                        allow_redirects=False)
    if resp.status_code == 404:
        print("None")
        return
    results = resp.json().get("data")
    [print(c.get("data").get("title")) for c in results.get("children")]
