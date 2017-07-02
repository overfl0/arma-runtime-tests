# Preface
This is an attempt at making ansible scripts that will create an environment that allows running runtime Arma unit tests, in the form of missions files that dump data to rpt log files. Those logs are then analysed and a decision is made whether the test has passed or failed.

The assumption is to use a linux OS that will allow running linux arma natively and windows arma through wine to have a single machine running all the tests, greatly simplifying the architecture. Wine should be mature enough to handle all the arma server code that does not use DirectX routines (most of the problems with wine seem to be with DirectX, nowadays).

The current solution to runtime testing:
- Arma3server is used because it doesn't require graphics cards to be present (arma3.exe could be run in headless mode but it cannot then be fed a list of missions to run)
- Xvfb is used to make the tests 100% headless
- A *shutdown.VR* mission is added at the end of the server rotation. This mission calls a server command that shuts it down and effectively prevents the server from running the first mission again when the missions list is exhausted.

Note: It's all a work in progress. **Pull requests are welcome**.

The current (**very** minimal set of tests): https://github.com/overfl0/intercept-runtime-tests

### What is currently working:
- OS setup scripts (bash / ansible)
- Arma dev branch update scripts
- Running basic tests (that check if Arma has not crashed while running the tests)

### What's currently missing / TODO:
- Jenkins installed for running the updates and tests automatically (preferably using ansible!)
- Cross-compilation of Intercept prior to running the tests (to have either the latest version or the one that is requested by the test)
- Better functions to parse the rpt output (maybe a rewrite of the bash test scripts to python)
- General cleanup and refactoring. Placing the scripts to a common directory
- Linux server is not working yet (ironically...)

# Installing

*Note: Many steps below could also be automated with ansible itself, instead (like the creation of the arma user). Feel free to submit pull requests.*

*Note: In theory, you can also use ansible to populate docker images (https://www.ansible.com/ansible-container)*

## Prerequisites:
- Ansible installed on the host (your machine)
- An ubuntu server (or debian) vm with python installed
- The vm user should be named `arma` and you should be able to ssh to it without password (using keys)
- The `arma` user should be able to sudo without password (just to run Ansible; after that it's not required anymore)

## Satisfying the prerequisites
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

## Running ansible
- Use `hosts_sample.txt` to create `hosts.txt` and fill it with your vm IP
- Run the ansible playbook to install and set up everything else:
```
localuser@host~$ ansible-playbook -i hosts.txt arma.yml
```

This should set up everything else, besides your steamcmd login and password. Edit the login file and fill in your steam credentials.

```
nano /home/arma/scripts/login
```

# Usage after installation

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
