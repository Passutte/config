# Debug Symbols
cat <<EOF | sudo tee /etc/apt/sources.list.d/ddebs.list
deb http://ddebs.ubuntu.com focal main restricted universe multiverse
deb http://ddebs.ubuntu.com focal-updates main restricted universe multiverse
deb http://ddebs.ubuntu.com focal-proposed main restricted universe multiverse
EOF

sudo apt install ubuntu-dbgsym-keyring
sudo apt update
sudo apt install debian-goodies

# Core Dump & gdb
sudo apt install systemd-coredump