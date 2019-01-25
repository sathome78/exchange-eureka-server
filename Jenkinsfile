pipeline {

  agent any

  stages {
    stage('Maven Install') {
      agent {
        docker {
          image 'maven:3.5.4'
        }
      }
      steps {
        sh 'mvn clean install'
      }
    }
    stage('Docker Build') {
      agent any
      steps {
        sh 'docker build --build-arg ENVIRONMENT -t roadtomoon/exrates-eureka-server:$ENVIRONMENT .'
      }
    }
    stage('Docker pull') {
      agent any
      steps {
        sh 'docker tag roadtomoon/exrates-eureka-server:$ENVIRONMENT 172.50.50.7:5000/eureka-server:$ENVIRONMENT'
        sh 'docker push 172.50.50.7:5000/eureka-server:$ENVIRONMENT'
      }
    }
    stage('Deploy container') {
      steps {
        sh 'docker -H tcp://172.50.50.7:2376 service update --image 172.50.50.7:5000/eureka-server:$ENVIRONMENT $ENVIRONMENT-eureka-server'
      }
    }
  }
}
