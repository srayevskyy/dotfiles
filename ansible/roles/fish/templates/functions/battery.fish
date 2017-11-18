function battery --description 'Prints laptop battery information'
    set --local UTF_BATTERY (env printf '\U0001F50B')
    set --local UTF_PLUG (env printf '\U0001F50C')
    set --local NEARLY_DEAD (env printf '\u2620')

    set --local UNKNOWN "$UTF_BATTERY "
    set --local CHARGING "$UTF_PLUG "
    set --local DISCHARGING "$UTF_BATTERY "
    set --local NOT_CHARGING "$UTF_BATTERY "
    set --local FULL "$UTF_BATTERY "

    set --local BATTERY /sys/class/power_supply/BAT1

    if not test -r $BATTERY
        echo "Couldn't find a battery (BAT1) in /sys/class/power_supply"
        return 1
    end

    set --local battery_status (cat $BATTERY/status)
    set --local battery_level (cat $BATTERY/capacity)
    if test $battery_level -lt 15
        set --local battery_level "$NEARLY_DEAD $level"
    end
    switch $battery_status
    case "Unknown"
        echo -e "$UNKNOWN$battery_level%"
    case "Charging"
        echo -e "$CHARGING$battery_level}%"
    case "Discharging"
        echo -e "$DISCHARGING$battery_level%"
    case "Not charging"
        echo -e "$NOT_CHARGING$battery_level%"
    case "Full"
        echo -e "$FULL$battery_level%"
    end
end
