#!/usr/bin/env groovy

pipeline {
    agent none
    stages {
        stage('Terraform Format') {
            agent { label 'terraform' }
            steps {
                sh 'terraform fmt --check --diff'
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
