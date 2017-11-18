function before
    set --local pattern $argv[1]
    set --local --erase argv[1]
    sed -e /$pattern/,\$d $argv
end
