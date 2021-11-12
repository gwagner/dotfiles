from libqtile.config import Group, Match

groups = [
    Group("", matches=[Match(wm_class=["firefox"])]),
    Group("", matches=[Match(wm_class=["Alacritty"])]),
    Group("", matches=[Match(wm_class=["VSCodium"])]),
    Group("4"),
    Group("5"),    
]

