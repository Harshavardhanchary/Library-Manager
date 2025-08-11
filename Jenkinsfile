pipeline {
    agent any

    environment {
        // Load secure values from Jenkins credentials
        MYSQL_ROOT_PASSWORD = credentials('MYSQL_ROOT_PASSWORD')  // From Jenkins credential ID
        MYSQL_DATABASE = credentials('MYSQL_DATABASE')// Replace or use Jenkins credentials
        MYSQL_USER = credentials('MYSQL_USER')
        DB_URL = credentials('DB_URL')
        MYSQL_PASSWORD = credentials('MYSQL_PASSWORD')
        DB_PASSWORD = credentials('DB_PASSWORD')
        DB_USERNAME = credentials('DB_USERNAME')
        DOCKER_TAG = "${BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scmGit(
                    branches: [[name: '*/main']],
                    extensions: [],
                    userRemoteConfigs: [[url: 'https://github.com/Harshavardhanchary/Library-Manager.git']]
                    )
                    echo 'Checkout successful'
            }
        }

        stage('Prepare .env File') {
            steps {
                script {
                    writeFile file: '.env', text: """\
MYSQL_ROOT_PASSWORD=${env.MYSQL_ROOT_PASSWORD}
MYSQL_DATABASE=${env.MYSQL_DATABASE}
MYSQL_USER=${env.MYSQL_USER}
DB_URL=${env.DB_URL}
MYSQL_PASSWORD=${env.MYSQL_PASSWORD}
DB_PASSWORD=${env.DB_PASSWORD}
DB_URL=jdbc:mysql://db:3306/${env.MYSQL_DATABASE}
DB_USERNAME=${env.DB_USERNAME}
""".stripIndent()
                }
                echo "✅ .env file created successfully"
            }
        }

        stage('Build and Start Services') {
            steps {
                echo "🛠️ Building Docker containers..."
                sh 'echo "----- DEBUG: Printing .env content -----" && cat .env'
                sh 'docker system prune -f'
                sh 'docker-compose build'
                sh 'docker-compose up -d'
                echo 'build complete'
                echo 'build complete'
            }
        }

        stage('ps') {
            steps {
                echo 'docker build complete'
                echo "docker running procesess"
                sh 'docker ps -a'
            }
        }
        
        stage('Docker Login') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-cred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin $DOCKER_REGISTRY
                    '''
                    }
                }
            }
        }
        stage('Docker-push') {
            steps {
                sh '''
                docker push harshavardhan303/library-manager-backend:${BUILD_NUMBER}
                docker push harshavardhan303/library-manager-db:${BUILD_NUMBER}
                '''
            }
        }
        stage ('Git-Login') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'git-cred', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASS')]) {
                    sh '''
                    git config user.name "${GIT_USER}"
                    git config user.email "harshavardhanchary7@gmail.com"
                    echo "https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com" > ~/.git-credentials
                    '''
                    }
                }
            }
        }
        stage('Checkout Manifests') {
            steps {
                dir('manifests') {
                git url: 'https://github.com/Harshavardhanchary/Library-Manifests.git', branch: 'main'
                }
            }
        }
        stage('update deployment') {
            steps {
                dir('manifests') {
                    script {
                        withCredentials([usernamePassword(credentialsId: 'git-cred', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASS')]) {
                        sh '''
                        git config --global user.name "${GIT_USER}"
                        git config --global user.email "harshavardhanchary7@gmail.com"
                        git remote set-url origin https://${GIT_USER}:${GIT_PASS}@github.com/Harshavardhanchary/Library-Manifests.git
                        chmod +x update-all.sh
                        ./update-all.sh ${BUILD_NUMBER}
                        git add .
                        git commit -m "updated image number with ${BUILD_NUMBER}"
                        git push origin HEAD:main
                        '''
                        }
                    }
                }
            }
        }
        stage('Shut-down services') {
            steps {
                sh 'docker-compose down'
                sh 'docker system prune -f'
                echo 'success'
            }
        }
    }
}
