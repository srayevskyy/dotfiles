function sway
    set --local conf_file $HOME/.config/sway/config.d/eDP1.conf

    if is-laptop-closed
        echo "output eDP-1 disable" > $conf_file
    else
        echo "output eDP-1 scale 2" > $conf_file
    end

    command sway $argv
end
