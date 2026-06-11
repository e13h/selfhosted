#!/usr/bin/env -S just --justfile

# Ansible playbook against specific host
run *args:
  ansible-playbook -i inventory/hosts.ini site.yml --vault-password-file vault-password.sh {{args}}



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
