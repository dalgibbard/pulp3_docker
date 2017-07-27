FROM fedora
RUN dnf update && dnf clean-all && dnf install python3 python3-psycopg2 -y && dnf clean-all
RUN pip3 install virtualenv && virtualenv pulp -p python3 && source pulp/bin/activate && pip3 install pulpcore && mv lib/python3.5/site-packages/pulpcore/etc/pulp/server.yaml /etc/pulp/server.yaml
COPY secret.py secret.py
RUN python secret.py >> /etc/pulp/server.yaml
RUN source pulp/bin/activate && export DJANGO_SETTINGS_MODULE=pulpcore.app.settings && django-admin migrate --noinput auth && django-admin migrate --noinput && django-admin reset-admin-password --password admin
EXPOSE [80,443]
CMD ["source pulp/bin/activate","&&","export DJANGO_SETTINGS_MODULE=pulpcore.app.settings","&&","django-admin runserver"]
