version: '3.8'

networks:
  api-firewall-network:
    name: api-firewall-network

services:
  api-firewall:
    container_name: api-firewall
    image: wallarm/api-firewall:v0.6.13
    restart: on-failure
    volumes:
      - <HOST_PATH_TO_SPEC>:<CONTAINER_PATH_TO_SPEC>
    environment:
      APIFW_API_SPECS: <PATH_TO_MOUNTED_SPEC>
      APIFW_URL: <API_FIREWALL_URL>
      APIFW_SERVER_URL: <PROTECTED_APP_URL>
      APIFW_REQUEST_VALIDATION: <REQUEST_VALIDATION_MODE>
      APIFW_RESPONSE_VALIDATION: <RESPONSE_VALIDATION_MODE>
    ports:
      - "8088:8088"
    stop_grace_period: 1s
    networks:
      - api-firewall-network
  backend:
    container_name: api-firewall-backend
    image: kennethreitz/httpbin
    restart: on-failure
    ports:
      - 8090:8090
    stop_grace_period: 1s
    networks:
      - api-firewall-network
