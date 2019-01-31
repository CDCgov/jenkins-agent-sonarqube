FROM registry.access.redhat.com/openshift3/jenkins-slave-base-rhel7:latest

ENV SONARQUBE_SCANNER_VERSION=3.3.0.1492 \
    NODEJS_VERSION=10 \
    PATH=/opt/rh/rh-nodejs10/root/usr/bin:${HOME}/bin:$PATH \
    LD_LIBRARY_PATH=/opt/rh/rh-nodejs10/root/usr/lib64 \
    X_SCLS=rh-nodejs10 \
    BASH_ENV=/usr/local/bin/scl_enable \
    ENV=/usr/local/bin/scl_enable \
    PROMPT_COMMAND=". /usr/local/bin/scl_enable" \
    http_proxy=http://gatekeeper.mitre.org:80 \
    https_proxy=http://gatekeeper.mitre.org:80 \
    no_proxy=.svc,.svc.cluster.local

COPY run-scan.sh configure-slave /usr/local/bin/
COPY scl_enable /usr/local/bin/scl_enable
RUN chmod +x /usr/local/bin/run-scan.sh && \
    chmod +x /usr/local/bin/configure-slave && \
    yum-config-manager --enable rhel-server-rhscl-7-rpms >/dev/null || : && \
    yum-config-manager --enable rhel-7-server-optional-rpms >/dev/null || : && \
    INSTALL_PKGS="ansible-lint rh-nodejs10 ShellCheck" && \
    yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    npm install typescript -g && \
    curl -L -o sonar-scanner-cli.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONARQUBE_SCANNER_VERSION}-linux.zip && \
    unzip sonar-scanner-cli.zip && \
    mv sonar-scanner-${SONARQUBE_SCANNER_VERSION}-linux /usr/local/sonar-scanner-linux && \
    ln -s /usr/local/sonar-scanner-linux/bin/sonar-scanner /usr/local/bin/ && \
    yum clean all

USER 1001
