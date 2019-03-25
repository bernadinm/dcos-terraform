#!/usr/bin/env groovy

// Build Parameters
properties([ parameters([
  string( name: 'AWS_ACCESS_KEY_ID', defaultValue: ''),
  string( name: 'AWS_SECRET_ACCESS_KEY', defaultValue: '')
]), pipelineTriggers([]) ])

// Environment Variables
env.AWS_ACCESS_KEY_ID = AWS_ACCESS_KEY_ID
env.AWS_SECRET_ACCESS_KEY = AWS_SECRET_ACCESS_KEY

pipeline {
    agent none
    stages {
//        stage ('Checkout') {
//          agent { label 'terraform' }
//          checkout scm
//        }
        stage('Terraform FMT') {
            agent { label 'terraform' }
            steps {
                sh 'terraform fmt --check --diff'
            }
        }
        stage('Terraform validate') {
            agent { label 'terraform' }
            steps {
                sh 'terraform init --upgrade'
                sh 'terraform validate -check-variables=false'
            }
        }
        stage('Validate README go generated') {
            agent { label 'terraform' }
            steps {
                sh 'terraform-docs md ./ >README.md'
                sh 'git --no-pager diff --exit-code'
            }
        }
        stage('Validate variables.tf descriptions') {
            agent { label "tfdescsan" }
            steps {
                sh 'tfdescsan --test --tsv https://dcos-terraform-mappings.mesosphere.com/ --var variables.tf --cloud "$(echo ${JOB_NAME##*/terraform-} | sed -E "s/(rm)?-.*//")"'
            }
        }
        stage('Validate outputs.tf descriptions') {
            agent { label "tfdescsan" }
            steps {
                sh 'tfdescsan --test --tsv https://dcos-terraform-mappings.mesosphere.com/ --var outputs.tf --cloud "$(echo ${JOB_NAME##*/terraform-} | sed -E "s/(rm)?-.*//")"'
            }
        }
        stage ('Notification') {
         // mail from: "jenkins@example.com",
         //      to: "devopsteam@example.com",
         //      subject: "Terraform build complete",
         //      body: "Jenkins job ${env.JOB_NAME} - build ${env.BUILD_NUMBER} complete"
         echo "Just say done!"
        }
    }
}

