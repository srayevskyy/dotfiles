function wifi --description 'Manage wifi'

    function __wifi_wlan_dev
        grep -v '|' /proc/net/wireless | cut -d: -f1 | head -1
    end

    function __wifi_ipaddr
        ip -f inet -o addr show dev $argv[1] | awk '{print $4}'
    end

    function __wifi_wpacli
        wpa_cli -i (__wifi_wlan_dev) $argv
    end

    function __wifi_scan
        __wifi_wpacli scan >/dev/null
    end

    function __wifi_list
        __wifi_wpacli scan_results \
                | sed -e '1d' \
                | egrep '[[:space:]]\[ESS]' \
                | sed -re "s/^([[:print:]]+[[:space:]]+){,4}//" \
                | grep -v '^$' \
                | sort -u
    end

    function __wifi_join
        set --local network (__wifi_wpacli add_network)
        printf "
            set_network $network ssid \"$argv[1]\"
            set_network $network key_mgmt NONE
            enable_network $network
            select_network $network
        " \
            | __wifi_wpacli >/dev/null
    end

    function __wifi_detail
        __wifi_wpacli status
    end

    function __wifi_reattach
        __wifi_wpacli reassociate
    end

    function __wifi_password_hash
        echo -n $argv[1] | iconv -t utf16le | openssl md4
    end

    function __wifi_status
        set --local WLAN_DEV (__wifi_wlan_dev)
        set --local wlan_ip (__wifi_ipaddr $WLAN_DEV)
        if test -n $wlan_ip
            set --local bssid (/usr/bin/iw dev $WLAN_DEV link | awk 'NR == 1 { print $3 }')
            set --local ssid (/usr/bin/iw dev $WLAN_DEV link | grep 'SSID:' | sed -e 's/^.*SSID: //')
            set --local tx_bitrate (/usr/bin/iw dev $WLAN_DEV link | awk '/tx bitrate/ {print $3}')
            set --local raw_quality (grep -v '|' /proc/net/wireless | awk '{print $3}' | tr -d .)
            set --local quality (math "100 * $raw_quality / 70")
            printf '%s - %s [%sMbps/%s%% %s]\n' $ssid $bssid $tx_bitrate $quality $wlan_ip
        else
            echo "(not connected)"
        end
    end

    function __wifi_error_message
        echo -n '['; set_color red; echo -n 'ERROR'; set_color normal; echo "] $argv"
    end

    function __wifi_help
        echo 'Usage: wifi <status|detail|list|scan|join <network>|hash-password <password>|reattach>'
    end

    switch "$argv[1]"
    case "" s stat status
        __wifi_status
    case detail
        __wifi_detail
    case ls list
        __wifi_list
    case scan
        __wifi_scan
    case join
        if test (count $argv) -eq 2
            __wifi_join $argv[2]
        else
            __wifi_error_message 'What network should I join?'
            return 2
        end
    case reattach refresh reset
        __wifi_reattach
    case hash hash-password
        if test (count $argv) -eq 2
            __wifi_password_hash $argv[2]
        else
            __wifi_error_message 'What password should I be hashing exactly?'
            return 2
        end
    case '*'
        __wifi_help
        return 1
    end

end
