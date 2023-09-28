#!/bin/bash 

#Some preconfiguration variables specific for user
read -p 'email: ' email

#Install brew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

#Install GCC
brew install gcc

#Install FUZZY (fzf) and saml2aws
brew install fzf saml2aws

#Installing AWSCLI in v2. That is the only way, do not use repo manager in linux like apt or brew to install it. 
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && sudo ./aws/install

# Getting profiles for CB, that step needs preconfiguration of SSH
git clone git@github.com:connectedbrewery/nl029oc-aws-profiles.git
ln -sf $(pwd)/nl029oc-aws-profiles/GlobalDataScientistRole ~/.aws/config

#Install ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Adding Connected Brewery command. More info on https://github.com/connectedbrewery/nl029oc-aws-profiles/tree/main
cat nl029oc-aws-profiles/zshrc.zsh >> test.txt

#GitHUB setup
ssh-keygen -t ed25519 -C "$email"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

cat << EOF
Below SSH key please save in your GitHUB account
Full manual in this link https://docs.github.com/en/enterprise-cloud@latest/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account
Please do not forgot to authorize you SSH key for Connected Brewery company where all repos are
Manual how to do it in this link https://docs.github.com/en/enterprise-cloud@latest/authentication/authenticating-with-saml-single-sign-on/authorizing-an-ssh-key-for-use-with-saml-single-sign-on
EOF
cat ~/.ssh/id_ed25519.pub

#GitHUB connection test
ssh -T git@github.com
