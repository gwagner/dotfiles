import os

from libqtile import bar, hook, widget
from libqtile.backend.base import Internal, Window
from libqtile.config import Screen
from libqtile.core.manager import Qtile
from libqtile.log_utils import logger
from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration
#from libqtile.widget import Systray
from libqtile.widget.systray import Icon
from groups import groups

screen_layout = "primary"

decor = {
    "decorations": [
        RectDecoration(colour="#4c566a", radius=10, filled=True, padding_y=5)
    ],
    "padding_x": 6,
}

def get_main_bar_widgets():
    global decor

    visible_groups = []
    for group in groups[1:6]:
        visible_groups.append(group.name)

    # List out the network card
    available_cards = os.listdir('/sys/class/net/')

    # Primary desktop uses wlan0
    network_card = "wlan0"

    # Test vm uses ens192
    if network_card not in available_cards and "ens192" in available_cards:
        network_card = "ens192"

    widgetList = [
        widget.CurrentLayoutIcon(
            scale=.75,
            **decor
        ),
        widget.Sep(
            foreground="#2e3440",
            padding=6,
        ),
        widget.GroupBox(
            block_highlight_text_color="#A3BE8C",
            fontsize=20,
            padding=2,
            borderwidth=0,
            disable_drag=True,
            this_current_screen_border="#A3BE8C",
            use_mouse_wheel=False,
            visible_groups=visible_groups,
            **decor
        ),
        widget.Sep(
            foreground="#2e3440",
            padding=6,
        ),
        widget.TaskList(
            fontsize=16,
            borderwidth=0,
            icon_size=16,
            padding_y=6,
            **decor
        ),
        widget.Sep(
            foreground="#2e3440",
            padding=6,
        ),
        widget.CPUGraph(
            border_color="#A3BE8C",
            graph_color="#A3BE8C",
            fill_color="#A3BE8C.3",
            samples=60,
        ),
        widget.MemoryGraph(
            border_color="#A3BE8C",
            graph_color="#A3BE8C",
            fill_color="#A3BE8C.3",
            samples=60,
        ),
        widget.NetGraph(
            border_color="#A3BE8C",
            graph_color="#A3BE8C",
            fill_color="#A3BE8C.3",
            samples=60,
            interface=network_card,
        ),
        widget.Sep(
            foreground="#2e3440",
            padding=6,
        ),
    ]

    batExists = os.path.exists("/sys/class/power_supply/BAT1/capacity")
    if batExists:
        widgetList += [     
            widget.Sep(
                foreground="#2e3440",
                padding=6,
            ),
            widget.Battery(
                update_interval=60,
                padding=2,
            ),
            widget.Sep(
                foreground="#2e3440",
                padding=6,
            ),
        ]
    
    widgetList += [
        widget.CheckUpdates(
            display_format="↻ {updates}",
            distro="Arch_yay",
            no_update_string="",
            update_interval=60,
            padding=2,
        ),
        
        widget.Sep(
            foreground="#2e3440",
            padding=6,
        ),
        widget.Systray(),
        widget.Sep(
            foreground="#2e3440",
            padding=6,
        ),
        widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
    ]

    return widgetList



def get_widget_defaults():
    return dict(
        font='JetBrains Mono',
        fontsize=16,
        padding=3,
        background="#2e3440",
    )


def get_primary_screen():
    return [
               Screen(
                   bottom=bar.Bar(
                       get_main_bar_widgets(),
                       30,
                   ),
               ),
           ]


def get_streamer_screen(qtile):
    main_bar_widgets = get_main_bar_widgets()
    main_bar_widgets[1].visible_groups=['main']
    main_bar_widgets.insert(1, widget.CurrentScreen())
    main_bar_widgets.pop(2)
    main_bar_widgets.insert(2, widget.GroupBox(
        name="streamer_main",
        block_highlight_text_color="#A3BE8C",
        fontsize=34,
        padding=2,
        borderwidth=0,
        disable_drag=True,
        this_current_screen_border="#A3BE8C",
        use_mouse_wheel=False,
        visible_groups=['main'],
    ))

    current_screen = qtile.current_screen
    current_screen.bottom = bar.Bar(main_bar_widgets, 30)
    current_screen.x = 0
    current_screen.y = 0
    current_screen.width = 1920
    current_screen.height = 1080

    return [
        current_screen,
        Screen(
            bottom=bar.Bar(
                [
                    widget.CurrentLayoutIcon(
                        name="streamer_right_current_layout_icon",
                    ),
                    widget.CurrentScreen(
                        name="streamer_right_current_screen",
                    ),
                    widget.GroupBox(
                        name="streamer_right_groupbox",
                        block_highlight_text_color="#A3BE8C",
                        fontsize=34,
                        padding=2,
                        borderwidth=0,
                        disable_drag=True,
                        this_current_screen_border="#A3BE8C",
                        use_mouse_wheel=False,
                        visible_groups=['right'],
                    ),
                    widget.Prompt(
                        name="streamer_right_prompt",
                    ),
                    widget.TaskList(
                        name="streamer_right_tasklist",
                        borderwidth=0,
                    ),
                ],
                30,
            ),
            x=1924,
            y=0,
            width=1516,
            height=1080
        ),
        Screen(
            top=bar.Bar(
                [
                    widget.CurrentLayoutIcon(
                        name="streamer_bottom_current_layout_icon",
                    ),
                    widget.CurrentScreen(
                        name="streamer_bottom_current_screen",
                    ),
                    widget.GroupBox(
                        name="streamer_bottom_groupbox",
                        block_highlight_text_color="#A3BE8C",
                        fontsize=34,
                        padding=2,
                        borderwidth=0,
                        disable_drag=True,
                        this_current_screen_border="#A3BE8C",
                        use_mouse_wheel=False,
                        visible_groups=[''],
                    ),
                    widget.Prompt(
                        name="streamer_bottom_prompt",
                    ),
                    widget.TaskList(
                        name="streamer_bottom_tasklist",
                        borderwidth=0,
                    ),
                ],
                30,
            ),
            x=0,
            y=1084,
            width=3440,
            height=356
        ),

    ]


