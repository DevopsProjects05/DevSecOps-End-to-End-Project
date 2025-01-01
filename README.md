# End-to-End DevSecOps Project

## **Project Overview**
This repository contains an end-to-end **DevSecOps pipeline** that automates the CI/CD workflow while integrating security, infrastructure provisioning, and monitoring practices. The project is designed to showcase the implementation of modern DevSecOps principles for interviews and professional demonstrations.

---

## **Workflow**

### **High-Level Workflow**
1. **Developer Pushes Code**: Developers push source code and infrastructure-as-code (IaC) to a Git repository.
2. **Continuous Integration (CI)**: Jenkins automates code analysis and security checks.
3. **Infrastructure Validation**: Terraform provisions resources, and tfsec validates infrastructure security.
4. **Continuous Delivery (CD)**: Jenkins deploys containers and configures the server.
5. **Monitoring**: Prometheus collects metrics, and Grafana visualizes system health.

### **Steps in the Pipeline**
1. **Code Analysis**:
    - Jenkins pulls the code from Git and sends it to SonarQube for static analysis.
    - Notifies developers if issues are found.

2. **Infrastructure Security and Provisioning**:
    - Terraform provisions infrastructure (EC2 instances, storage).
    - tfsec scans Terraform code for security vulnerabilities.
    - Provisioning proceeds only if no issues are found.

3. **Configuration Management**:
    - Ansible installs Docker on the EC2 instance and configures it.

4. **Container Security**:
    - Docker images are pulled from the repository.
    - Trivy scans images for vulnerabilities and notifies developers if issues are detected.

5. **Deployment and Monitoring**:
    - Docker containers are deployed to the EC2 instance.
    - Prometheus collects metrics and Grafana visualizes them for observability.

---

## DevOps Tools Stack
---

![](/DevSecOps-End-to-End-Project/Tools-used1.jpg)

---

## Tools and Technologies

| **Tool**           | **Purpose**                                       |
|--------------------|---------------------------------------------------|
| **Git**            | Version control for source code.                  |
| **Jenkins**        | Orchestrates CI/CD pipelines.                     |
| **SonarQube**      | Performs static code analysis.                    |
| **Terraform**      | Provisions infrastructure.                        |
| **tfsec**          | Validates Terraform code for security issues.     |
| **Ansible**        | Automates configuration management.               |
| **Docker**         | Containerizes applications.                       |
| **Trivy**          | Scans Docker images for vulnerabilities.          |
| **Prometheus**     | Monitors infrastructure and collects metrics.      |
| **Grafana**        | Visualizes metrics from Prometheus.               |
| **NGINX**          | Serves as a web server and reverse proxy for the application. |
| **HashiCorp Vault**| Manages secrets and sensitive data securely.       |

---

## **Project Components**

### **1. Code Repository (Git)**
- Contains source code, Terraform scripts, and Dockerfiles.
- Organized into the following directories:
  ```
  /src          # Application source code
  /terraform    # Terraform scripts for infrastructure provisioning
  /ansible      # Ansible playbooks for server configuration
  /docker       # Dockerfiles and related configurations
  ```

### **2. Jenkins Pipelines**
#### **Pipeline 1: Code Quality Analysis**
- Pulls code from Git.
- Sends the code to SonarQube for static analysis.
- Sends quality gate reports to the developer.

#### **Pipeline 2: Infrastructure Validation**
- Validates Terraform scripts using tfsec.
- Provisions infrastructure if validation passes.

#### **Pipeline 3: Configuration Management**
- Installs and configures Docker on the EC2 instance using Ansible.

#### **Pipeline 4: Container Security**
- Scans Docker images using Trivy.
- Blocks deployment if vulnerabilities are detected.

#### **Pipeline 5: Deployment and Monitoring**
- Deploys Docker containers to EC2.
- Configures Prometheus and Grafana for monitoring.

### **3. Monitoring and Observability**
- **Prometheus**: Scrapes metrics from infrastructure and application.
- **Grafana**: Visualizes metrics through dashboards.

---

## **Infrastructure Setup**

### **1. AWS Instances**
| **Instance Purpose**         | **Instance Type** | **IP Type**       | **vCPUs** | **RAM** | **Storage** |
|------------------------------|-------------------|-------------------|-----------|---------|-------------|
| **Jenkins + Trivy (Shared)** | `t3.medium`       | Elastic/Public IP | 2         | 4 GiB   | 60 GiB      |
| **SonarQube**                | `t3.large`        | Private IP        | 2         | 8 GiB   | 50 GiB      |
| **Terraform + tfsec**        | `t3.micro`        | Private IP        | 1         | 1 GiB   | 20 GiB      |
| **Prometheus + Grafana**     | `t3.small`        | Private IP        | 2         | 2 GiB   | 30 GiB      |
| **Application Server (EC2)** | `t2.medium`       | Elastic/Public IP | 2         | 4 GiB   | 30 GiB      |

### **2. Custom Domain Configuration**
- Allocate an Elastic IP and associate it with the application server.
- Configure an **A record** in your DNS provider to point the domain to the Elastic IP.

---

## **Execution Instructions**

1. **Setup Jenkins**:
   - Install Jenkins on the shared instance.
   - Configure pipelines as per the workflow.

2. **Install and Configure Tools**:
   - SonarQube: For static code analysis.
   - Terraform and tfsec: For IaC provisioning and validation.
   - Ansible: For server configuration.
   - Docker: For containerization.
   - Trivy: For scanning Docker images.
   - Prometheus and Grafana: For monitoring and visualization.

3. **Run Pipelines**:
   - Trigger pipelines sequentially or automatically based on Git push events.

4. **Access Application**:
   - Use the configured custom domain to access the deployed application.

---

## **Best Practices**
1. Use Elastic IPs for public-facing instances (Jenkins, Application Server).
2. Use private IPs for internal communication (SonarQube, Prometheus, Terraform).
3. Secure instances with appropriate security group rules.
4. Enable HTTPS using SSL certificates.
5. Regularly monitor logs and metrics for pipeline health.

---

## **Conclusion**
This project demonstrates a robust DevSecOps workflow, integrating CI/CD, infrastructure automation, security scanning, and monitoring. It showcases modern practices that ensure high-quality, secure, and efficient deployments.

---
