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

```
# update

sudo apt-get update -y

# upgrade

sudo apt-get upgrade -y

# install nginx

sudo apt-get install nginx -y

# enable nginx

sudo systemctl enable nginx
sudo systemctl start nginx


# install nodejs

sudo apt-get install nodejs -y

# install version 6
# sudo apt-get install npm -y
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

#reverse_proxy

sudo cp -f app/app/proxy_file /etc/nginx/sites-available/default
# sudo nginx -t
sudo systemctl restart nginx

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

## Multi-Machine

![Screenshot 2022-08-16 at 16 45 50](https://user-images.githubusercontent.com/102330725/184922480-dd8cceeb-dc3c-421c-bffe-bebb9dc6dfe6.png)
![Screenshot 2022-08-18 at 09 47 58](https://user-images.githubusercontent.com/102330725/185352864-333beb80-ed8a-4426-9549-aeb57592bf97.png)


### To provision reverse proxy

- Create a proxy_file with the following code:

  ```
  server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;


        index index.html index.htm index.nginx-debian.html;

        server_name _;

        location / {
                proxy_pass http://localhost:3000;
        }
  }
  ```

- Run command `vagrant destroy`, remove the .vagrant file `rm -rf .vagrant`
- Run `vagrant up` again
- Run `vagrant ssh ap`
- To run the app `npm install` and `npm start`

## Dependencies for Configuration of MongoDB

- Go to `vagrant ssh db`

- `sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927`

- `echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list`

- run `sudo apt-get update -y` `sudo apt-get upgrade -y`

- `sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20`

- Check the status of mongodb `systemctl status mongod`
- If not active, run `sudo systemctl restart mongod` and `sudo systemctl enable mongod` and check the status again.

## Edit mongod.conf file

- Run `cd /etc` then `ls` and `sudo nano mongod.conf`
- Go to network interface and change bindip to `0.0.0.0`
- `cat mongod.conf` to check

## Restart DB

- Run commands: `sudo systemctl restart mongod` `sudo systemctl enable mongod` `sudo systemctl status mongod`

# Create Env variable and Relaunch the app

- Go back to the app again `vagarant ssh app`
- `export DB_HOST=mongodb://192.168.56.11:27017/posts`
- To check `printenv DB_HOST`
- `cd app/app`
- `npm start`

# Steps for seeding

- `ls`
- `cd seeds`
- `ls`
- `node seed.js`
- `npm start`

# For provisioning connection to db

- Add following commands to the exisiting provision file

  ```
  #declare DB_HOST env variable
  echo "DB_HOST=mongodb://192.168.56.11:27017/posts" | sudo tee -a /etc/environment
  printenv DB_HOST

  #seeding
  cd app/app
  npm install
  cd seeds
  node seed.js
  ```

- Create a provision file for db

```
# update

sudo apt-get update -y

# upgrade

sudo apt-get upgrade -y

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927
echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20

systemctl status mongod
sudo systemctl restart mongod
sudo systemctl enable mongod

sudo cp -f app/app/mongodbconfig.conf /etc/mongod.conf
sudo systemctl restart mongod
sudo systemctl enable mongod
sudo systemctl status mongod

```

- Add following commands to the vagrant file

  ```
  Vagrant.configure("2") do |config|
    config.vm.define "app" do |app|
        # creating a virtual machine ubuntu
        app.vm.box = "ubuntu/bionic64"
        # creating a private network
        app.vm.network "private_network", ip: "192.168.56.10"
        # sync app folder from localhost to VM
        app.vm.synced_folder ".", "/home/vagrant/app"
        # adding provision file
        app.vm.provision :shell, path: "provision.sh"
    end

    config.vm.define "db" do |db|
        db.vm.box = "ubuntu/bionic64"
        # creating a virtual machine ubuntu
        db.vm.network "private_network", ip: "192.168.56.11"
        # creating a private network
        # sync app folder from localhost to VM
        db.vm.synced_folder ".", "/home/vagrant/app"
        db.vm.provision :shell, path: "provision_db.sh"
    end
  end

  ```

- Run `vagrant destroy` , delete the .vagrant file
- Run `vagrant up`
- ssh in the app `vagrant ssh app`
- `cd` in the location of the app
- Run `npm install`
- `npm start`
- This should lauch the app with the posts and fibonacci series

```

```
