# Monolithic Architecture

Monolithic software is designed to be self-contained, wherein the program's components or functions are tightly coupled rather than loosely coupled.
In a monolithic architecture, each component and its associated components must all be present for code to be executed or compiled and for the software to run.

![Screenshot 2022-08-15 at 16 01 55](https://user-images.githubusercontent.com/102330725/184660570-bd48311e-4da3-4ae2-8e94-acd6f71bc781.png)

### Create a Vagrantfile

```
Vagrant.configure("2") do |config|
    config.vm.define "app" do |app|
        app.vm.box = "ubuntu/bionic64"
        app.vm.network "private_network", ip: "192.168.56.10"
        app.vm.synced_folder ".", "/home/vagrant/app"
        app.vm.provision :shell, path: "provision.sh"
    end

    config.vm.define "db" do |db|
        db.vm.box = "ubuntu/bionic64"
        db.vm.network "private_network", ip: "192.168.56.11"
    end
end

```

Refer: [External Script](https://www.vagrantup.com/docs/provisioning/shell)

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

Your app is ready ad listening on port 3000 appears once connected.

<img width="485" alt="Screenshot 2022-08-15 at 17 32 24" src="https://user-images.githubusercontent.com/102330725/184676488-ce1b76fe-00cc-48e9-bcff-91c23bbf25dd.png">

### Linux Variable & Env Variable in Linux - Windows - Mac

- To check existing Env Var `env` or `printenv`
- To create a var in Linux `Name=Fatema`
- To check Linux Var `echo $Name`
- Env var we have a key word called `export` command ` export Last_Name=Zahra`
- Check specific env variable `printenv Last_Name`
- To make env variable Persistent
- - `sudo nano ~/.bashrc`
- - `source ~/.bashrc`
