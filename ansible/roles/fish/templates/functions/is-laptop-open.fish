function is-laptop-open
    set --local lid_state_file /proc/acpi/button/lid/LID0/state
    test -r $lid_state_file; or return 1
    if test "open" = (sed -e 's/^.*  *//' $lid_state_file)
        return 0
    else
        return 1
    end
end
