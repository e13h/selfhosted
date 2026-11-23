#!/usr/bin/env -S just --justfile

# Ansible playbook against specific host
run *args:
  ansible-playbook -i inventory/hosts.ini site.yml --vault-password-file vault-password.sh {{args}}

# Back up now: just backup [falcon|xwing|homelab] [local|borgbase] (no repo = both)
backup host="homelab" repo="":
  ansible {{host}} -i inventory/hosts.ini --vault-password-file vault-password.sh -b -m shell \
    -a 'borgmatic create --stats --verbosity 1 {{ if repo == "" { "" } else { "--repository " + repo } }}'

decrypt:
  ansible-vault decrypt --vault-password-file vault-password.sh inventory/group_vars/homelab/vault.yml

encrypt:
  ansible-vault encrypt --vault-password-file vault-password.sh inventory/group_vars/homelab/vault.yml

# updates submodules
sub-update:
  #git submodule update --init --recursive
  git submodule update --remote --recursive

# git submodule - repo URL + optional local folder name
sub-add URL *NAME:
    #!/usr/bin/env sh
    if [ -z "{{NAME}}" ]; then
        # Extract repo name from URL if no name provided
        basename=$(basename "{{URL}}" .git)
        git submodule add {{URL}} "roles/${basename}"
        git submodule update --init --recursive
        git add .gitmodules "roles/${basename}"
        git commit -m "Adds ${basename} as a submodule"
    else
        git submodule add {{URL}} "roles/{{NAME}}"
        git submodule update --init --recursive
        git add .gitmodules "roles/{{NAME}}"
        git commit -m "Adds {{NAME}} as a submodule"
    fi
