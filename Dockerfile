FROM registry.access.redhat.com/openshift3/jenkins-slave-base-rhel7:latest

ENV SONARQUBE_SCANNER_VERSION=3.2.0.1227

COPY run-scan.sh configure-slave /usr/local/bin/
RUN chmod +x /usr/local/bin/run-scan.sh && \
    chmod +x /usr/local/bin/configure-slave && \
    curl -L -o sonar-scanner-cli.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONARQUBE_SCANNER_VERSION}-linux.zip && \
    unzip sonar-scanner-cli.zip && \
    mv sonar-scanner-${SONARQUBE_SCANNER_VRESION}-linux /usr/local/sonar-scanner-linux && \
    ln -s /usr/local/sonar-scanner-linux/bin/sonar-scanner /usr/local/bin/

USER 1001
