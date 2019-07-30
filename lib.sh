CONFIG_HOST=`cat ~/config/.confighost`

function assert-has-config-host() {
    if [[ $CONFIG_HOST == "" ]]; then
        echo "no config host!"
        echo "set a value in ~/config/.confighost"
        exit 1
    fi
}

function dpkg-count() {
    dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -c "ok installed";
}

function i() {
    if [ $(dpkg-count $1) -eq 0 ]; then
        echo "install: $1"
        sudo apt-get -y install $1
    fi
}

function r() {
    if [ $(dpkg-count $1) -gt 0 ]; then
        echo "remove: $1"
        sudo apt-get -y remove $1
    fi
}

function snap-count() {
    snap list | grep -c $1;
}

function i-snap() {
    if [ $(snap-count $1) -eq 0 ]; then
        echo "install: $1"
        sudo snap install $1
    fi
}

function r-snap() {
    if [ $(snap-count $1) -gt 0 ]; then
        echo "remove: $1"
        sudo snap remove $1
    fi }

function deb-count() {
    cat /etc/apt/sources.list /etc/apt/sources.list.d/* | grep -c "^deb .*$1";
}
function deb-src-count() {
    cat /etc/apt/sources.list /etc/apt/sources.list.d/* | grep -c "^deb-src .*$1";
}

function i-ppa() {
    if [ $(deb-count $1) -eq 0 ]; then
        echo "add: $1"
        sudo add-apt-repository ppa:$1
    fi
}

function i-deb() {
    if [ $(deb-count $1) -eq 0 ]; then
        echo "add: $1"
        sudo add-apt-repository "deb $1"
    fi
}

function i-deb-src() {
    if [ $(deb-src-count $1) -eq 0 ]; then
        echo "add: $1"
        sudo add-apt-repository "deb-src $1"
    fi
}

function i-apt-key() {
    if [ $(apt-key list 2>/dev/null | grep -c $2) -eq 0 ]; then
        echo "add apt-key: "
        wget -q -O- $1 | sudo apt-key add -
    fi
}
