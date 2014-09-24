Octohost Cookbook
=================
# Instructions specific to the webhostingcoopteam

### Vagrant Build

If you want to build your own webhostingcoop octohost read on.

Add your keys to - https://github.com/WebHostingCoopTeam/keys

and also make an appropriate gitreceive line

`command="GITUSER=git /usr/bin/gitreceive run $USER $GITRECEIVEKEY",no-agent-forwarding,no-pty,no-user-rc,no-X11-forwarding,no-port-forwarding ssh-rsa $RSAKEY user@host`

FYI - I'm not even certain I labeled the above variables correctly.  Just a wild guess. 
I had to install https://github.com/progrium/gitreceive
and had it create the necessary gitreceive line

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

 Add yourself here:

https://github.com/WebHostingCoopTeam/keys

also fun things to try once you've got one up:

http://octohost.io/languages.html

just about every link goes to a repo that you simply
(s/$THING/YourThingFromAbovePage/)

    git clone git@github.com:octohost/$THING.git && cd $THING
    git remote add octo git@serve.octodev.io:$THING.git
    git push octo master

grab all the repos at once from octohost at once!
    mkdir Octohost; cd Octohost
    curl -s "https://api.github.com/users/octohost/repos" | ruby -rjson -e 'JSON.load(STDIN.read).each {|repo| %x[git clone #{repo["ssh_url"]} ]}'

You know have your own local, private octohost for development and testing - with a free wildcard dns record.

You're welcome.
