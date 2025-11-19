@'
pipeline {
    agent any

    environment {
        MAVEN_HOME = tool 'Maven'
        PATH = "${MAVEN_HOME}/bin:${PATH}"
    }

    stages {
        stage('Checkout') {
            steps {
                echo '========== Récupération du code depuis GitHub =========='
                checkout scm
                echo 'Code récupéré avec succès'
            }
        }

        stage('Build') {
            steps {
                echo '========== Compilation du projet Maven =========='
                sh 'mvn clean compile'
                echo 'Compilation réussie'
            }
        }

        stage('Test') {
            steps {
                echo '========== Exécution des tests unitaires =========='
                sh 'mvn test'
                echo 'Tests exécutés'
            }
        }

        stage('Package') {
            steps {
                echo '========== Génération du livrable (JAR/WAR) =========='
                sh 'mvn package -DskipTests'
                echo 'Livrable généré dans le dossier target/'
            }
        }
    }

    post {
        success {
            echo '✓ Pipeline exécuté avec succès!'
            archiveArtifacts artifacts: 'target/**/*.jar,target/**/*.war', 
                                       allowEmptyArchive: true
        }
        failure {
            echo '✗ Le pipeline a échoué. Consultez les logs pour plus de détails.'
        }
        always {
            echo '========== Pipeline terminé =========='
        }
    }
}
'@ | Out-File -Encoding UTF8 Jenkinsfile