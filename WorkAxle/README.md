# Upgraded Parakeet

An example of a very simple Ruby microservice that serves static images as ads.

## Getting Started

### Prerequisites

This application requires Docker to be installed on your machine. You can download it from [Docker's official website](https://www.docker.com/get-started).

It also requires Docker Compose to be installed. You can download it from [Docker's official website](https://docs.docker.com/compose/install/).

#### ASDF & Direnv

I used `asdf` and `direnv` to manage the Ruby version and environment variables. You can install them from their respective websites:

- [asdf](https://asdf-vm.com/)
- [direnv](https://direnv.net/)
- [asdf-ruby](https://github.com/asdf-vm/asdf-ruby)

They are not required to run the application using Docker, but they are very useful for development.

### Create the Docker network

```sh
docker network create upgraded-parakeet-network
```

### Run docker compose

```
docker compose up
```

### Open the demo ad player in a browser

```sh
firefox ad-player.html
```

### Notes

The bruno collection used to develop the backend is provided in the `bruno` folder.
You can get Bruno from their [official website](https://usebruno.com/).
