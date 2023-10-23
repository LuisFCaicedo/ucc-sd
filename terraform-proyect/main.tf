terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_image" "image_firewall" {
  name = "api-firewall:latest"
}

resource "docker_container" "container_firewall" {
  name  = "firewall_container"
  image = docker_image.image_firewall.image_id

  restart = "on-failure"

  env = [
    "APIFW_URL=http://0.0.0.0:8080",
    "APIFW_API_SPECS=/opt/resources/httpbin.json",
    "APIFW_SERVER_URL=http://backend:80",
    "APIFW_SERVER_MAX_CONNS_PER_HOST=512",
    "APIFW_SERVER_READ_TIMEOUT=5s",
    "APIFW_SERVER_WRITE_TIMEOUT=5s",
    "APIFW_SERVER_DIAL_TIMEOUT=200ms",
    "APIFW_REQUEST_VALIDATION=BLOCK",
    "APIFW_RESPONSE_VALIDATION=BLOCK",
    "APIFW_DENYLIST_TOKENS_FILE=/opt/resources/tokens.denylist.db",
    "APIFW_DENYLIST_TOKENS_COOKIE_NAME=test",
    "APIFW_DENYLIST_TOKENS_HEADER_NAME=",
    "APIFW_DENYLIST_TOKENS_TRIM_BEARER_PREFIX=true"
  ]

  ports {
    internal = 8080
    external = 8080
  }

  volumes {
    container_path = "/opt/resources"
    host_path      = "/volumes/api-firewall"
    read_only      = true
  }


}

resource "docker_image" "image_nginx" {
  name = "nginx:latest"
}

resource "docker_container" "container_nginx" {
  name  = "nginx_container"
  image = docker_image.image_nginx.image_id

  ports {
    internal = 83
    external = 86
  }
}

resource "docker_image" "sonarqube" {
  name = "sonarqube:latest"
}
resource "docker_container" "sonarqube" {
  image = docker_image.sonarqube.name
  name  = "sonarqube"

  ports {
    internal = 9000
    external = 9000
  }
  lifecycle {
    ignore_changes = [image]
  }

}

resource "docker_image" "terrascan" {
  name = "tenable/terrascan:latest"
}
resource "docker_container" "terrascan" {
  image = docker_image.terrascan.name
  name  = "Container_tenable"

  ports {
    internal = 9010
    external = 9010
  }
  lifecycle {
    ignore_changes = [image]
  }

}



resource "docker_image" "openvas-scanner" {
  name = "greenbone/openvas-scanner:latest"
}

resource "docker_container" "openvas-scanner" {
  image = docker_image.openvas-scanner.name
  name  = "openvas-scanner_container"

  ports {
    internal = 7000
    external = 7000
  }

}

resource "docker_image" "redis" {
  name = "redis:latest"
}

resource "docker_container" "redis" {
  image = docker_image.redis.name
  name  = "redis_container"

  ports {
    internal = 6379
    external = 6379
  }


}

resource "docker_image" "image_postgres" {
  name = "postgres:latest"
}

resource "docker_container" "container_postgres" {
  name  = "postgres_container"
  image = docker_image.image_postgres.image_id

  env = [
    "POSTGRES_PASSWORD=Luisfercho2514*"
  ]

  ports {
    internal = 8080
    external = 1521
  }

}

