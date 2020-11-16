# Description

On this puppet module, the VoxPopuli Forge module for Nginx is used as base for customisation.

I have created my own puppet classes to configure the necessary parameters already structured on the original module.

The puppet environment selected for this scenario consists on a Vagrant provision to work as a puppet server, scripted on the attached `Vagrantfile`. There are three different machines (nodes for puppet) defined on this file.
​
# Infrastructure
*	**proxy**:   CentOS 7, 1GB RAM memory and 3 network interfaces (192.168.150.101 ; 10.10.10.1 ; 20.20.20.1)
* **client1**: CentOS 7, 512MB RAM memory and 1 network interface (10.10.10.10)
* **client2**: CentOS 7, 512MB RAM memory and 1 network interface (20.20.20.20)
​
## Custom module
Two custom classes are built inside the `netcentric` module for proxying purposes:
​
* **reverse_proxy.pp**\
Two nginx sub-classes are configured to proxy redirect:
  * `nginx::resource::server` to redirect https://domain.com to http://10.10.10.10
  * `nginx::resource::location` to redirect https://domain.com/resource2 to http://20.20.20.20

File resources are used to deploy self-signed TLS certificates and place them in the desired location.
​
* **forward_proxy.pp**
  * `nginx::resource::server` to setup a forward proxy that also collects traffic data logs\
  Logs format is customised according to exercise requirements.

In order to deploy our classes, we just need to declare them on the main `site.pp` file, assigning them to the desired node.

#	Testing scenario
## Infrastructure bootstrap

Clone this repository, change to the repository directory and run: `vagrant up`
​
## How to test
​First modify your local `/etc/hosts` so `domain.com` and `proxy.domain.com` point to `192.168.150.101`.

On the local machine, use the following “curl” commands to check the redirection:

### Reverse proxy		
-	curl -L -I https://domain.com
-	curl -L -I https://domain.com/resource2
### Forward proxy
-	curl -L -I http://google.com --proxy http://proxy.domain.com:8080
