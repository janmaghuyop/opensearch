# https://app.vagrantup.com/boxes

Vagrant.configure("2") do |config|

  config.vm.define "opensearch" do |config|
    # https://app.vagrantup.com/boxes/search
    # ubuntu 22.04
    config.vm.box = "ubuntu/jammy64"

    config.vm.hostname = "opensearch"
    config.vm.box_check_update = false
    config.vm.network "private_network", ip: "192.168.56.110"
    config.vm.synced_folder '.', '/vagrant', disabled: false

    # increase primary disk
    # https://www.vagrantup.com/docs/disks/usage
    # export VAGRANT_EXPERIMENTAL="disks"
    # config.vm.disk :disk, size: "200GB", primary: true

    config.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.cpus = 4
      vb.memory = "16392"
      vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ] # disable logging

      # FIX
      # https://github.com/hashicorp/vagrant/issues/9524
      vb.customize [ "modifyvm", :id, "--audio", "none"]
    end



$ROOT_SCRIPT = <<SCRIPT
# https://docs.docker.com/engine/install/ubuntu/
apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin


# https://www.digitalocean.com/community/tutorials/how-to-install-docker-compose-on-ubuntu-18-04
curl -L https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose


# https://docs.docker.com/engine/install/linux-postinstall/
usermod -aG docker vagrant

SCRIPT



$USER_SCRIPT = <<SCRIPT
# check
docker version
docker-compose version

# go to /vagrant
echo "cd /vagrant" >> /home/vagrant/.bashrc
SCRIPT



    config.vm.provision "shell", :inline => $ROOT_SCRIPT
    config.vm.provision "shell", :inline => $USER_SCRIPT, privileged: false

  end

end

