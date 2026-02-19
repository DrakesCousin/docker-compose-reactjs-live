# 🚀 Docker Compose React.js Live Deployment

![GitHub release](https://img.shields.io/github/release/DrakesCousin/docker-compose-reactjs-live.svg)  
[![Releases](https://img.shields.io/badge/releases-latest-brightgreen)](https://github.com/DrakesCousin/docker-compose-reactjs-live/releases)

Welcome to the **docker-compose-reactjs-live** repository! This project provides a seamless way to live-deploy a React.js frontend using Docker, Bun, and Nginx. With this setup, you can pull the latest code from a private GitHub repository on container restart, install dependencies, build your application with Bun, and serve it through Nginx, all while maintaining persistent logs.

## Table of Contents

- [Features](#features)
- [Technologies Used](#technologies-used)
- [Getting Started](#getting-started)
- [Directory Structure](#directory-structure)
- [Configuration](#configuration)
- [Deployment Steps](#deployment-steps)
- [Logging](#logging)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## Features

- **Live Deployment**: Automatically pulls the latest code on container restart.
- **Fast Builds**: Uses Bun for efficient dependency management and building.
- **Nginx Integration**: Serves your React.js app with Nginx.
- **Persistent Logging**: Keeps logs available even after container restarts.

## Technologies Used

- **Docker**: For containerization.
- **Docker Compose**: To manage multi-container applications.
- **Bun**: A modern JavaScript runtime for faster builds.
- **Nginx**: A high-performance web server for serving static files.
- **React.js**: A JavaScript library for building user interfaces.

## Getting Started

To get started with this project, follow these steps:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/DrakesCousin/docker-compose-reactjs-live.git
   cd docker-compose-reactjs-live
   ```

2. **Download and Execute**:
   Visit the [Releases](https://github.com/DrakesCousin/docker-compose-reactjs-live/releases) section to download the latest release. Follow the instructions in the release notes to execute the setup.

3. **Build and Run**:
   Use Docker Compose to build and run the application:
   ```bash
   docker-compose up --build
   ```

4. **Access the Application**:
   Open your browser and navigate to `http://localhost` to view your live-deployed React.js application.

## Directory Structure

The project follows a simple directory structure:

```
docker-compose-reactjs-live/
├── docker-compose.yml
├── Dockerfile
├── nginx.conf
├── src/
│   ├── components/
│   ├── App.js
│   └── index.js
└── package.json
```

- **docker-compose.yml**: Defines the services, networks, and volumes.
- **Dockerfile**: Specifies how to build the application container.
- **nginx.conf**: Configuration file for Nginx.
- **src/**: Contains the React.js application source code.
- **package.json**: Lists the project dependencies.

## Configuration

### Dockerfile

The Dockerfile is responsible for building the React.js application. Here’s a basic outline:

```dockerfile
FROM node:18 AS builder

WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN bun build

FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
```

### docker-compose.yml

The `docker-compose.yml` file defines the services used in this project. Here’s a sample configuration:

```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "80:80"
    volumes:
      - ./src:/app/src
    restart: always
```

## Deployment Steps

1. **Set Up Environment Variables**: Ensure your environment variables are correctly set up for your private GitHub repository access.

2. **Run Docker Compose**: Execute the following command to start your application:
   ```bash
   docker-compose up --build
   ```

3. **Monitor Logs**: Check the logs for any errors or messages using:
   ```bash
   docker-compose logs -f
   ```

4. **Access Your Application**: Open a web browser and go to `http://localhost`.

## Logging

This setup ensures that all logs are persistent. You can access logs by executing:

```bash
docker-compose logs
```

For more detailed logs, you can specify the service:

```bash
docker-compose logs web
```

## Troubleshooting

If you encounter issues, consider the following steps:

- **Check Docker Installation**: Ensure Docker and Docker Compose are installed and running correctly.
- **Verify Environment Variables**: Ensure your environment variables for GitHub access are set correctly.
- **Inspect Logs**: Use the logging commands mentioned above to identify any issues.
- **Rebuild the Container**: Sometimes, rebuilding the container can resolve issues:
  ```bash
  docker-compose down
  docker-compose up --build
  ```

## Contributing

Contributions are welcome! If you have suggestions or improvements, feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Additional Resources

For more information, check the [Releases](https://github.com/DrakesCousin/docker-compose-reactjs-live/releases) section for updates and downloads.

---

Thank you for checking out the **docker-compose-reactjs-live** repository! We hope this setup makes your React.js deployment easier and more efficient.