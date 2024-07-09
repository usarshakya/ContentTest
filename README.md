# Content Test Backend
This repository demonstrates a REST API implementation in Rails using standard JSON API serialization. It includes JWT-based user token authentication, providing a secure and efficient way to manage user sessions and API access. The project showcases best practices for building robust and scalable APIs in Rails.

## Prerequisites
Before you begin, ensure you have the following installed on your local machine:
- [Ruby](https://www.ruby-lang.org/en/downloads/) (version 3.3.1) - The programming language used by Rails.
- [Rails](https://rubyonrails.org/) (version 7.1.3 (>= 7.1.3.3)) - A web application framework for Ruby.
- [PostgreSQL](https://www.postgresql.org/download/) - An open-source relational database system.
- Docker (optional, for containerized setup)

## Setup Instructions
1. Clone the Project
  Clone the repository to your local machine:
  ```sh
  git clone git@github.com:usarshakya/ContentTest.git
  ```

2. Navigate into the project directory:
  ```sh
    cd ContentTest
  ```

3. Install Dependencies
  Install the required gems using Bundler:
  ```sh
  bundle install
  ```

4. Set Up Environment Variables
  Create a .env file in the project directory and add the following environment variables:
  ```sh
  DB_USERNAME=<your_database_username>
  DB_PASSWORD=<your_database_password>
  DB_NAME=<your_database_name>
  ```

5. Database Setup
  Set up the database by running the following commands:

  ```sh
  rails db:create
  rails db:migrate
  ```

6. Run Tests
  Run the tests using RSpec:
  ```sh
  bundle exec rspec
  ```

## Docker Setup

1. Build Docker Image
  Build the Docker image for the application:

  ```sh
  docker build -t content_test_api:latest .
  ```

2. Run the Application Using Docker Compose
  Run the application in detached mode using Docker Compose:

  ```sh
  docker-compose up -d
  ```

## Postman Collection
Here is the postman collection link:
[Content Test Backend](https://documenter.getpostman.com/view/2716857/2sA3QqhYn9)

### Troubleshooting
If you encounter any issues during setup or running the application, consider the following:

- Verify that you have the correct versions of Ruby, Rails, and PostgreSQL installed.
- Ensure your .env file contains the correct database credentials.
- Check if the PostgreSQL service is running and accessible.
- Refer to the application's logs for more details on any errors.
