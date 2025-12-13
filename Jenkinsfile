pipeline {
    agent any
  
    environment {
        DOCKER_IMAGE = 'syrinaaa/studentmanagement-jenkins'
        IMAGE_TAG = 'latest'
    }
  
    stages {
        stage('🔍 Git Checkout') {
            steps {
                echo '📥 Clonage du dépôt GitHub...'
                git credentialsId: 'github-credentials', 
                    branch: 'main', 
                    url: 'https://github.com/toumisyrine/StudentManagement-Jenkins.git'
            }
        }
        
        stage('🔨 Build with Maven') {
            steps {
                echo '🏗️ Construction du projet avec Maven...'
                sh 'mvn clean install -DskipTests'
            }
        }
        
        stage('🧪 Run Tests') {
            steps {
                echo '✅ Exécution des tests...'
                sh 'mvn test'
            }
        }
        
        stage('🐳 Build Docker Image') {
            steps {
                echo '🔧 Construction de l image Docker...'
                sh "docker build -t ${DOCKER_IMAGE}:${IMAGE_TAG} ."
                sh "docker tag ${DOCKER_IMAGE}:${IMAGE_TAG} ${DOCKER_IMAGE}:build-${BUILD_NUMBER}"
            }
        }
        
        stage('📤 Push to Docker Hub') {
            steps {
                echo '🚀 Push vers Docker Hub...'
                withCredentials([usernamePassword(
                    credentialsId: 'docker-hub-credentials', 
                    usernameVariable: 'DOCKER_USERNAME', 
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {
                    sh '''
                        echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
                        docker push ${DOCKER_IMAGE}:${IMAGE_TAG}
                        docker push ${DOCKER_IMAGE}:build-${BUILD_NUMBER}
                        docker logout
                    '''
                }
            }
        }
        
        stage('📊 Jacoco Report') {
            steps {
                echo '📈 Génération du rapport de couverture...'
                junit '**/target/surefire-reports/*.xml'
                jacoco()
            }
        }
    }
       
    post {
        success {
            echo '✅ =========================================='
            echo '✅ PIPELINE RÉUSSI !'
            echo '✅ Image disponible sur Docker Hub'
            echo '✅ =========================================='
        }
        failure {
            echo '❌ =========================================='
            echo '❌ PIPELINE ÉCHOUÉ !'
            echo '❌ Vérifiez les logs ci-dessus'
            echo '❌ =========================================='
        }
        always {
            echo '🧹 Nettoyage...'
            sh 'docker system prune -f || true'
        }
    }
}
