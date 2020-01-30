import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']
).get_hosts('all')


def test_toolchain_version(host):
    assert host.file("/opt/mongodbtoolchain/toolchain_version").exists
    assert host.file("/opt/mongodbtoolchain/toolchain_version").contains("testing_mongo_sha")


def test_revisions(host):
    assert host.file("/opt/mongodbtoolchain/revisions/test_mongodbtoolchain/v3/bin").exists
    assert host.file("/opt/mongodbtoolchain/revisions/test_mongodbtoolchain/v3/bin").is_directory
    assert host.file("/opt/mongodbtoolchain/revisions/test_mongodbtoolchain/v3/bin/python3.7").exists


def test_v3(host):
    assert host.file("/opt/mongodbtoolchain/v3/bin").exists
    assert host.file("/opt/mongodbtoolchain/v3/bin").is_directory
    assert host.file("/opt/mongodbtoolchain/v3/bin/python3.7").exists


def test_python(host):
    cmd = host.run("/opt/mongodbtoolchain/revisions/test_mongodbtoolchain/v3/bin/python3.7 --version")
    assert cmd.stdout == """Python 3.7.0
"""
    assert cmd.succeeded
    cmd = host.run("/opt/mongodbtoolchain/v3/bin/python3.7 --version")
    assert cmd.stdout == """Python 3.7.0
"""
    assert cmd.succeeded
