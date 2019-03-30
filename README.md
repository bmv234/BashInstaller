# BashInstaller

This install script install the prerequisite software packages required.

### Software Packages:

Docker
Docker Compose

The single line installation script allows you to go from a bare-minimal installation of Ubuntu or Debian (Server) to fully operational server. Run the following steps from a root shell:

```bash
sudo bash
<password>
sudo curl https://raw.githubusercontent.com/bmv234/BashInstaller/master/install.sh | bash
<password>
```

### Troubleshooting:

If you get the following error:

sudo: curl: command not found

Then run the following to install curl:

```bash
sudo apt-get install curl -y
```
