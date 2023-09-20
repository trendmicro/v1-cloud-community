import requests
import random
from datetime import date
import calendar

current_date = date.today()
weekday=calendar.day_name[current_date.weekday()]

def get_random_word():
    api_url = "https://random-word-api.herokuapp.com/word"
    try:
        response = requests.get(api_url)
        data = response.json()

        if data != '':
            word = data[0]
            return word
        else:
            return weekday
    except Exception as e:
        print(f"An error occurred: {e}")
        return weekday

def get_random_docker_image(search_term):
    # Define the Docker Hub Search API URL
    api_url = f"https://hub.docker.com/v2/search/repositories/?query={search_term}"
    success = False
    attempts = 0
    while attempts < 3 and not success:
        try:
        # Fetch the list of repositories from Docker Hub search
            response = requests.get(api_url)
            data = response.json()

            if "results" in data:
                repositories = data["results"]

                if repositories:
                # Choose a random repository
                    random_repository = random.choice(repositories)
                    print (random_repository)
                # Extract the repository name and owner
                    repository_name = random_repository["repo_name"]
                    owner = random_repository["repo_owner"]

                # Construct the full image name
                    image_name = f"{owner}/{repository_name}"

                    success = True
                    return image_name

        except Exception as e:
            print(f"An error occurred: {e}")
            attempts += 1
            if attempts ==3:
                break

if __name__ == "__main__":
    search_term = get_random_word() + " " + get_random_word()
    random_image = get_random_docker_image(search_term)

    if random_image:
        print(random_image)
