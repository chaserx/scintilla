# Building Base Images with Packer

The base AMI is built from an AMI that originates from Ubuntu 18.04 that has my public key on it.

The build configuration should create a new AMI with Docker CE installed.

* packer validate ami.json
* packer build ami.json
