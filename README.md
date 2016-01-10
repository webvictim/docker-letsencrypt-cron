# docker-letsencrypt-cron
Create and automatically renew website certificates using the letsencrypt free CA.

This image will renew your certificates when they have less than 28 days remaining, and place the latest ones in the /certs folder on the host.

This repository was forked from [Henri Dwyer's version](https://github.com/henridwyer/docker-letsencrypt-cron) but decides which certificates need renewing based on expiry date rather than doing them all whenever the cron job is run. This lets you manage many more domains without running into [letsencrypt's rate limits](https://community.letsencrypt.org/t/rate-limits-for-lets-encrypt/6769), as long as you stagger them out. Also, on first run it will generate unique Diffie–Hellman parameters to be used for securing your HTTPS server.

# Setup

In docker-compose.yml, change the environment variables:
- set the DOMAINS environment variable to a space separated list of domains for which you want to generate certificates.
- set the EMAIL environment variable for your account on the ACME server, and where you will receive updates from letsencrypt.

# ACME Validation challenge

To authenticate the certificates, you need to pass the ACME validation challenge. This requires requests made to on port 80 to example.com/.well-known/ to be forwarded to this image. Note that your ACME challenge server will only be running for the brief period that the request to letsencrypt is being made.

## Nginx example

If you use nginx as a reverse proxy, you can add the following to your configuration file in order to pass the ACME challenge.

``` nginx
server {
  listen              80;
  location '/.well-known/acme-challenge' {
    default_type "text/plain";
    proxy_pass http://letsencrypt:80;
  }
}

```

# Usage

```shell
docker-compose up -d
```

The first time you start it up, you may want to run the certificate generation script immediately:

```shell
docker exec letsencrypt sh -c "/run_letsencrypt.py"
```

At 3AM every day, a cron job will start the script, renewing the certificates that have less than 28 days remaining.

# More information

Find out more about letsencrypt: https://letsencrypt.org

Letsencrypt github: https://github.com/letsencrypt/letsencrypt
