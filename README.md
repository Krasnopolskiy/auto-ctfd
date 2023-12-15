# 🚀 Auto CTFd

Collection of Ansible roles designed to automate the deployment of multiple CTFd instances. This setup includes: the
deployment of multiple CTFd instances, Grafana for monitoring, MySQL for database management and backups,
MinIO S3 for object storage, Nginx as a load balancer and Certbot for HTTPS.

## 🛠️ Environment Setup

Create Python virtual environment:

```bash
poetry env use python3
poetry shell
```

Install project dependencies without installing the project package itself:

```bash
poetry install
```

Disable SSH key checking by Ansible for automated connections to hosts without manual intervention:

```bash
export ANSIBLE_HOST_KEY_CHECKING=False
```

Copy the sample group variables file to be used by Ansible:

```bash
cp group_vars/all.yml.sample group_vars/all.yml
```

Fill with secure passwords:

```bash
python3 -c "import secrets; print(*[f'{service:10} {secrets.token_hex(16)}' for service in ['ctfd', 'database', 'cache', 'storage', 'monitoring']], sep='\n')"
```

> [!CAUTION]
> Remove service from all.yml if you don't need it.

Copy the sample inventory file to be used by Ansible:

```bash
cp inventory.yml.sample inventory.yml
```

Fill with actual hosts.

Enter Ansible playbooks directory:

```bash
cd auto_ctfd
```

## 🚢 Deploy CTFd

### 🔧 Prepare

Install Docker on the machines. This step ensures that Docker is installed and running on the target hosts, making them
ready to host the CTFd instances and other containerized services.

```bash
ansible-playbook -i inventory.yml docker.yml
```

### 📊 Monitoring

Set up Grafana monitoring. This playbook configures Grafana to monitor the performance and health of the CTFd instances.

```bash
ansible-playbook -i inventory.yml monitoring.yml
```

### 🗃️ Database

Deploy and configure the MySQL database. This step ensures that a MySQL database is set up for storing CTFd data.

```bash
ansible-playbook -i inventory.yml database.yml
```

Implement backup procedures for the database. This playbook configures backups to safeguard the data stored in MySQL.

```bash
ansible-playbook -i inventory.yml backup.yml
```

### 📦 S3 Storage

Configure MinIO S3 storage. This step sets up MinIO, an object storage solution, for storing files and assets used by
CTFd.

```bash
ansible-playbook -i inventory.yml minio.yml
```

### 🏁 CTFd

Deploy CTFd instances. This playbook rolls out multiple instances of CTFd for hosting capture the flag competitions.

```bash
ansible-playbook -i inventory.yml ctfd.yml
```

### ⚖️ Nginx Load Balancer

Configure Nginx as a load balancer. This final step sets up Nginx to distribute incoming traffic across the deployed
CTFd instances, improving load handling and reliability.

```bash
ansible-playbook -i inventory.yml nginx.yml
```
