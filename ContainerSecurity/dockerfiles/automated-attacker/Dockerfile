FROM python:3
RUN apt-get update              && \
    apt-get install cron  -y  && \
    rm -rf /var/lib/apt/lists/* 
COPY . /app
WORKDIR /app
COPY ./attacker.crontab /etc/cron.d/attacker.crontab
RUN chmod 0644 /etc/cron.d/attacker.crontab
RUN chmod 0744 /app/attack.sh
RUN chmod +x /app/attack.sh
RUN crontab /etc/cron.d/attacker.crontab
RUN touch /var/log/cron.log
ENTRYPOINT [ "cron" , "-f" ]
