# Pizza Delivery API

This application is a backend application to act as an API for a Pizza Delivery application. The interaction will be made via HTTP requests and the database used is the MySQL Database.

In order to run the application, before the database must be created. It can be running either in a Docker Container (`docker-compose.yaml` file is available) or a local MySQL Server or even in a remote server or VPS.

The database configuration script is also included in the repository (`database_script/db_script.sql`).

## Running the Application

Before starting the application, be sure that you have Dart SDK and Aqueduct installed and configured. Then:

- Clone the repository
- Run `pub get` in the project's root directory
- Run `aqueduct serve -a 0.0.0.0` (the **-a** flag is important if you want to access the server through the network)
  - The standard port is the 8888. If you'd like to change it, just include the flag **-p** and pass the new port number

## Deploying an Application

See the documentation for [Deployment](https://aqueduct.io/docs/deploy/).
