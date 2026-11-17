# Motorcycle Accessory Distribution

This project is a KiCad PCB for switching and distributing a motorcycle's
12 V electrical supply to several accessory connections. Typical loads include
USB chargers, heated grips or seats, and auxiliary lighting.

## Features

- fused 12 V input using an automotive blade fuse
- accessory outputs switched by an automotive relay
- flyback diode protecting the control input from the relay coil
- shared ground distribution
- multiple screw-terminal and optional direct-solder outputs
- high-current layout using large copper zones
- enclosure models and production-ready Gerber files

The installed fuse and continuous load must match the ordered copper weight,
wiring, and connectors. As a guideline, use a fuse no larger than 20 A with
1 oz copper. Use 30 A only with a suitably designed 2 oz PCB and wiring.
Connected accessories should also be fused appropriately for their wiring.

## Known Issue

**The `DZ85AB-5-PCB` relay socket footprint is incorrect.**

Do not manufacture the current PCB without verifying this footprint. Before a
new order, measure the actual relay socket pin and hole pattern or compare it
against a reliable manufacturer drawing, then correct the footprint.

