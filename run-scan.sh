#!/bin/sh

sonar-scanner -Dsonar.host.url="$SONARQUBE_HOST_URL" -Dsonar.projectKey="$SONARQUBE_PROJECT_KEY" -Dsonar.projectName="$SONARQUBE_PROJECT_NAME" -Dsonar.sources="$SONARQUBE_SOURCE_DIR" -Dsonar.login="$SONARQUBE_LOGIN_TOKEN"
