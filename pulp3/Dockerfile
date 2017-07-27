FROM fedora
RUN dnf update -y && dnf clean all && dnf install python3 python3-psycopg2 postgresql -y && dnf clean all
RUN pip3 install virtualenv && virtualenv pulp -p python3 && source pulp/bin/activate && pip3 install pulpcore && mkdir /etc/pulp
COPY secret.py start.sh /
EXPOSE 80
CMD ./start.sh
