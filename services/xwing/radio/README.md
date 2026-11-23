# AI Radio

Deployment of [e13h/radio-dj](https://github.com/e13h/radio-dj): its README
covers how the radio works, the DJ booth, local demo and dry runs.

- `compose.yaml`: the four containers. `radio-dj` and `radio-liquidsoap` use the
  ghcr images from that repo. Keep both on the same tag.
- `config-radio/stations.yaml`: the stations, DJs, personas and shifts, rendered
  by Ansible to `{{ appdata_path }}/apps/radio/config`. Don't put double curly
  braces in personas. Station ids must also be in `STATIONS` on `radio-liquidsoap`.

## Setup

1. In Navidrome, create a regular (non-admin) user for the radio, e.g.
   `radio-bot`, with access to the `main` and `kids` libraries.
2. Add to `inventory/group_vars/homelab/vault.yml`:
   ```yaml
   vault_radio_navidrome_user: "radio-bot"
   vault_radio_navidrome_password: "..."
   vault_radio_icecast_source_password: "..."   # any random string
   vault_radio_icecast_admin_password: "..."    # any random string
   vault_anthropic_api_key: "sk-ant-..."         # optional: template breaks without it
   # Optional: read play counts as *you* so stats and rotation reflect your listening
   # vault_radio_navidrome_stats_user: "evan"
   # vault_radio_navidrome_stats_password: "..."
   ```
3. `just run --tags services`, then on xwing:
   ```bash
   docker compose up -d radio-dj radio-kokoro radio-liquidsoap radio-icecast
   ```
   After changing `stations.yaml`, redeploy and `docker compose restart radio-dj`.

To upgrade, bump both image tags in `compose.yaml`, redeploy, then
`docker compose pull radio-dj radio-liquidsoap && docker compose up -d`.

History is in `{{ appdata_path }}/apps/radio/data/radio.db` (SQLite).
