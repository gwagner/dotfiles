from libqtile.config import Group, Match

groups = [
    Group("", matches=[Match(wm_class=["firefox"])]),
    Group("", matches=[Match(wm_class=["Alacritty"])]),
    Group("", matches=[Match(wm_class=["VSCodium"])]),
    Group("", matches=[Match(wm_class=["looking-glass-client"])]),
    Group(""),    
]

