

# Setting up a CI/CD pipeline on an Ubuntu EC2 t3.small instance using Git, Jenkins, Docker, and Ansible.

##  Required Tools

### 1. Git
Used for version control and pulling code from GitHub.
```bash
sudo apt update
sudo apt install git -y
```

### 2. Java (OpenJDK 17)
Required for running Jenkins.
```bash
sudo apt install openjdk-17-jre -y
```

### 3. Jenkins
Automates build and deployment processes.
```bash
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
```

### 4. Docker
Used to build and run containerized applications.
```bash
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker jenkins
```

### 5. Ansible
Used for configuration management and deployment automation.
```bash
sudo apt install ansible -y
```


## 🔌 Jenkins Plugin Setup

To integrate Jenkins with GitHub, Docker, and Ansible, install the following plugins:

###  Essential Plugins
- **GitHub Plugin** – Enables GitHub integration.
- **Git Plugin** – Required for Git operations.
- **GitHub Branch Source Plugin** – For multibranch pipelines.
- **Pipeline Plugin** – Enables Jenkinsfile-based pipelines.
- **Docker Pipeline Plugin** – For Docker operations in pipelines.
- **Ansible Plugin** – Allows Jenkins to run Ansible playbooks.
- **GitHub API Plugin** – Supports GitHub-related features.

###  How to Install
1. Go to Jenkins Dashboard → `Manage Jenkins` → `Manage Plugins`.
2. Under the **Available** tab, search and install the plugins listed above.
3. Restart Jenkins if required.



##  GitHub Webhook Configuration

To trigger Jenkins builds automatically when code is pushed to GitHub:

###  Steps:
1. Go to your GitHub repository → `Settings` → `Webhooks` → `Add webhook`.
2. Fill in the following:
   - **Payload URL**:  
     ```
     http://<your-jenkins-server-ip>:8080/github-webhook/
     ```
   - **Content type**:  
     ```
     application/json
     ```
   - **Events**:  
     Select “Just the push event”.
   - **Active**:  
      Checked
3. Click **Add webhook**.

###  Jenkins Job Configuration
- Go to your Jenkins job → `Configure`.
- Under **Build Triggers**, check:
  ```
  GitHub hook trigger for GITScm polling
  ```

##  Deployment Steps Using Ansible

Once Jenkins builds the Docker image, Ansible can be used to deploy it:

### Workflow
1. Jenkins triggers an Ansible playbook post-build.
2. The playbook connects to target servers via SSH.
3. It pulls the Docker image and runs the container.

###  Example Jenkins Pipeline Snippet
```groovy
post {
  success {
    sh 'ansible-playbook -i inventory deploy.yml'
  }
}
```

###  Required Files
- `inventory`: Defines target hosts.
- `deploy.yml`: Ansible playbook for deployment.

##  Additional Setup

- Configure GitHub webhooks to trigger Jenkins jobs.
- Install Jenkins plugins for GitHub, Docker, and Ansible integration.
- Set up SSH keys if Ansible needs to connect to remote servers.
