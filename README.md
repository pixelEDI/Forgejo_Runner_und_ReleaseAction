# Forgejo Actions und Runner

Code für Forgejo-Video-Reihe:
https://www.youtube.com/@pixeledi

Beispiele aus den Videos sind in den Ordner 1 und 2. 

## Installation Runner via Docker

```yaml
services:
    forgejo-runner:
        image: code.forgejo.org/forgejo/runner:5.0.4
        container_name: forgejorunner
        environment:
            DOCKER_HOST: unix:///var/run/docker.sock
        user: 0:0
        volumes:
            - ./data:/data
            - /var/run/docker.sock:/var/run/docker.sock
        restart: unless-stopped

        command: forgejo-runner -c /data/config.yaml daemon
```
- Ordner erstellen:  `mkdir data`
- Default Config erstellen: `docker compose run --rm forgejo-runner 'forgejo-runner' 'generate-config' > data/config.yaml`
- Register Runner:
  - Unter Einstellungen - Actions - Runner - neuen Runner - Token kopieren
  - Dann Registrierung starten: `docker compose run --rm -it forgejo-runner 'forgejo-runner' 'register'`

## Erster Runner Test

`.forgejo/workflows.build.yaml`

```yaml
name: Test Runner
on:
  push:
    branches:
      - main

jobs:
  test-job:
    runs-on: ubuntu-latest

    steps:
      - name: Testnachricht ausgeben
        run: echo "pixeledi mag Forgejo Runner"
```

## Release
> Beschreibung: https://code.forgejo.org/actions/forgejo-release

Nicht vergessen, es braucht einen Token der im Repo - Einstellungen hinterlegt wird.

---

Links:
- https://forgejo.org/docs/next/user/actions/
- https://code.forgejo.org/actions
