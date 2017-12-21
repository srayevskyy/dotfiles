-- load standard vis module, providing parts of the Lua API
require('vis')

vis.events.subscribe(vis.events.INIT, function()
    -- Global configuration options
end) 

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
    -- Per window configuration options
    if win.file.name and string.find(win.file.name, ".yml", -4) then
        win:set_syntax("yaml")
    end

    vis:command("set autoindent")
    vis:command("set number")
    vis:command("set show-newlines")
    vis:command("set show-tabs")

    if win.syntax == "ruby" then
        vis:command("set tabwidth 2")
    else
        vis:command("set tabwidth 4")
    end

    if win.syntax ~= "go" then
        vis:command("set expandtab")
    end
end)
