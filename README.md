Ansible role for mongo-toolchain
==================================

Installs the mongo toolchain

[![GitHub Actions](https://github.com/mongodb-ansible-roles/ansible-role-mongo-toolchain/workflows/Molecule%20Test/badge.svg)](https://github.com/mongodb-ansible-roles/ansible-role-mongo-toolchain/actions?query=workflow%3A%22Molecule+Test%22)
[![GitHub Actions](https://github.com/mongodb-ansible-roles/ansible-role-mongo-toolchain/workflows/Release/badge.svg)](https://github.com/mongodb-ansible-roles/ansible-role-mongo-toolchain/actions?query=workflow%3A%22Molecule+Test%22)

Explanation
-----------

This role will use the `/opt/mongodbtoolchain/toolchain_version` file to determine whether to install a new toolchain or not.

The `/opt/mongodbtoolchain/toolchain_version` file will be created by this role with the user specified `mongo_toolchain_sha` as its contents.

The `/opt/mongodbtoolchain/toolchain_version` file only shows the latest toolchain that was installed on the host. It does not have any record of older toolchain installations.

If the version file and `mongo_toolchain_sha` match, the toolchain will not be downloaded.

If the versions don't match, the new toolchain will be downloaded to the `/tmp` directory and then moved into the `/opt/mongodbtoolchain/revisions` directory. From there, the toolchain installation script is run.

This role will not delete existing mongo toolchains.

Requirements
------------

Issue when testing on Docker for Mac: [docker/hub-feedback#727], you must download this version of Docker: [Docker 18.06.0-ce](https://github.com/docker/docker-ce/releases/tag/v18.06.0-ce) and then set the Docker daemon `storage-driver` to `aufs`.
```javascript
{
  "storage-driver" : "aufs"
}
```
You can change this setting via `Preferences` -> `Daemon` -> `Advanced`


`ansible-role-toolchain` must be up to date in your `requirements.yml`

    ---
    - src: git+https://github.com/mongodb-ansible-roles/ansible-role-toolchain.git
      version: v1.1.0

Role Variables
--------------

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-------:|:--------:|
| `mongo_toolchain_sha` | SHA of the mongo toolchain you want to download | string | "" | yes |
| `mongo_toolchain_final_dest` | Location of the mongo toolchain | string | "/opt" | no |
| `mongo_toolchain_url` | Optional URL you can specify to download the mongo toolchain directly from | string | "" | no |
| `mongo_toolchain_delete_old_final_dest` | Specify whether to delete the old toolchain first before downloading the new one. This can be used to install a new toolchain on a host that has space restrictions. Do not use this on static hosts as it could leave the host without the old and new toolchain installed | boolean | false | no |
| `mongo_toolchain_evergreen_user` | User that will own the toolchain folder | string | "root" | no |
| `mongo_toolchain_distro_name` | If you need to override a distro name (ie. 'rhel81' instead of 'rhel8') | string | "" | no |

Dependencies
------------

Depends on the [mongodb-ansible-roles.ansible-role-toolchain](https://github.com/mongodb-ansible-roles/ansible-role-toolchain) role to download the archive

Example Playbook
----------------

```yaml
- hosts: all
  roles:
    - role: ansible-role-mongo-toolchain
      vars:
        mongo_toolchain_sha: 1440f2ce9521f9756565ce4a9a45ee382414a80e
```

Development
-----------

Testing this role locally requires the CircleCI [Local CLI](https://circleci.com/docs/2.0/local-cli/).

To install the CLI for macOS and Linux, invoke the following command:

    $ curl -fLSs https://circle.ci/cli | DESTDIR=/usr/local/bin bash

After installing the CLI, invoke the following command to run the Molecule tests:

    $ make test

License
-------

[Apache License](LICENSE)
