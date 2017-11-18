function after --description "sed wrapper to show all lines after a certain pattern"
    set --local pattern $argv[1]
    set --local --erase argv[1]
    sed -e "1,/$pattern/d" $argv
end
