  

# Library-Manager
<img src="assets/Screenshot (74).png"  width="100%"/>

  

This project is a fully Dockerized and DevOps-enabled Library Management System. It includes a Spring Boot backend and a MySQL database, orchestrated using Docker Compose and automated with Jenkins CI/CD pipelines.

  

## Original Repository & Credits

  

- Original repository: [Guntuku12/Library_Manager](https://github.com/Guntuku12/Library_Manager.git)

- Original Author: Sanjay ([Guntuku12](https://github.com/Guntuku12))

- DevOps, Dockerization, and enhancements: Harsha ([Harshavardhanchary](https://github.com/Harshavardhanchary))

  

## Features

-   **Dockerized** backend (Spring Boot) and database (MySQL).
-   Multi-container setup using `docker-compose`.
-   **CI** with Jenkins pipeline (build, test, and deploy automation).
-   GitHub webhook integration for automated builds on code push.
-   **CD** with Argo CD for Kubernetes deployments.
-   Two-tier architecture (backend + database).
-   Environment variables for sensitive data handling.
-   Deployable on local, AWS EC2, or k3s Kubernetes cluster.

### Application Features
-   Add, update, and list books.
-   Manage library members with contact details.
-   Issue and return books with due date tracking.
-   Track overdue books.
-   Search and filter books by title and number.
-   Store all data in a MySQL database with custom SQL queries.
  

## Prerequisites

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/)
- [Jenkins](https://www.jenkins.io/) for CI/CD
- [k3s](https://k3s.io/) (installed on EC2 for lightweight Kubernetes cluster)
- [ArgoCD](https://argo-cd.readthedocs.io/) (deployed in k3s for GitOps CD)

 
## Instance-Creation
 - First Launch an EC2 Instance
 - Here I have used  `c7i-flex.large` EC2 instance.
 
## Installation

```sh
sudo  apt  update

sudo  apt  upgrade  -y
```
 **Docker-compose Installation:**

```
sudo apt install docker-compose -y
```

2. **Jenkins-Installation:**

```
sudo apt install openjdk-21-jre-headless -y
```
```
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
 https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
 echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
 https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
 /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y
```

3.  **User-Access:**

Grant permission for ubuntu (your-user) to access docker
```
sudo usermod -aG docker ubuntu
```
 Grant permission for Jenkins to access docker
```
sudo usermod -aG docker jenkins
```
Restart Jenkins after downloading plugins and added the credentials
```
sudo systemctl restart jenkins
```

4.**Restart the instance:**
Logout from the instance and re-login
```
exit
```
(or) 
```
new grp docker
```
 It is recommended to logout and login.

3.  **k3s-Installation:**

```
curl -sfL https://get.k3s.io | sh  -
```

`kubectl get nodes ` (##make sure control and  master-plane are ready)

## Steps to Run the Application
  

1.  **Clone the repository:**

```bash
git clone https://github.com/Harshavardhanchary/Library-Manager.git
```
```
cd Library-Manager
```

2. **Set environment variables:**

Create a `.env` file in the root directory:
```
mv .env.example .env
```
  

3.  **Build and start the services:**

```
docker-compose build
```
```
docker-compose up -d
```
  

4. **Access the application:**

`http://<ec2-public-ip>:8081/Homepage.jsp`


5.  **Stop the services:**

```
docker-compose down
```

After verifying the application runs successfully with Docker Compose, proceed with configuring the Jenkins CI/CD pipeline.
  
 ## CI/CD Pipeline (Jenkins + ArgoCD)
 
### Jenkins
- After installing Jenkins you can access it at http://ec2-public-ip/8080
- To get initial password use:
 ```
 sudo cat/var/lib/jenkins/secrets/initialAdminPassword
```
- Make sure to add Docker and Git Credentials as 
  `docker-cred` and `git-cred` in Jenkins credentials.
- Choose pipeline job
- Choose pipeline from scm
- Add the repo url or your repo url `https://github.com/Harshavardhanchary/Library-Manager.git`
- Rename the branch from `master` to `main` .
- Save 
- And build the app or configure a web-hook to the Jenkins pipeline.

### CI(Continuous-Integration)
- The `Jenkinsfile` automates the build, test, Docker image creation, push to Docker Hub, and updates deployment manifests.

- Credentials for Docker and Git are managed via Jenkins credentials.

- Deployment manifests are stored in a separate repo: [Library-Manifests](https://github.com/Harshavardhanchary/Library-Manifests.git).
### Argo CD

Continuous Deployment (CD) is handled by [ArgoCD](https://argo-cd.readthedocs.io/), which automatically syncs and deploys the latest manifests from the Library-Manifests repository to your Kubernetes cluster.
### Installation
- Create a Namespace for Argo CD
```
sudo kubectl create namespace argocd
```

- Install Argo CD
```
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

- Make sure all pods are running in Argo CD Namespace
```
sudo kubectl get pods -n argocd
```
- Change  the Argo CD server type to Node Port 
```
sudo kubectl patch svc argocd-server -n argocd -p  '{"spec": {"type": "NodePort"}}' 
```
- Get the Node Port using :
```
sudo kubectl get svc argocd-server -n argocd
```
`80/32xxx` and `443/32xxx` you can access on either of the port numbers. [Make sure to allow the port numbers in security group Inbound Rules]
- Example port number:  `32454`

- Access the Argo CD UI at
 `http://<ec2-public-ip>:nodeport`
 
- Initial username is `admin`
- You can get the password using:
```
sudo kubectl get secret argocd-initial-admin-secret -n  argocd -o jsonpath="{.data.password}" | base64 -d
```

**Secrets**
- Create secrets before setting up applications
```
sudo kubectl  create  secret  generic  library-secrets  --from-literal=DB_USERNAME=dbuser  --from-literal=DB_PASSWORD=Userpassword  --from-literal=DB_URL=jdbc:mysql://db:3306/Library_Manager  --from-literal=MYSQL_ROOT_PASSWORD=Root@123  --from-literal=MYSQL_DATABASE=Library_Manager  --from-literal=MYSQL_USER=dbuser  --from-literal=MYSQL_PASSWORD=Userpassword
```

- Create 2 applications one for Backend and other for Database.
- Backend path will be`backend/`
- Database path will be `database/`  
- Name-space is `default`
- sync policy is `manual`(i have kept it manual)
- You should see your pods running in couple of minutes.
- In instance use :
```
sudo kubectl get pods
```
- you should see two pods running:
`library` and `db`

## DNS
- In your domain hosting platform(Ex: Hostinger, Cloudflare, etc ) add a DNS record 

- Type: `A`
- Name:`Library`
- Value(or) IPv4 Address:`ec2-public-ip`
- Proxy status: `DNS only`

- You can access the web-app at `https//yourdomain.com/Homepage.jsp`
## NOTE
- I have used ingress in this project using my domain.
- Change the domain according you domain name.
OR
- Change the service of backend to `Node port` type.
- Get the Node port using:
```
sudo kubectl get svc
```
- Note the Node port of the library-app and access the web-app at
 `http//<ec2-public-ip>:nodeport/Homepage.jsp`
 Example:`http//46.78.89.98:32123/Homepage.jsp`
 
## Folder Structure

- `Library_manager` 
- 
  ├── backend/ # Spring Boot backend application  
  │ ├── src/ # Java source code and resources  
  │ ├── pom.xml # Maven build configuration  
  │ └── Dockerfile # Backend Docker image build file  
  │  
  ├── database/ # MySQL database container setup  
  │ ├── library_manager.sql # Initial DB setup script  
  │ └── Dockerfile # MySQL Docker image build file  
  │  
  ├── docker-compose.yml # Multi-container orchestration  
  ├── Jenkinsfile # Jenkins CI/CD pipeline definition  
  ├── .env.example # Environment variables  
  └── README.md # Project documentation
---

For any issues, please open an issue on the [GitHub repository](https://github.com/Harshavardhanchary/Library-Manager).
