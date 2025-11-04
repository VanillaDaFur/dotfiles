import os
import subprocess

networks = []
known_networks = []

# Set home dir
home = os.path.expanduser("~")

# Theme
dir = os.path.expanduser("~/.config/rofi/wifi")
theme = "style"
theme_confirm = "style-confirm"
theme_prompt = "style-prompt"

# Gets all networks nearby + their level of signal
nmtui_output = subprocess.run(
    ["nmcli", "-t", "-f", "SSID,SIGNAL,SECURITY", "dev", "wifi"],
    capture_output=True,
    text=True,
).stdout.strip()

nmtui_known_output = subprocess.run(
    ["nmcli", "-t", "-g", "NAME,TYPE", "con", "show"], capture_output=True, text=True
).stdout.strip()

# Makes output of nmtui_output more readable
for line in nmtui_output.splitlines():
    if line:
        ssid, signal, security = line.split(":", 2)
        networks.append({"ssid": ssid, "signal": int(signal), "security": security})

for line in nmtui_known_output.splitlines():
    if line:
        name, connection_type = line.split(":", 1)
        if "wireless" in connection_type:
            known_networks.append(name)

for net in networks:
    net["known"] = net["ssid"] in known_networks

# Filter networks by known and not known
known_nets = [net for net in networks if net["known"]]
unknown_nets = [net for net in networks if not net["known"]]


def level_of_signal_icon(signal, known):
    # Give icon depending on level of signal + if known
    if known:
        if signal < 25:
            return "󰤟"
        elif signal < 50:
            return "󰤢"
        elif signal < 75:
            return "󰤥"
        else:
            return "󰤨"
    else:
        if signal < 25:
            return "󰤡"
        elif signal < 50:
            return "󰤤"
        elif signal < 75:
            return "󰤦"
        else:
            return "󰤪"


# Confirmation window
def confirm_cmd():
    yes = ""
    no = "󰅖"
    confirm_input = f"{yes}\n{no}"

    confirm = subprocess.run(
        [
            "rofi",
            "-theme",
            f"{dir}/{theme_confirm}.rasi",
            "-theme-str",
            "window {location: center; anchor: center; fullscreen: false; width: 330px;}",
            "-theme-str",
            "mainbox {children: [ 'message', 'listview' ];}",
            "-theme-str",
            "listview {columns: 2; lines: 1;}",
            "-theme-str",
            "element-text {horizontal-align: 0.5;}",
            "-theme-str",
            "textbox {horizontal-align: 0.5;}",
            "-dmenu",
            "-p",
            "Confirmation",
            "-mesg",
            "Are you sure?",
        ],
        input=confirm_input,
        capture_output=True,
        text=True,
    )

    if confirm.returncode == 0:
        selected = confirm.stdout.strip()
        return selected == yes
    else:
        return False


# I use that a lot
def get_wifi_status():
    # Check if wifi is enabled
    wifi_status = subprocess.run(
        ["nmcli", "radio", "wifi"], capture_output=True, text=True
    ).stdout.strip()

    if wifi_status != "enabled":
        return {"status": "disabled", "ssid": None}

    current_connection = subprocess.run(
        ["nmcli", "-t", "-f", "NAME,DEVICE,TYPE", "con", "show", "--active"],
        capture_output=True,
        text=True,
    ).stdout.strip()

    for line in current_connection.splitlines():
        if line and "wireless" in line:
            ssid = line.split(":")[0]
            return {"status": "connected", "ssid": ssid}

    return {"status": "enabled", "ssid": None}


# Self explanatory
def get_wifi_prompt():
    wifi_info = get_wifi_status()

    if wifi_info["status"] == "disabled":
        return "Offline"
    elif wifi_info["status"] == "enabled" and not networks:
        return "Unavailable"
    elif wifi_info["status"] == "enabled":
        return "Available"
    else:
        return wifi_info["ssid"]


# Sends notification depending on returncode
def notify_connection_status(success, ssid):
    icon_path = f"{
        home}/.local/share/icons/Papirus/24x24/panel/network-wireless-on.svg"
    if success:
        subprocess.run(
            [
                "notify-send",
                "-i",
                icon_path,
                "-t",
                "5000",
                "-r",
                "2593",
                "Wi-Fi Connected",
                f"Connected to {ssid}",
            ]
        )
    else:
        subprocess.run(
            [
                "notify-send",
                "-i",
                icon_path,
                "-t",
                "5000",
                "-r",
                "2593",
                "Connection Failed",
                f"Failed to connect to {ssid}",
            ]
        )


# Self explanatory
for net in networks:
    net["icon"] = level_of_signal_icon(net["signal"], net["known"])


