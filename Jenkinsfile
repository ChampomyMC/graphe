pipeline {
    agent {
        dockerfile {
            args '-u root --net=host -v $HOME/docker_volumes/.cache/:/root/.cache/'
        }
    }
    environment {
        //SPHINXOPTS = '-w sphinx-build.log'
        DEPLOY_HOST = 'werbroot@colabois.fr'
        //WEBSITE = 'https://moriya.zapto.org'
        PROJECT_NAME = 'champomy-graphe'
        REL_PATH = "/suwako.colabois.fr/champomy/releases/${env.PROJECT_NAME}/"
        DEPLOY_REL_PATH = "www${env.REL_PATH}"
        RELEASE_ROOT = "."
        TAG_NAME = """${TAG_NAME ?: ""}"""
        ARTIFACTS = "${WORKSPACE}/bin"
    }
    stages {
        stage('Build sources') {
            steps {
                sh 'make -j4'
            }
        }
        
        stage('Deploy') {
            when {
                anyOf {
                    branch 'stable'
                    branch 'master'
                    buildingTag()
                }
            }
            steps {
                sshagent(credentials: ['pk_webroot']) {
                    sh 'echo ${TAG_NAME:-${GIT_BRANCH#*/}}'
                    sh 'echo ${DEPLOY_HOST}:${DEPLOY_REL_PATH}${TAG_NAME:-${GIT_BRANCH#*/}}/'
                    sh 'ssh -o StrictHostKeyChecking=no -o BatchMode=yes ${DEPLOY_HOST} mkdir -p ${DEPLOY_REL_PATH}${TAG_NAME:-${GIT_BRANCH#*/}}/'
                    sh '''rsync -aze 'ssh -o StrictHostKeyChecking=no -o BatchMode=yes' \
                    --log-file=rsync-rel.log \
                    --delete \
                    ${ARTIFACTS}/ ${DEPLOY_HOST}:${DEPLOY_REL_PATH}${TAG_NAME:-${GIT_BRANCH#*/}}/'''
                }
            }
            post {
                failure {
                    sh 'cat rsync-rel.log'
                }
            }
        }
    }
}