def set_primary_screens(qtile: Qtile):
    global screen_layout
    #qtile.cmd_info()

    if screen_layout == "primary":
        logger.info("Screen Layout already set to Primary")
        return

    screen_layout = "primary"
    logger.info("Setting Primary Screens")

    # Stop widgets
    logger.info("Finalize widgets")
    for wdgt in qtile.widgets_map.values():
        logger.info(f"Finalize existing widget: {wdgt.name}")
        wdgt.finalize()

    logger.info("Clear out old widgets")
    qtile.widgets_map.clear()

    for existing_window in list(qtile.windows_map.values()):
        logger.info(f"Found window: {existing_window.name}")

        # I dont actually know why i need to skip these, but i do becasue they throw an error if moved
        if isinstance(existing_window, Systray) or isinstance(existing_window, Icon):
            continue

        # Kill off any internal windows, this mainly focuses on killing bars
        if isinstance(existing_window, Internal):
            logger.info(f"Found internal window: {existing_window.name}")
            existing_window.kill()
            continue

        # Send the windows back to their original match groups, all other windows go to group 5
        for group in groups:  # follow on auto-move
            match = next((m for m in group.matches if m.compare(existing_window)), None)
            if match:
                logger.info(f"Moving window {existing_window.name} to group {group.name}")
                existing_window.togroup(group_name=group.name)
                break
            else:
                logger.info(f"Moving window {existing_window.name} to group {groups[5].name}")
                existing_window.togroup(group_name=groups[5].name)

    # Reload the config to get things fully reset
    logger.info("Reload the main config")
    qtile.load_config()

    # Set the screen back to the first group
    qtile.screens[0].set_group(qtile.groups_map[groups[1].name], save_prev=False, warp=True)

    logger.info("Restart Qtile")
    qtile.restart()


def set_streaming_screens(qtile: Qtile):
    global screen_layout
    qtile.cmd_info()

    if screen_layout == "streamer":
        logger.info("Screen Layout already set to Streamer")
        return

    screen_layout = "streamer"
    logger.info("Setting Streaming Screens")

    def setup_screens_hook():
        logger.info("Hook: Setup streaming screens and groups")

        if screen_layout != "streamer":
            logger.info(f"Bailing out, not in streamer mode")
            return

        if len(qtile.screens) < 2:
            logger.info(f"Bailing out, not enough screens: {len(qtile.screens)}")
            return

        logger.info("Manage Existing Windows")
        for existing_window in list(qtile.windows_map.values()):
            if isinstance(existing_window, Systray) or isinstance(existing_window, Icon):
                continue

            if isinstance(existing_window, Internal):
                continue

            logger.info(f"Found window: {existing_window.name}")
            qtile.manage(existing_window)

        qtile.screens[0].set_group(qtile.groups_map["main"], save_prev=False, warp=True)
        qtile.screens[1].set_group(qtile.groups_map["right"], save_prev=False, warp=False)
        qtile.screens[2].set_group(qtile.groups_map[""], save_prev=False, warp=False)

        hook.unsubscribe.screens_reconfigured(setup_screens_hook)

    hook.subscribe.screens_reconfigured(setup_screens_hook)

    for existing_window in list(qtile.windows_map.values()):
        logger.info(f"Found window: {existing_window.name}")
        if isinstance(existing_window, Systray) or isinstance(existing_window, Icon):
            continue

        if isinstance(existing_window, Internal):
            logger.info(f"Found internal window: {existing_window.name}")
            existing_window.kill()
            continue

        if existing_window.group.name != "main" and existing_window.group.name != "right" and existing_window.group.name != groups[2].name:
            logger.info(f"Moving window to main group: {existing_window.name}")
            existing_window.togroup(group_name="main")
            continue

        logger.info(f"Not updating window: {existing_window.name}")

    logger.info("Finalize widgets")
    for wdgt in qtile.widgets_map.values():
        logger.info(f"Finalize existing widget: {wdgt.name}")
        wdgt.finalize()

    logger.info("Clear out old widgets")
    qtile.widgets_map.clear()

    logger.info("Reconfigure Screens 1")
    qtile.cmd_reconfigure_screens()

    logger.info("Add Fake Screens")
    qtile.config.fake_screens = get_streamer_screen(qtile)

    qtile.config.screens.clear()
    qtile.screens.clear()

    logger.info("Reconfigure Screens 2")
    qtile.cmd_reconfigure_screens()

    # Add a hook to send OBS to the right fake screen
    def new_client_hook_streamer_screens(c):
        """
        :type c: Window
        """
        if screen_layout == "streamer":
            logger.info(f"Running new client hook: {c.get_wm_class()}")
            if c.get_wm_class()[0] == "obs":
                logger.info("Found OBS sending it to the right")
                c.togroup("right")
                c.cmd_toscreen(1)
        else:
            hook.unsubscribe.client_new(new_client_hook_streamer_screens)

    logger.info("Setup hooks")
    hook.subscribe.client_new(new_client_hook_streamer_screens)


widget_defaults = get_widget_defaults()
extension_defaults = get_widget_defaults()
screens = get_primary_screen()
