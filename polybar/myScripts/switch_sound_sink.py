#!/usr/bin/python3
"""
Muda o destino padrão do som (Caixa de som/Headset)
"""
import argparse
import pulsectl

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

HEADSET_STR = "Corsair HS60"
HEADSET_INDEX = -1
SOUND_BOX_STR = "HDA NVidia"
SOUND_BOX_INDEX = -1

for n, sink in enumerate(sinks):
    if HEADSET_STR in sink.description:
        HEADSET_INDEX = n
    elif SOUND_BOX_STR in sink.description:
        SOUND_BOX_INDEX = n

print("H {} | B {}".format(HEADSET, SOUND_BOX))


if HEADSET and HEADSET_INDEX != -1:
    print("Set", HEADSET_STR)
    pulse.default_set(sinks[HEADSET_INDEX])
    print(pulse.server_info().default_sink_name)
elif SOUND_BOX and SOUND_BOX_INDEX != -1:
    print("Set", SOUND_BOX_STR)
    pulse.default_set(sinks[SOUND_BOX_INDEX])
    print(pulse.server_info().default_sink_name)
else:
    print("Sink not found")
