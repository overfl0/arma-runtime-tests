# Steps to install

*Note: Many steps below could also be automated with ansible itself, instead (like the creation of the arma user). Feel free to submit pull requests.*

*Note: In theory, you can also use ansible to populate docker images (https://www.ansible.com/ansible-container)*

## Prerequisites:
- Ansible installed on the host (your machine)
- An ubuntu server (or debian) vm with python installed
- The user should be named Arma and you should be able to ssh to it without password (using keys)
- The arma user should ssh with no password (just to run Ansible; after that it's not required)

## Commands
##### To install python:
```
user@vm~$ sudo apt install python
```

##### To add the arma user:
```
user@vm~$ sudo adduser arma
```

##### To add your ssh keys:
```
localuser@host~$ ssh-copy-id arma@<server_ip>
```

##### To allow sudo without password for the arma user:

```
user@vm~$ sudo visudo
```
And append the following line at the end:
`arma ALL=(ALL) NOPASSWD:ALL`

# Running ansible
- Use `hosts_sample.txt` to create `hosts.txt` and fill it with your vm IP
- Run the ansible playbook to install and set up everything else:
```
localuser@host~$ ansible-playbook -i hosts.txt arma.yml
```

This should set up everything else, besides your steamcmd login and password. Edit the login file and fill in your steam credentials.

```
nano /home/arma/scripts/login
```

# Usage

*Note: These command should ideally be run by Jenkins, not manually!*

## Update arma devel
```
/home/arma/scripts/updateArmaDevel.sh
```

*Note: On the first run, you will need to input a Steam Guard code. Get it in your mail and type it blindly and hit enter (yes, you will not see the text appear on the screen but it will be there!)*


## Run the tests
```
/home/arma/armawindows/mpmissions/intercept-runtime-tests/scripts/runtest.sh /home/arma/armawindows/arma3server.exe
```
