# 🚀 Auto CTFd

Collection of Ansible roles designed to automate the deployment of multiple CTFd instances. This setup includes: the
deployment of multiple CTFd instances, Grafana for monitoring, MySQL for database management and backups,
MinIO S3 for object storage, Nginx as a load balancer and Certbot for HTTPS.

## 🛠️ Environment Setup

Create Python virtual environment:

```
poetry env use python3
poetry shell
```

Install project dependencies without installing the project package itself:

```
poetry install --no-root
```

Disable SSH key checking by Ansible for automated connections to hosts without manual intervention:

```
export ANSIBLE_HOST_KEY_CHECKING=False
```

Copy the sample group variables file to be used by Ansible:

```
cp group_vars/all.yml.sample group_vars/all.yml
```

Copy the sample inventory file to be used by Ansible:

```
cp inventory.yml.sample inventory.yml
```

## 🚢 Deploy CTFd

### 🔧 Prepare

Install Docker on the machines. This step ensures that Docker is installed and running on the target hosts, making them
ready to host the CTFd instances and other containerized services.

```
ansible-playbook -i inventory.yml docker.yml
```

### 📊 Monitoring

Set up Grafana monitoring. This playbook configures Grafana to monitor the performance and health of the CTFd instances.

```
ansible-playbook -i inventory.yml monitoring.yml
```

### 🗃️ Database

Deploy and configure the MySQL database. This step ensures that a MySQL database is set up for storing CTFd data.

```
ansible-playbook -i inventory.yml database.yml
```

Implement backup procedures for the database. This playbook configures backups to safeguard the data stored in MySQL.

```
ansible-playbook -i inventory.yml backup.yml
```

### 📦 S3 Storage

Configure MinIO S3 storage. This step sets up MinIO, an object storage solution, for storing files and assets used by
CTFd.

```
ansible-playbook -i inventory.yml minio.yml
```

### 🏁 CTFd

Deploy CTFd instances. This playbook rolls out multiple instances of CTFd for hosting capture the flag competitions.

```
ansible-playbook -i inventory.yml ctfd.yml
```

### ⚖️ Nginx Load Balancer

Configure Nginx as a load balancer. This final step sets up Nginx to distribute incoming traffic across the deployed
CTFd instances, improving load handling and reliability.

```
ansible-playbook -i inventory.yml nginx.yml
```
