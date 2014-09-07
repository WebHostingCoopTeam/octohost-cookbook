Octohost Cookbook
=================

### Vagrant Build

If you want to build your own webhostingcoop octohost read on.

Add your keys to - https://github.com/WebHostingCoopTeam/keys

and also make an appropriate gitreceive line

`command="GITUSER=git /usr/bin/gitreceive run $USER $GITRECEIVEKEY",no-agent-forwarding,no-pty,no-user-rc,no-X11-forwarding,no-port-forwarding ssh-rsa $RSAKEY user@host`

then

    git clone https://github.com/WebHostingCoopTeam/octohost-cookbook.git
    cd octohost-cookbook
    bundle install
    rake build_vagrant

The wildcard domain record *.octodev.io will work for anyone at 192.168.62.86. An octohost is much more useful when your own keys are installed. Even though we can't get to your non-routable 192.168.62.86 address, please don't install our keys on your server.

Once it's built and has your keys in it - package it up:

    vagrant package default --output ~/Desktop/octohost.box
    vagrant box add octohost ~/Desktop/octohost.box
    vagrant init octohost

Add this line to the Vagrantfile:

    config.vm.network :private_network, ip: "192.168.62.86"

Then:

    vagrant up
    git clone git@github.com:octohost/harp.git && cd harp
    git remote add octo git@serve.octodev.io:harp.git
    git push octo master
    lynx http://harp.octodev.io

You know have your own local, private octohost for development and testing - with a free wildcard dns record.

You're welcome.
