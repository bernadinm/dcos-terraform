#!/usr/bin/env groovy

pipeline {
    agent none
    stages {
        stage('Terraform Testing Cred') {
            agent { label 'terraform' }
            steps {
                echo "My client id is $AZURE_CLIENT_ID"
                echo "My client secret is $AZURE_CLIENT_SECRET"
                echo "My tenant id is $AZURE_TENANT_ID"
                echo "My subscription id is $AZURE_SUBSCRIPTION_ID"
                echo "My subscription id is $AZURE_SUBSCRIPTION_ID"
            }
        }
        stage('Terraform apply') {
            agent { label 'terraform' }
            steps {
                sh 'terraform init --upgrade'
                sh 'terraform validate -check-variables=false'
            }
        }
//        stage('scale up') {
//            agent { label 'terraform' }
//            steps {
//                sh 'terraform-docs md ./ >README.md'
//                sh 'git --no-pager diff --exit-code'
//            }
//        }
//        stage('scale down') {
//            agent { label 'terraform' }
//            steps {
//                sh 'terraform-docs md ./ >README.md'
//                sh 'git --no-pager diff --exit-code'
//            }
//        }
//        stage('replace node') {
//            agent { label 'terraform' }
//            steps {
//                sh 'terraform-docs md ./ >README.md'
//                sh 'git --no-pager diff --exit-code'
//            }
//        }
//        stage('destroy') {
//            agent { label 'terraform' }
//            steps {
//                sh 'terraform-docs md ./ >README.md'
//                sh 'git --no-pager diff --exit-code'
//            }
//        }
//        stage('destroy') {
//            agent { label 'terraform' }
//            steps {
//                sh 'terraform-docs md ./ >README.md'
//                sh 'git --no-pager diff --exit-code'
//            }
//        }
    }
}
