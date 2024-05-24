# Elasticsearch and Kibana Setup

This repository sets up an Elasticsearch and Kibana instance using Docker Compose. It is designed to work seamlessly with the Filebeat configuration for log centralization.

## Setup Instructions

### Prerequisites

- Docker
- Docker Compose

### Installation

1. **Clone the Repository**

   ```sh
   git clone https://github.com/your-organization/log-centralization.git
   cd log-centralization/monitor
   ```

2. **Install Docker and Docker Compose**

   If Docker and Docker Compose are not installed on your system, run the provided installation script:

   ```sh
   chmod +x install_docker.sh
   ./install_docker.sh
   ```

3. **Start Elasticsearch and Kibana**

   Navigate to the `monitor` directory and start the services:

   ```sh
   docker-compose up --build -d
   ```

4. **Generate Elasticsearch Passwords**

   After the services are up, generate the passwords for Elasticsearch:

   ```sh
   docker exec -it log-centralization-elasticsearch-1 bin/elasticsearch-setup-passwords auto

   ```

   Ensure that the container name `log-centralization-elasticsearch-1` matches the actual name created by Docker Compose.

   Save the generated passwords then update the `.env` file and restart this container.

   Later on, if a password reset is need:

   ```sh
   docker exec -it log-centralization-elasticsearch-1 bin/elasticsearch-reset-password -u <username>


   docker restart log-centralization-elasticsearch-1

   ```

5. **Generate API Key for Elasticsearch**

   Create an API key for accessing Elasticsearch:

   ```sh
   curl -X POST "http://localhost:9200/_security/api_key" -H "Content-Type: application/json" -u "elastic:changeme" -d '{
     "name": "my_api_key"
   }'
   ```

   Save the output and use the encoded key as a token for authentication, if needed.

   For testing the generated token you can use the command below.

   ```sh
   curl -X GET "http://localhost:9200/_cluster/health" \
   -H "Authorization: ApiKey your_generated_api_key"
   ```

6. **Generate Kibana Encryption Keys**

   Generate encryption keys for Kibana:

   ```sh
   docker exec -it log-centralization-kibana-1 bin/kibana-encryption-keys generate --force
   ```

   Ensure that the container name `log-centralization-kibana-1` matches the actual name created by Docker Compose.

   Save the generated keys and update the `.env` file.

7. **Update the .env File**

   Update the `.env` file with the generated credentials and any other necessary configuration.

8. **Restart the Services**

   Restart the services to apply the new configurations:

   ```sh
   docker-compose restart
   ```

### Usage

1. **Request Elasticsearch**

   Verify the Elasticsearch setup by making a request:

   ```sh
   curl -u elastic:changeme http://localhost:9200
   ```

2. **Access Kibana**

   Once the services are running, access Kibana in your browser at `http://localhost:5601`.

3. **Login to Kibana**

   Use the credentials generated in the previous steps to log in as user `elastic`.

4. **Configure Index Patterns in Kibana**

   Set up index patterns in Kibana to match the logs indexed by Filebeat.

### Configuration

- **Elasticsearch Configuration:** Located at `es/elasticsearch.yml`
- **Kibana Configuration:** Located at `kibana/kibana.yml`

### Uninstallation

To stop and remove the containers and networks created by Docker Compose, run the following script:

```sh
chmod +x uninstall_docker.sh
./uninstall_docker.sh
```

## Troubleshooting

If you encounter issues, check the following:

- Ensure Docker and Docker Compose are properly installed.
- Verify the configuration files (`elasticsearch.yml` and `kibana.yml`) are correctly set up.
- Check the logs for Elasticsearch and Kibana containers for any errors.

## Contributing

Contributions are welcome! Please fork the repository and create a pull request with your changes.

## License

This project is licensed under the MIT License.
