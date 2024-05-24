# Dockerfile

# Use the official Filebeat Docker image
FROM docker.elastic.co/beats/filebeat:8.13.4

# Copy the Filebeat configuration file into the container
COPY filebeat.yml /usr/share/filebeat/filebeat.yml

# Ensure the Filebeat directory and files are owned by root
USER root
RUN chown -R root /usr/share/filebeat/
RUN chmod -R go-w /usr/share/filebeat/