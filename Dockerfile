FROM deliverous/certbot

RUN mkdir /certs

# Add crontab file in the cron directory
ADD crontab /etc/cron.d/crontab

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/crontab

ENTRYPOINT ["/bin/sh", "-c"]

CMD ["cron -f"]
