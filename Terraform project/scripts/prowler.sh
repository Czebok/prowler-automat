#!/bin/bash
sudo apt-get update
sudo apt-get upgrade -y
curl https://bootstrap.pypa.io/get-pip.py | sudo python3
export PATH=/home/ubuntu/.local/bin:$PATH
pip install prowler-cloud

cat << EOF > startscan.sh
#!/bin/bash
ACCOUNT_LIST=( ["211125615902"]="eu-central-1" )
ROLE_TO_ASSUME=prowler-rola

for accountID in "\${!ACCOUNT_LIST[@]}"; do
    prowler aws -q -f \${ACCOUNT_LIST[\$accountID]} -D s3-wyniki-prowler --role arn:aws:iam::\$accountID:role/\$ROLE_TO_ASSUME
done
EOF
sudo chmod +x /home/ubuntu/startscan.sh
