# Training setup development notes

## Making changes

Recommend to clone a copy of the training collections repo to a different
location to the one in `~/training`.

For 2026-09 ESS training:

```
$ cd path/to/repo/dir
$ git clone https://github.com/osprey-dcs/training-collection.git
$ cd training-collection
$ git switch 2026-osprey-ess
$ git submodule init
$ git submodule update
```

For Ansible setup changes, make changes in the
`.../training-collection/vm-setup` directory.

## Testing using Ansible playbook command

```
$ cd .../training-collection/vm-setup/ansible
$ ansible-playbook -e <variable_name>=true playbook.yml
```

List of `variable_name` values in `.../training-collection/local.yml`.

## Deploying for users

Make changes in `.../training-collection/vm-setup/...`

Commit changes and push to https://github.com/osprey-dcs/training-vm.git.
2026-09 ESS training is using the `202609-osprey-ess` branch.

Update submodules in `training-collection` repo.

```
$ cd .../training-collection
$ git add vm-setup
$ git commit -m <add commit message>
$ git push origin 2026-osprey-ess
```

Now running the `update.sh` script for the users should pick up the new changes
and run the Ansible playbook to deploy.

## Notes

* macOS image in UTM has `phoebus=true` commented out in `~/training/local.yml`.
    This is to prevent it trying to rebuild every time due to the Ansible task
    that changes JavaFX to a version that supports `aarch64`. Ansible identifies
    that something has changed when re-cloning the repo, and triggers a Phoebus
    rebuild which takes a while. This is not an issue on `x86_64` as we don't
    need to make the JavaFX change, so `phoebus=true` is not commented out in
    the `.vdi` and `.qcow2` images.

