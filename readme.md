# Log Centralization

This repository contains the configuration and setup files for centralizing logs from various applications using the Elasticsearch, Kibana, and Filebeat stack.

## Repository Structure

```plaintext
log-centralization
├── monitor
│   ├── command.txt
│   ├── docker-compose.yml
│   ├── es
│   │   └── elasticsearch.yml
│   ├── install_docker.sh
│   ├── kibana
│   │   └── kibana.yml
│   ├── readme.md
│   ├── uninstall_docker.sh
│   └── .env.sample       <-- Rename to .env and fill it up
├── log-collector
│   ├── docker-compose.yml
│   ├── filebeat
│   │   ├── Dockerfile
│   │   └── filebeat.yml
│   ├── install_docker.sh
│   ├── readme.md
│   ├── uninstall_docker.sh
│   └── .env.sample       
└── readme.md
```

## Setup Instructions

### Prerequisites

- Docker
- Docker Compose

### Installation

1. **Clone the Repository**

   ```sh
   git clone https://github.com/your-organization/log-centralization.git
   ```

2. **Folder Management**

   This system is a 2-in-1 setup.

   Copy the `monitor` directory itself to the server dedicated to monitoring.

   Copy the `log-collector` directory itself to the deployment/production server, placing it in the main directory of the service, app, or API to be monitored.

### Configuration Files

To configure the environment variables, rename `.env.sample` to `.env` in both the monitor and log-collector directories. Then, fill in the `.env` file with the necessary configurations.

- **Elastic & Kibana:** Located at `monitor/.env`
- **Filebeat Configuration:** Located at `log-collector/.env`

Do not modify the following configuration files:

- **Elasticsearch Configuration:** Located at `monitor/es/elasticsearch.yml`
- **Kibana Configuration:** Located at `monitor/kibana/kibana.yml`
- **Filebeat Configuration:** Located at `log-collector/filebeat/filebeat.yml`

### Elasticsearch and Kibana Setup

Below is a summary of the steps. Detailed instructions are available in the *readme* of the `monitor` directory.

1. **Navigate to the `monitor` directory**

   ```sh
   cd monitor
   ```

2. **Start Elasticsearch and Kibana**

   ```sh
   docker-compose up --build -d
   ```

3. **Generate Elasticsearch Passwords**

   ```sh
   docker exec log-centralization-elasticsearch-1 bin/elasticsearch-setup-passwords auto
   ```

   Ensure the container name `log-centralization-elasticsearch-1` matches the actual name created by Docker Compose.

4. **Generate API Key for Elasticsearch**

   ```sh
   curl -X POST "http://localhost:9200/_security/api_key" -H "Content-Type: application/json" -u "elastic:changeme" -d '{
     "name": "my_api_key"
   }'
   ```

5. **Generate Kibana Encryption Keys**

   ```sh
   docker exec -it log-centralization-kibana-1 bin/kibana-encryption-keys generate
   ```

   Ensure the container name `log-centralization-kibana-1` matches the actual name created by Docker Compose.

6. **Manually Update the .env File**

   Update the `.env` file with the generated credentials and any other necessary configuration.

7. **Restart the Services**

   ```sh
   docker-compose down
   docker-compose up --build -d
   ```

### Filebeat Setup

1. **Navigate to the `log-collector` directory**

   ```sh
   cd log-collector
   ```

2. **Configure Environment Variables**

   Create a `.env` file in the `log-collector` directory with the necessary configurations.

3. **Start Filebeat**

   ```sh
   docker-compose up --build -d
   ```

### Usage

1. **Log Monitoring**

   Once the services are running, access Kibana in your browser at `http://<HOST>:5601`. Use the credentials generated (username `elastic`) during setup to log in.

2. **Configure Index Patterns in Kibana**

   Set up index patterns in Kibana to match the logs indexed by Filebeat.

### Uninstallation

To stop and remove the containers and networks created by Docker Compose, run the following commands:

```sh
cd monitor
docker-compose down
```

```sh
cd log-collector
docker-compose down
```

## Troubleshooting

If you encounter issues, check the following:

- Ensure Docker and Docker Compose are properly installed.
- Verify the `.env` files are correctly set up.
- Check the logs for Elasticsearch, Kibana, and Filebeat containers for any errors.

## Contributing

Contributions are welcome! Please fork the repository and create a pull request with your changes.

## License

This project is licensed under the MIT License.

---

Feel free to ask if you need any further modifications!