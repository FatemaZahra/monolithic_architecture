# What is Vagrant - it's owned by Hashi-Corp
# Ruby

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
    
