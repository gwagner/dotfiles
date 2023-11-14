from libqtile.config import Group, ScratchPad, DropDown, Match
from layouts import layouts

groups = [
    ScratchPad("scratchpad", [
        # define a drop down terminal.
        # it is placed in the upper third of screen by default.
        DropDown("term", "alacritty", opacity=0.8),
    ]),
    Group("", layout="stack", matches=[Match(wm_class=["firefox"])]),
    Group("", layout="tile", matches=[Match(wm_class=["Alacritty"])]),
    Group("", layout="tile",matches=[Match(wm_class=["VSCodium", "jetbrains-idea"])]),
    Group("", layout="stack", matches=[Match(wm_class=["looking-glass-client"])]),
    Group(""),
    Group("main", layout="stack", layouts=layouts),
    Group("right", layout="stack", layouts=layouts),
]