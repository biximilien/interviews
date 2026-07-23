# Interview

As part of our technical assessment, we'd like to understand how you approach complex challenges. Could you please share a representative code example that you've written or significantly contributed to, which solves a non-trivial business problem and that you consider to be production-grade?

If possible, please include associated files such as unit tests or integration tests that accompany the code. If the solution naturally spans multiple files, feel free to share the relevant structure.
Please also provide:
  1. A brief description of the business problem the code addresses.
  2. Your specific role and contribution.
  3. Why you chose this particular example and what aspects you believe demonstrate its quality and complexity (e.g., regarding testing, error handling, maintainability, performance).

If you're unable to share code directly due to confidentiality, we're open to discussing a sanitized version, a relevant personal project, or a detailed walkthrough of the architecture and key code segments of such a project. Our goal is to understand your thought process and technical skills.

# Answer

For this assessment, I chose a recent project to which I made significant contributions.

I joined a small, bootstrapped ad-tech company as a Full-Stack Ruby on Rails developer. My initial responsibilities were to maintain its existing Rails monolith and provide technical support, allowing other developers to focus on refactoring critical systems.

The company operated a network of more than 20,000 Raspberry Pi–based digital signage players used in shopping centres, offices, restaurants, and outdoor displays. These devices reported operational and advertising metrics every 30 seconds to a Rails API. The same application also supported a SaaS analytics dashboard and an ad exchange serving both ad requests and proof-of-play events.

Although the system was a single Rails monolith, it was deployed across two large AWS EC2 instances. The ad exchange handled approximately 30 requests per second, while much of the analytics processing relied on Rails model callbacks and Delayed Job workers. This created substantial database load and led to recurring issues such as lock contention, deadlocked jobs, degraded performance, and API downtime.

The business then signed a major customer expected to add approximately 80 requests per second within six months. This would more than triple the existing traffic and exceed the capacity of the current architecture.

We addressed the problem by evolving the Rails monolith into a distributed architecture and extracting the ad exchange into dedicated microservices.

My main contributions included:

* Refactoring critical Rails components into independent services.
* Designing a data-processing pipeline orchestrated with Apache Airflow.
* Processing analytics workloads with Apache Spark on Amazon EMR.
* Engineering low-latency microservices for high-throughput advertising traffic.

I would be glad to discuss the architecture, implementation decisions, trade-offs, and outcomes with the hiring team.

# Submission

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
