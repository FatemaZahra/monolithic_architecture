# Monolithic Architecture

Monolithic software is designed to be self-contained, wherein the program's components or functions are tightly coupled rather than loosely coupled.
In a monolithic architecture, each component and its associated components must all be present for code to be executed or compiled and for the software to run.

![Screenshot 2022-08-15 at 16 01 55](https://user-images.githubusercontent.com/102330725/184660570-bd48311e-4da3-4ae2-8e94-acd6f71bc781.png)

### Create a Vagrantfile

```

Vagrant.configure("2") do |config|

 config.vm.box = "ubuntu/xenial64" # Linux - ubuntu 16.04
# creating a virtual machine ubuntu
 config.vm.network "private_network", ip: "192.168.56.10"
# once you have added private network, you need reboot VM - vagrant reload
# if reload does not work - try - vagrant destroy - then vagrant up

#let's sync our app folder from localhost to VM
 config.vm.synced_folder ".", "/home/vagrant/app"

 config.vm.provision :shell, path: "provision.sh"




end
```

### Create a provision.sh file

Include all commands to be run into the provision.sh file

```# update

sudo apt-get update -y

# upgrade

sudo apt-get upgrade -y

# install nginx

sudo apt-get install nginx -y

# enable nginx

sudo systemctl enable ngnix
sudo systemctl start nginx


# install nodejs

sudo apt-get install nodejs -y

# install version 6

sudo apt-get purge nodejs npm

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -

# install node.js again

sudo apt-get install nodejs -y

# install pm2

sudo npm install pm2 -g

# update

sudo apt-get update -y

#upgrade

sudo apt-get upgrade -y
```

Run command `vagrant up`

**Once done,**

Run commands

`vagrant ssh`

`cd` into the folder where `app.js` is present

- Run `npm install`

- `npm start`
