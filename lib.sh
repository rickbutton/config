CONFIG_HOST=`cat ~/config/.confighost`

function assert-has-config-host() {
    if [[ $CONFIG_HOST == "" ]]; then
        echo "no config host!"
        echo "set a value in ~/config/.confighost"
        exit 1
    fi
}