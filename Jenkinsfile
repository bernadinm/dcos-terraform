#!/usr/bin/env groovy

pipeline {
    agent none
    stages {
        stage('Terraform Testing Azure Creds') {
            agent { label 'terraform' }
            steps {
                withCredentials([azureServicePrincipal('dcos-terraform-ci')]) {
                    echo "My client id is $AZURE_CLIENT_ID"
                    echo "My client secret is $AZURE_CLIENT_SECRET"
                    echo "My tenant id is $AZURE_TENANT_ID"
                    echo "My subscription id is $AZURE_SUBSCRIPTION_ID"
                }
            }
        }
        stage('Terraform Testing AWS Creds') {
                agent { label 'terraform' }
                steps {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'f4832960-6d86-4799-91f1-59005f8abefc']]) {
                       echo "My access key is $AWS_ACCESS_KEY_ID"
                       echo "My secret key is $AWS_SECRET_ACCESS_KEY"
                    }
                }
        }
//        stage('Terraform Testing GCP Creds') {
//            agent { label 'terraform' }
//            steps {
//                echo "My client id is $AZURE_CLIENT_ID"
//                echo "My client secret is $AZURE_CLIENT_SECRET"
//                echo "My tenant id is $AZURE_TENANT_ID"
//                echo "My subscription id is $AZURE_SUBSCRIPTION_ID"
//            }
//        }
//        stage('Terraform apply') {
//            agent { label 'terraform' }
//            steps {
//                sh 'terraform init --upgrade'
//                sh 'terraform validate -check-variables=false'
//            }
//        }
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
