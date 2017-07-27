FROM fedora
RUN dnf -y update && dnf clean all && dnf install -y python-qpid qpid-cpp-server && dnf clean all
EXPOSE 5672
ENTRYPOINT ["qpidd", "-t", "--auth=no"]
