# Small container of Tor client

[![forthebadge](https://forthebadge.com/images/badges/made-with-crayons.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/powered-by-responsibility.svg)](https://forthebadge.com)

(c) 2015-2024 [Connectical] Óscar García Amor

Redistribution, modifications and pull requests are welcomed under the terms
of GPLv3 license.

[Tor][to] is free software and an open network that helps you defend against
traffic analysis, a form of network surveillance that threatens personal
freedom and privacy, confidential business activities and relationships, and
state security.

This container packages **Tor** under [Alpine Linux][al], a lightweight
Linux distribution.

Visit [Quay][qu] or [GitLab][gl] to see all available tags.

[to]: https://www.torproject.org/
[al]: https://alpinelinux.org/
[qu]: https://quay.io/repository/connectical/tor
[gl]: https://gitlab.com/connectical/container/tor/container_registry

## Run

To run this container, simply exec.

```sh
alias docker="podman" # If you are using podman
docker run -d \
  --name=tor \
  -v /srv/tor/cfg:/etc/tor \
  -v /srv/tor/data:/var/lib/tor \
  ghcr.io/connectical/tor
```

This start `tor` client and store config in `/srv/tor/cfg` and data in
`/srv/tor/data` persistent volumes.

Take note that, by default, `tor` store its data into `/var/lib/tor` as
a home directory, you need to add the following line in `torrc` config file
to set as data directory and set owner of `/srv/tor/data` to UID and GID 100.

```sh
mkdir -p /srv/tor/cfg /srv/tor/data
echo "DataDirectory /var/lib/tor" > /srv/tor/cfg/torrc
chown 100:100 /srv/tor/data
```

## Sample configs

### Tor SOCKS Proxy

To use as Tor proxy set `/srv/tor/cfg/torrc` as following.

```
SOCKSPort 0.0.0.0:9050
DataDirectory /var/lib/tor
```

And run it.

```sh
alias docker="podman" # If you are using podman
docker run -d \
  --name=tor \
  -p 127.0.0.1:9050:9050 \
  -v /srv/tor/cfg:/etc/tor \
  -v /srv/tor/data:/var/lib/tor \
  ghcr.io/connectical/tor
```

Next, open your browser, set `127.0.0.1:9050` as socks proxy and go to
https://check.torproject.org/ to check if you are using the Tor network.

### Tor Hidden Service

To use as service server.

```
SOCKSPort 0
DataDirectory /var/lib/tor
HiddenServiceDir /var/lib/tor/github.com/
HiddenServicePort 22  192.30.253.112:22
HiddenServicePort 80  192.30.253.112:80
HiddenServicePort 443 192.30.253.112:443
```

And run it.

```sh
alias docker="podman" # If you are using podman
docker run -d \
  --name=tor \
  -v /srv/tor/cfg:/etc/tor \
  -v /srv/tor/data:/var/lib/tor \
  ghcr.io/connectical/tor
```

### Other

You can use `tor` as bridge, enter relay or exit relay, see [Tor Docs][6]
for more info.

[6]: https://www.torproject.org/docs/documentation.html.en

## Shell run

If you can run a shell instead `tor` command, simply do.

```sh
alias docker="podman" # If you are using podman
docker run -t -i --rm \
  --name=tor \
  -v /srv/tor/cfg:/etc/tor \
  -v /srv/tor/data:/var/lib/tor \
  --entrypoint=/bin/sh \
  ghcr.io/connectical/tor
```

Please note that the `--rm` modifier destroy the container after shell exit.

## See Tor sample config

If you need to see a documented config file of `tor`, you can open the
`torrc.sample` with following command.

```sh
alias docker="podman" # If you are using podman
docker run -t -i --rm --entrypoint=/usr/bin/less \
  ghcr.io/connectical/tor /etc/tor/torrc.sample
```
