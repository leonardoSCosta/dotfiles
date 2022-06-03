#!/usr/bin/python3
"""
Muda o destino padrão do som (Caixa de som/Headset)
"""
import argparse
import pulsectl
import pgi
pgi.require_version('Notify', '0.7')
from pgi.repository import Notify

Notify.init("Sound sink switch")

HEADSET = False
SOUND_BOX = False

parser = argparse.ArgumentParser()
parser.add_argument('-H', '--headset', type=bool,
                    metavar='headset', dest='HEADSET')
parser.add_argument('-B', '--box', type=bool,
                    metavar='sound box', dest='SOUND_BOX')
args = parser.parse_args()
print(args.HEADSET, args.SOUND_BOX)

if args.HEADSET is not None:
    HEADSET = args.HEADSET
if args.SOUND_BOX is not None:
    SOUND_BOX = args.SOUND_BOX

pulse = pulsectl.Pulse('sink-switch')
sinks = pulse.sink_list()

ICON_PATH = "/usr/share/icons/candy-icons/apps/scalable/"

HEADSET_STR = "Corsair HS60"
HEADSET_INDEX = -1
HEADSET_ICON = ICON_PATH + "info.mumble.Mumble.svg"

SOUND_BOX_STR = "HDA NVidia"
SOUND_BOX_INDEX = -1
SOUND_BOX_ICON = ICON_PATH + "org.gnome.Rhythmbox.svg"

DEFAULT_STR = "Áudio interno Estéreo analógico"
DEFAULT_INDEX = -1
DEFAULT_ICON = SOUND_BOX_ICON

for n, sink in enumerate(sinks):
    if HEADSET_STR in sink.description:
        HEADSET_INDEX = n
    elif SOUND_BOX_STR in sink.description:
        SOUND_BOX_INDEX = n
    elif DEFAULT_STR in sink.description:
        DEFAULT_INDEX = n

print("H {} | B {}".format(HEADSET, SOUND_BOX))


if HEADSET and HEADSET_INDEX != -1:
    print("Set", HEADSET_STR)
    pulse.default_set(sinks[HEADSET_INDEX])
    print(pulse.server_info().default_sink_name)
    notification = Notify.Notification.new("Sink Changed", "Headset",
                                           HEADSET_ICON)
elif SOUND_BOX and SOUND_BOX_INDEX != -1:
    print("Set", SOUND_BOX_STR)
    pulse.default_set(sinks[SOUND_BOX_INDEX])
    print(pulse.server_info().default_sink_name)
    notification = Notify.Notification.new("Sink Changed", "Sound Box",
                                           SOUND_BOX_ICON)
elif DEFAULT_STR != -1:
    print("Set", DEFAULT_STR)
    pulse.default_set(sinks[DEFAULT_INDEX])
    print(pulse.server_info().default_sink_name)
    notification = Notify.Notification.new("Sink Not Found", "Using Default",
                                           DEFAULT_ICON)
    notification.set_urgency(1)

else:
    print("Sink not found")
    notification = Notify.Notification.new("Sink Change Error",
                                           "Sink Not Found",
                                           SOUND_BOX_ICON)
    notification.set_urgency(2)

notification.show()
