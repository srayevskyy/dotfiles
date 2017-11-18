function d
    set -gx DISPLAY :0.0
    is-laptop-closed; and set -gx GDK_SCALE 1
end