# Running whole rofi stuff into a loop
while True:
    menu_items = []

    menu_items.extend(
        [
            f"{net['icon']}  {net['signal']} {
                      net['ssid']}"
            for net in known_nets
        ]
    )

    menu_items.extend(
        [
            f"{net['icon']}  {net['signal']} {
                      net['ssid']}"
            for net in unknown_nets
        ]
    )

    # Adds button to the bottom that disables/enables wifi radio
    # (why do i even comment on this lol)
    wifi_info = get_wifi_status()
    if wifi_info["status"] == "enabled" or wifi_info["status"] == "connected":
        menu_items.extend(["󱚶  Disable Wi-Fi"])
    else:
        menu_items.extend(["󱚺  Enable Wi-Fi"])

    # and it readable for dmenu
    menu_input = "\n".join(menu_items)

    chosen = subprocess.run(
        [
            "rofi",
            "-dmenu",
            "-p",
            f"󰤨 Network ({get_wifi_prompt()})",
            "-theme",
            f"{dir}/{theme}.rasi",
        ],
        input=menu_input,
        capture_output=True,
        text=True,
    )

    # Check if exited without selecting anything or not
    if chosen.returncode == 0:
        selected = chosen.stdout.strip()

        # Check if wifi toggle option was chosen
        if selected in ["󱚶  Disable Wi-Fi", "󱚺  Enable Wi-Fi"]:
            if "Disable" in selected:
                # nmcli then notify-send
                subprocess.run(["nmcli", "radio", "wifi", "off"])
                subprocess.run(
                    [
                        "notify-send",
                        "-i",
                        f"{home}/.local/share/icons/Papirus/24x24/panel/network-wireless-offline.svg",
                        "-t",
                        "5000",
                        "-r",
                        "2593",
                        "Wi-Fi Disabled",
                        "Wi-Fi is offline now",
                    ]
                )

            else:
                # nmcli then notify-send
                subprocess.run(["nmcli", "radio", "wifi", "on"])
                subprocess.run(
                    [
                        "notify-send",
                        "-i",
                        f"{home}/.local/share/icons/Papirus/24x24/panel/network-wireless-on.svg",
                        "-t",
                        "5000",
                        "-r",
                        "2593",
                        "Wi-Fi Enabled",
                        "Wi-Fi is online now",
                    ]
                )
            continue

        selected_ssid = " ".join(chosen.stdout.strip().split()[2:])
        print(f"Selected: {selected_ssid}")
        # If ssid is known
        if selected_ssid in known_networks:
            if confirm_cmd():
                wifi_info = get_wifi_status()

                if (
                    wifi_info["status"] == "connected"
                    and wifi_info.get("ssid") == selected_ssid
                ):
                    print(
                        f"Already connected to {
                          selected_ssid}, doing nothing"
                    )
                else:
                    print(f"Connecting to Wi-Fi {selected_ssid}...")
                    result = subprocess.run(["nmcli", "con", "up", selected_ssid])

                    if result.returncode == 0:
                        notify_connection_status(True, selected_ssid)
                    else:
                        notify_connection_status(False, selected_ssid)
            else:
                print("No was chosen, doing nothing")
        # If not known
        else:
            if confirm_cmd():
                selected_net = next(
                    net for net in networks if net["ssid"] == selected_ssid
                )

                if selected_net["security"] in ["none", "open", ""]:
                    # Network is open, can connect without password
                    print(f"Connecting to Open Wi-Fi {selected_ssid}...")
                    result = subprocess.run(
                        ["nmcli", "dev", "wifi", "connect", selected_ssid]
                    )

                    notify_connection_status(result.returncode == 0, selected_ssid)
                else:
                    password_input = subprocess.run(
                        [
                            "rofi",
                            "-theme",
                            f"{dir}/{theme_prompt}.rasi",
                            "-theme-str",
                            "window {location: center; anchor: center; fullscreen: false; width: 400px;}",
                            "-theme-str",
                            "mainbox {children: [ 'message', 'inputbar' ];}",
                            "-theme-str",
                            "listview {columns: 2; lines: 1;}",
                            "-theme-str",
                            "element-text {horizontal-align: 0.5;}",
                            "-theme-str",
                            "textbox {horizontal-align: 0.5;}",
                            "-dmenu",
                            "-password",
                            "-p",
                            "",
                            "-mesg",
                            f"Enter password for {selected_ssid}: ",
                        ],
                        capture_output=True,
                        text=True,
                    )

                    password = password_input.stdout.strip()

                    if password:
                        print(f"Connecting to Wi-Fi {selected_ssid}...")
                        result = subprocess.run(
                            [
                                "nmcli",
                                "dev",
                                "wifi",
                                "connect",
                                selected_ssid,
                                "password",
                                password,
                            ]
                        )

                        if result.returncode == 0:
                            notify_connection_status(True, selected_ssid)
                        else:
                            notify_connection_status(False, selected_ssid)
                            # and failed connection profile, so it doesn't stay as known
                            subprocess.run(["nmcli", "con", "delete", selected_ssid])
    elif chosen.returncode == 1:
        break  # Exit on esc key
