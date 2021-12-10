from libqtile.config import Group, Match

groups = [
    Group("", layout="stack", matches=[Match(wm_class=["firefox"])]),
    Group("", layout="tile", matches=[Match(wm_class=["Alacritty"])]),
    Group("", layout="tile",matches=[Match(wm_class=["VSCodium"])]),
    Group("", layout="stack", matches=[Match(wm_class=["looking-glass-client"])]),
    Group(""),    
]

