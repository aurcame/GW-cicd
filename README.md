# Graduation work by Evgeniy Naryshkin
*CI/CD pipeline with Git, Ansible, Docker, Jenkins, Nexus, AWS tools.*

## SUCCESS CRITERIAS:

- Jenkins should pull latest changes and build artifact after each commit to master.

- Jenkins upload artifact to Nexus or Artifactory.

- Jenkins triggering deployment of CI environment after each success build (Continuous Integration /
Continuous Deployment).

- Jenkins should deploy QA environment with the latest artifact on demand (Continuous Delivery).

- During interview, student should demonstrate coursework to an interviewer for discussion.

## REQUIREMENTS

- AWS Free Tier account or GCP Trial.
- GitHub account.

**Step 1 : GitHub Activities**

  Login to GitHub under your account and fork Spring Boot example to your new public repository with
the any name.
  Example https://github.com/spring-projects/spring-boot/tree/2.1.x/spring-bootsamples/spring-boot-sample-web-ui


**Step 2: AWS Activities**

  Create three EC2 instances with the names DevTools, CI, QA, Docker (this instance will be used
only on step number 5)
  NOTE. As an option, if GCP more suitable for you, please use it. Considering 300 USD during trial, it
could be more suitable to up and run more powerful shape of the instances

**Step 3: Prepare DevTools**

  On the DevTools instance install Java 8, Maven, Git, Jenkins and Ansible. As an artifact storage
solution you could use Jfrog Artifactory, Nexus or archive artifact inside Jenkins

**Step 4: Configure CI/CD tools**

*Artifactory/Nexus:*
- Create repository for build artifacts. Also, this repository will be used for deployment procedure
- Create user, which will have access to created repository
- Please note, that you could archive artifact inside Jenkins instead of using Artifactory/Nexus
Jenkins:
- Install required plugin, like git, maven, matrix role
- Disable anonymous access and create some user
- Create build flow with the next steps - CHECKOUT, BUILD, UPLOAD ARTIFACT, CI DEPLOY
- Create deployment jobs for CI and QA environment's
Steps descriptions:
- CHECKOUT: should be triggered after each commit to master branch in repository
- BUILD: to build application use mvn clean install
- UPLOAD ARTIFACT: upload created artifact with the next name convention: <applicationname>.<build-version>.jar.
- Please use Artifactory user

- CI DEPLOY: Ansible role should deploy latest version of application from Artifactory to CI
environment
Ansible:
- Create deployment role which download and run application. To run application: java –jar
path/to/jar/file.jar --server.port=8080 (port should be parametrized)
- Create provisioning role, which install java, docker, create system user, create folders and other
required staff on CI and QA environment's

**Step 5: BUILD and DEPLOY flow improvement**

So, now we got simple CI/CD process, let's improve it:
- The first, let's containerize app with Docker for the build and deployment flow
  - Create EC2 instance and install Docker
  - Create Ansible build role, which
    - Initiate generation of application.dockerfile which will be used to build application container
    - Build application container
    - Push application container to DTR
  - Create Ansible deploy role, which deploy container on Docker node during CI DEPLOY step
  - Create Jenkins jobs for deploy of CI and QA environment's with containers
  - As option, you could use AWS ECS service instead of EC2 instance with Docker
- Rewrite build and deploy flow to Jenkins declarative pipeline (Jenkins DSL)
  - Build process should use jenkinsfile, which located in build branch
  - Deploy process should use application_deploy.jenkinsfile and this file should be pulled from SCM
- Try to use Terraform or AWS Cloud Formation as a IaC approach to create EC2/ECS  
- Add possibility to choice version of artifact / containers during deployment. In simple - it could be
common string field. Advanced - drop down menu with artifacts list


## Infrastructure provisioning

Please find Terraform project which creates all AWS infrastructure here:
<a href="https://github.com/aurcame/aws-tf-GW.git">GW AWS Terraform</a>
