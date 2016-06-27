# VirtualBox

### Requirements

Download and install __[Vagrant](https://www.vagrantup.com/)__ to create a local environment using __[VirtualBox](https://www.virtualbox.org/wiki/Downloads)__.

#### `Vagrant`

You can adjust your virtual machine settings in the `virtualbox/Vagrantfile`.

## Generate Environment

_To create the environment..._

  1. Navigate to the `virtualbox/packer` folder using a terminal program.
  1. Enter and run the following:
    ```shell
    sudo vagrant up
    ```
  1. Once "up", run the following to log in:
    ```shell
    sudo vagrant ssh
    
    su aluxa #switch user
    # <enter aluxa password>
    cd ~ #change to aluxa home
    ```
