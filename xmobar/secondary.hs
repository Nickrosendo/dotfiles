-- http://projects.haskell.org/xmobar/

Config { 
    font = "xft:UbuntuMono Nerd Font:weight=bold:pixelsize=24:antialias=true:hinting=true",
    bgColor = "#181B20",
    fgColor = "#9B9081",
    lowerOnStart = True,
    hideOnStart = False,
    allDesktops = True,
    persistent = True,
    commands = [ 
        Run Date "  %d %b %Y %H:%M " "date" 600,
        Run Com "volume" [] "volume" 10,
        Run Com "battery" [] "battery" 600,
        Run Com "brightness" [] "brightness" 10,
        Run Com "bash" ["-c", "checkupdates | wc -l"] "updates" 3000,
        Run Com "/home/nickrosendo/.config/xmobar/trayer-padding-icon.sh" [] "trayerpad" 600,
        Run UnsafeStdinReader
    ],
    alignSep = "}{",
    template = "<fc=#C41010>  </fc>%UnsafeStdinReader% }{ \
        \<fc=#B294BB> %updates% </fc>\
        \<fc=#F0C674> %brightness%</fc>\
        \<fc=#DE935F> %battery%</fc>\
        \<fc=#CC6666> %date% </fc>\
        \%trayerpad%"
}
