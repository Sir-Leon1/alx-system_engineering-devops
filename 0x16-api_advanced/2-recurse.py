#!/usr/bin/python3
"""Function to query a list of all hot posts on a given redit subreddit."""
import requests


def recurse(subreddit, hot_list=[], after="", count=0):
    """Return a list of titles of all hot posts on agiven subreddit"""
    url = "https://www.reddit.com/r/{}/hot/.json".format(subreddit)
    headers = {
        "User-Agent": "linux:api-advanced:v1.0.0 (by /u/SirLeon-1)"
    }
    params = {
        "after": after,
        "count": count,
        "limit": 100
    }
    resp = requests.get(url, headers=headers, params=params,
                        allow_redirects=False)
    if resp.status_code == 404:
        return None

    results = resp.json().get("data")
    after = results.get("after")
    count += results.get("dist")
    for c in results.get("children"):
        hot_list.append(c.get("data").get("title"))

    if after is None:
        return recurse(subreddit, hot_list, after, count)
    return hot_list
