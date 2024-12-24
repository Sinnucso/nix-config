# Git

git **user** and **email** are added by home-manager.

if no ssh key available: ssh-keygen
add in github: profilepic - settings - SSH and GPG keys

add remote address:
```
git remote add origin git@github.com:Sinnucso/nix-config.git
```



# Plasma-manager


tool for detecting setting:
'''
nix run github:nix-community/plasma-manager
'''



# sops
sops keyfile needs to be placed manually. create the directory:
'''
mkdir -p ~/.config/sops/age
'''
then add the age key as "keys.txt" file.

currently i dont see the point in generating the key from the ssh key, as the ssh key will be put in place by sops, so if i install to a new device, i need to manually move a key anyway. Also i dont have to deal with generating a non-password secured copy of the ssh key for ssh-to-age to work.

in order to pull the updated secretsfile or .sops.yaml from gitlab, run
'''
nix flake lock --update-input mysecrets
'''
as of now, this works but a warning is given that the command is outdated and will be removed in the future
