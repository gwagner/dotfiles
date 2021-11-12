from libqtile import layout

tile_conf = {
    "border_focus": "#A3BE8C",
    "margin": 4,
    "ratio": 0.7,
}

layouts = [
    layout.Tile(**tile_conf),
    layout.Max(),
    #layout.Columns(border_focus_stack='#d75f5f'),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]