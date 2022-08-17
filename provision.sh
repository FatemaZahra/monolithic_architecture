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

#declare DB_HOST env variable
echo "DB_HOST=mongodb://192.168.56.11:27017/posts" | sudo tee -a /etc/environment
printenv DB_HOST

#seeding
cd app/app
npm install
cd seeds
node seed.js






