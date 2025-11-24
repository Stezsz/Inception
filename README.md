# Inception – 42 School Project

The **Inception** project is a deep dive into System Administration and DevOps, focusing on the broadening of knowledge regarding system virtualization using Docker. The goal is to virtualize a complete infrastructure by creating a custom Docker image for several services, orchestrating them with Docker Compose, and ensuring they interact securely and efficiently on a specific network architecture.

## Main Objectives

* Virtualize a complete infrastructure using **Docker** and **Docker Compose**.
* Build custom Docker images from `Alpine Linux` or `Debian` (without using ready-made service images).
* Understand and implement **Container Orchestration**.
* Configure a secure web server with **NGINX** and **TLS/SSL**.
* Set up a **WordPress** site running on **PHP-FPM**.
* Manage a **MariaDB** database with persistent storage.
* Master the concepts of Docker networks, volumes, and isolate services.

## Key Features

* **Custom Dockerfiles:** Every service (NGINX, WordPress, MariaDB) is built from a minimal OS image (Alpine Linux), requiring manual installation and configuration of packages and entrypoint scripts.
* **Service Orchestration:** Uses `docker-compose.yml` to launch and manage the entire stack with a single command, defining dependencies and restart policies.
* **Secure Connection (HTTPS):** NGINX is configured as the only entry point, handling TLS v1.2/v1.3 encryption with self-signed certificates and forwarding requests to WordPress.
* **Data Persistence:** Docker Volumes are configured for the Database and WordPress files, ensuring data remains intact even if containers are stopped or restarted.
* **Network Isolation:**
    * Containers communicate via an internal Docker network.
    * The Database (MariaDB) is not exposed to the outside world, only accessible by the WordPress container.
* **Environment Configuration:** Extensively uses `.env` files to manage secrets, credentials, and configuration paths securely, avoiding hardcoded sensitive data.

## Conclusion

The **Inception** project is a pivotal step in understanding modern deployment strategies. It moves beyond simple coding into the realm of infrastructure as code. By completing this project, one gains a rigorous understanding of how to build, secure, and manage microservices, handling the complexities of networking, persistence, and system configuration in a containerized environment.

---

✅ **Final Grade: 100/100**
**Project made at** [42 Lisboa](https://www.42lisboa.com/)
👤 **Author:** Stephan Rodrigues Lassaponari ([@Stezsz](https://github.com/Stezsz))
