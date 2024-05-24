# Log Centralization with Filebeat

This repository is used to centralize logs from various applications using Filebeat. Logs are sent to a distant Elasticsearch instance and visualized using Kibana.

## Setup Instructions

### Prerequisites

- Docker
- Docker Compose

### Installation

1. **Clone the Repository**

   ```sh
   git clone https://github.com/your-organization/log-centralization.git
   cd log-centralization
   ```

2. **Configure Environment Variables**

   Create a `.env` file in the root of the repository with the following content, updating the placeholders as necessary:

   ```env
   # .env

   # App name and version to construct the service name
   APP_NAME=wonderful.api
   APP_VERSION=dev

   # Constructed service name based on app name and version
   SERVICE_NAME=${APP_NAME}-logs-${APP_VERSION}

   # Elasticsearch host URL
   ELASTICSEARCH_HOST=http://ec2-XXX-XXX-XXX-XXX.compute-1.amazonaws.com:9200

   # Elasticsearch username
   ELASTICSEARCH_USERNAME=elastic

   # Elasticsearch password
   ELASTICSEARCH_PASSWORD=changeme

   # Container name for the Filebeat service, derived from the service name
   CONTAINER_NAME=${SERVICE_NAME}-filebeat

   # Volume paths for the log files, making them dependent on the app name
   HOST_LOG_PATH=../storage/logs #log_path_of_the_app # SET the app logs path
   CONTAINER_LOG_PATH=/${SERVICE_NAME} # Maybe set /usr/share/filebeat/${SERVICE_NAME}

   # Path pattern for log files that Filebeat will monitor (all files in the log folder and subfolders)
   LOG_PATH=${CONTAINER_LOG_PATH}/**/*.log
   ```

3. **Install Docker and Docker Compose**

   If Docker and Docker Compose are not installed on your system, run the provided installation script:

   ```sh
   cd log-collector
   chmod +x install_docker.sh
   ./install_docker.sh
   ```

4. **Run Filebeat with Docker Compose**

   Navigate to the `log-collector` directory and start the Filebeat service:

   ```sh
   docker-compose up -d
   ```

## Usage

1. **Monitor Logs in Kibana**

   After starting the Filebeat service, you can monitor the logs in Kibana. Go to your Kibana instance and check for the new index patterns and logs.

2. **Index Pattern**

   Ensure that the correct index pattern is created in Kibana to visualize the logs. The index pattern should match the indices created by Filebeat.

## Filebeat Configuration

The Filebeat configuration is designed to be flexible and adapt to different applications by setting environment variables in the `.env` file. This allows developers to include this repository in the main folder of their projects and configure it according to their needs.

### Key Configuration Points

- **Service Name:** Constructed from the application name and version.
- **Log Paths:** Set the paths for the host and container where logs are stored.
- **Elasticsearch Connection:** Set the host, username, and password for connecting to Elasticsearch.

## Troubleshooting

If you encounter issues, check the following:

- Ensure the `.env` file is correctly configured.
- Verify that Docker and Docker Compose are properly installed.
- Check the logs for Filebeat and Elasticsearch containers for any errors.

## Contributing

Contributions are welcome! Please fork the repository and create a pull request with your changes.

## License

This project is licensed under the MIT License.

---
