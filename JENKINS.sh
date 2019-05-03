pipeline {
    agent any
    environment {
        DISABLE_AUTH = 'true'
        TOKEN_NAME = ''
        USERNAME= ''
        PASSWORD = ''
        WORKSPACE = ''
        PYTHON_PATH= ''
        LPP_PATH = ''
    }
    stages {
        stage('Build') {
            steps {
                sh 'echo "Building"'
                sh '''
                    curl http://18.130.27.147.eu:8080/job/la_petite_portugaise/build?token=TOKEN_NAME --user "USERNAME:PASSWORD"
                '''
            }
        }
        stage('Test') {
            steps {
                sh 'echo "Testing"'
                sh '''
                    echo "Multiline shell steps works too"
                    ls -lah
                '''
            }
        }
        stage('Deploy') {
            steps {
                withCredentials(bindings: [sshUserPrivateKey(credentialsId: 'jenkins-ssh-key-for-abc', \
                                                             keyFileVariable: 'SSH_KEY_FOR_ABC')]) {
                
                    sh 'echo "moving jenkins workspace $WORKSPACE to the apache project location"'
                    sh '''
                        whoami
                        cd /home/ubuntu/Dev
                                            
                        sudo service apache2 stop
                        
                        sudo rm -rf /home/ubuntu/Dev/la_petite_portugaise
                        
                        sudo cp -r $WORKSPACE /home/ubuntu/Dev/la_petite_portugaise
    
                        cd /home/ubuntu/Dev/la_petite_portugaise
                        sudo service apache2 stop
                        
                        sudo rm -rf /home/ubuntu/Dev/la_petite_portugaise
                        
                        sudo cp -r $WORKSPACE /home/ubuntu/Dev/la_petite_portugaise
    
                        cd /home/ubuntu/Dev/la_petite_portugaise
                    '''
                    sh 'echo "Creating virtual env"'
                    sh '''
                        sudo virtualenv -p python3 .
                        sudo chmod 770 $PYTHON_PATH
                        
                        source bin/activate
                        echo 'which python are you running?'
                        which python
                        cd src
                        
                        sudo $PYTHON_PATH -m pip install --upgrade pip  # Upgrade pip
                        echo 'pip upgrade done'
                        sudo $PYTHON_PATH -m pip install -r REQUIREMENTS.txt           # Install or upgrade dependencies
                        echo 'pip install done'
                    '''
                    sh 'echo "Load vars, compile messages, collect static, set permissions and make migrations"'
                    sh '''
                        sudo $PYTHON_PATH /var/lib/jenkins/run_vars.py
                        echo 'var import done'
                        
                        #sudo $PYTHON_PATH manage.py createcachetable cache_table
                        
                        sudo $PYTHON_PATH manage.py makemigrations                  
                        
                        sudo $PYTHON_PATH manage.py migrate                  
                        echo 'manage.py migrate done'
                        
                        sudo $PYTHON_PATH manage.py compilemessages          # Create translation files
                        echo 'manage.py compilemessages done'
                        
                        sudo $PYTHON_PATH manage.py collectstatic --noinput  # Collect static files
                        echo 'manage.py collectstatic done'
                        
                        deactivate 								  # quit the virtual environment
                        
                        sudo chown -R www-data:www-data $LPP_PATH
                        
                        sudo find $LPP_PATH -type d -exec chmod 750 {} \;
                        sudo find $LPP_PATH -type f -exec chmod 770 {} \;
                        
                        sudo service apache2 start
                    '''
                }
            }
        }
    }
    post {
        success {
            echo 'Successful build'
        }
        failure {
            echo '!! Build failed !!'
            mail to: 'hprattdo@gmail.com',
            subject: "Failed Pipeline: ${currentBuild.fullDisplayName}",
            body: "Something is wrong with ${env.BUILD_URL}"
        }
    }
}
