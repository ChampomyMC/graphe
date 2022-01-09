pipeline {
    agent {
        dockerfile {
            args '-u root --net=host -v $HOME/docker_volumes/.cache/:/root/.cache/'
        }
    }
    environment {
        //SPHINXOPTS = '-w sphinx-build.log'
        DEPLOY_HOST = 'webroot@colabois.fr'
        WEBSITE = 'https://suwako.colabois.fr'
        PROJECT_NAME = 'champomy-graphe'
        REL_PATH = "/champomy/releases/${env.PROJECT_NAME}/"
        DEPLOY_REL_PATH = "www/suwako.colabois.fr${env.REL_PATH}"
        RELEASE_ROOT = "."
        TAG_NAME = """${TAG_NAME ?: ""}"""
        ARTIFACTS = "${WORKSPACE}/bin"
        WEBHOOK_URL = credentials('webhook_champomy_carte')
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
    post {
        success {
            sh 'git clean -fxd'
            discordSend title: "Nouvelles cartes", description: footer: currentBuild.durationString.replace(" and counting",""), link: env.WEBSITE + env.REL_PATH, result: currentBuild.currentResult, image: env.WEBSITE + env.REL_PATH + "cite-dot.png", webhookURL: env.WEBHOOK_URL
        }
    }
}
