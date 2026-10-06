FROM registry.access.redhat.com/ubi9/ubi-minimal

RUN microdnf install -y \
        openssh-server \
        openssh-clients \
        shadow-utils \
    && microdnf clean all \
    && useradd --uid 1001 --home-dir /home/sshuser --shell /bin/sh --no-create-home sshuser \
    && mkdir -p /opt/sshd /tmp/sshd /home/sshuser \
    && chown 1001:1001 /home/sshuser \
    && chmod 0777 /tmp/sshd /home/sshuser

COPY sshd_config /opt/sshd/sshd_config
COPY entrypoint.sh /opt/sshd/entrypoint.sh

RUN chmod 0755 /opt/sshd/entrypoint.sh \
    && chmod 0644 /opt/sshd/sshd_config

EXPOSE 2222

USER 1001

ENTRYPOINT ["/opt/sshd/entrypoint.sh"]
