#!/bin/bash

currentDir="jenkins-ci-test"
buildDir="build"
publicDir="/home/nginx/domains/ffdev.istackmanila.com/public/"
timeStamp=`date +%Y-%m-%d_%H-%M-%S`
archiveName="$currentDir$timeStamp.zip"
archiveDir="/home/nginx/domains/ffdev.istackmanila.com/archives/"
sshServer="root@172.104.36.189"
gitlabAppsDir=/root/gitlab-apps/
runSass="sass --no-cache ${publicDir}admin/css/sass-ui/src/scss/style.scss ${publicDir}admin/css/style.css"
ownedByNginx="chown -R nginx: ${publicDir}*"
removeGit="rm -rf ${publicDir}.git"

if [ "$1" != "" ]
then
  option=$1
else
  option="before_script"
fi

function before_script
{
    npm install
}

function cleanup
{
    echo "Cleaning up staging"

    #echo "Trying to archive previous build from public.."
    # mkdir -p $archiveDir
    #
    # if [ -d "$publicDir$currentDir" ] ; then
    #     echo "archiving $publicDir$currentDir to $archiveDir$archiveName"
    #     tar -cvf $archiveDir$archiveName $publicDir$currentDir
    # fi

    echo "Removing previous build from gitlab-apps.."
    rm -rf $gitlabAppsDir$currentDir

    echo "Creating new build dir in gitlab-apps.."
    mkdir -p $gitlabAppsDir$currentDir

    exit
}

function archive_and_transfer_server
{
    tar -czf $currentDir.tar.gz $buildDir
    scp -o "StrictHostKeyChecking no" $currentDir.tar.gz $sshServer:$gitlabAppsDir$currentDir
    exit
}

function server_extract_and_transfer_to_public_folder
{
    ssh -o "StrictHostKeyChecking no" $sshServer "(cd $gitlabAppsDir$currentDir && tar -zxvf $currentDir.tar.gz && cd $gitlabAppsDir$currentDir && cp -Trf . $publicDir && $runSass && $ownedByNginx && $removeGit && exit)"
}

case "$1" in
    before_script)
        before_script
        ;;
    cleanup)
        cleanup
        ;;
    archive_and_transfer_server)
        archive_and_transfer_server
        ;;
    server_extract_and_transfer_to_public_folder)
        server_extract_and_transfer_to_public_folder
        ;;
    *)
        echo "nothing to do here..."
        ;;
esac
