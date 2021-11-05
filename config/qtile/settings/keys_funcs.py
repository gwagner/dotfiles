def nextscreen(qtile):
        group_name = qtile.current_screen.group.name
        for i, group in enumerate(qtile.groups):
            
            # Move to the next screen
            if group_name == group.name and i+1 < len(qtile.groups):
                return qtile.current_screen.set_group(qtile.groups[i+1])

            # Loop back to the beginning
            elif group_name == group.name and i+1 >= len(qtile.groups):
                return qtile.current_screen.set_group(qtile.groups[0])

        # Something went very wrong
        return qtile.current_screen.set_group(qtile.groups[0])

def prevscreen(qtile):
        group_name = qtile.current_screen.group.name
        for i, group in enumerate(qtile.groups):
            
            # Move to the next screen
            if group_name == group.name and i-1 > 0:
                return qtile.current_screen.set_group(qtile.groups[i-1])

            # Loop back to the beginning
            elif group_name == group.name and i-1 < 0:
                return qtile.current_screen.set_group(qtile.groups[len(qtile.groups)-1])
                
        # Something went very wrong
        return qtile.current_screen.set_group(qtile.groups[0])