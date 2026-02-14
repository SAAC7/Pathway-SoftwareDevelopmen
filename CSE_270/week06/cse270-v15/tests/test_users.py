import requests


def test_users_valid_credentials():
    url = "http://127.0.0.1:8000/users/?username=admin&password=qwerty"
    response = requests.get(url)

    assert response.status_code == 200


def test_users_invalid_credentials():
    url = "http://127.0.0.1:8000/users/?username=admin&password=admin"
    response = requests.get(url)

    assert response.status_code == 401
