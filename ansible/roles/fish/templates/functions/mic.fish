function mic --description 'Manage built-in microphone'

    function __mic_device
        pamixer --list-sources | grep alsa_input | grep 'Built-in' | head -1 | awk '{print $1}'
    end

    function __mic_mute
        pamixer --source (__mic_device) --mute
    end

    function __mic_unmute
        pamixer --source (__mic_device) --unmute
        pamixer --source (__mic_device) --set-volume 100
    end

    function __mic_status
        set --local mic_muted (pamixer --source (__mic_device) --get-mute)
        set --local mic_volume (pamixer --source (__mic_device) --get-volume)
        printf '%s%%, muted: %s\n' $mic_volume $mic_muted
    end

    function __mic_help
        echo 'Usage: mic <status|mute|unmute>'
    end

    switch "$argv[1]"
    case "" s stat status
        __mic_status
    case m mute
        __mic_mute
    case u unmute
        __mic_unmute
    case '*'
        __mic_help
        return 1
    end

end
