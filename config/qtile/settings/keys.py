from libqtile.config import Key
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.log_utils import logger
from .keys_funcs import prevscreen, nextscreen
from .groups import groups

mod = "mod4"
terminal = guess_terminal()

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.next(), desc="Move focus next"),
    Key([mod], "k", lazy.layout.previous(), desc="Move focus previous"),


    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod], "grave", lazy.layout.up(), desc="Move focus next"),

    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    #Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
    #    desc="Toggle between split and unsplit sides of stack"),
    Key([mod, "shift"], "Return", lazy.group['scratchpad'].dropdown_toggle('term')),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.screen.toggle_group(), desc="Toggle between groups"),
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "p", lazy.spawn('rofi -show combi -modi combi,calc'),
        desc="Spawn a command using rofi"),
    Key([mod, "shift"], "p", lazy.spawn('rofi -show calc -modi calc,combi'),
            desc="Spawn a command using rofi"),
    

    Key([mod, "control"], "l", lazy.spawn("betterlockscreen --lock"), desc="Lock Screen"),

    # Go to the next group (tag)
    Key(["control"], "Left", lazy.function(prevscreen),
        desc="Switch to previous group"),

    Key(["control"], "Right", lazy.function(nextscreen),
        desc="Switch to next group"),
]

for idx, i in enumerate(groups):
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], str(idx+1), lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),
        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], str(idx+1), lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])
