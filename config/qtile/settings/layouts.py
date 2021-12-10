from libqtile import layout

tile_conf = {
    "border_on_single": False,
    "border_focus": "#A3BE8C",
    "margin": 4,
    "margin_on_single": True,
    "ratio": 0.6,
}

layouts = [
    layout.Tile(**tile_conf),
    layout.Stack(num_stacks=1, margin=20, border_width=0),
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
