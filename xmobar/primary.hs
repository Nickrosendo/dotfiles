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
        Run Network "enp4s0" ["-t", " <rx>kb  <tx>kb"] 150,
        Run Cpu ["-t", " (<total>%)","-H","50","--high","red"] 150,
        Run Memory ["-t", "  <used>M (<usedratio>%)"] 150,
        Run Com "volume" [] "volume" 10,
        Run Com "/home/nickrosendo/.config/xmobar/cpu-temperature.sh" [] "cpu_temp" 600,
        Run Com "/home/nickrosendo/.config/xmobar/trayer-padding-icon.sh" [] "trayerpad" 600,
        Run UnsafeStdinReader
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "<fc=#C41010>  </fc>%UnsafeStdinReader% }{ \
        \<fc=#FFB86C> %cpu% </fc>\
        \<fc=#85678F> %cpu_temp% </fc>\
        \<fc=#FF5555> %memory% </fc>\
        \<fc=#8ABEB7> %enp4s0% </fc>\
        \<fc=#B5BD68> %volume% </fc>\
        \<fc=#CC6666> %date% </fc>\
        \%trayerpad%" 
}
