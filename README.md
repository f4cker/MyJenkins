# Jenkins with tomcat support
## What is `jenkins-tomcat`

It's a docker image contain jenkins with support of tomcat that you can deploy and reach straightly via http://your_ip

## JUST ANDROID_SDK
```bash
docker run --name android_sdk -dit -e REPO_OS_OVERRIDE=linux -v /opt/android/sdk:/opt/android-sdk-linux runmymind/docker-android-sdk:latest
```