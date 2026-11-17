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

## Connections

- **12V IN:** connect directly to the permanent battery-positive supply.
- **GND:** connect to battery negative or a suitable vehicle ground point.
- **CTRL 12V:** connect to a switched 12 V control signal, for example the
  ignition-switched accessory supply. This input energizes the relay coil; it
  does not carry the accessory load current.
- **PER1 to PER6:** switched accessory outputs. Observe the `+` and `-`
  markings printed next to each output.

Both positions of each two-pole input terminal are connected in parallel on
the PCB. They belong to the same electrical net and are not separate inputs.

Minimal connection diagram:

```text
Battery + (permanent) ---- 12V IN ---- Fuse ---- Relay ---- + PER1..PER6
Battery - / chassis ------ GND --------------------------- - PER1..PER6
Ignition-switched +12 V -- CTRL 12V ---- Relay coil
```

When `CTRL 12V` is active, the relay connects the fused permanent supply to
the positive peripheral outputs. Removing the control voltage switches all
outputs off.

## Current Rating and Fusing

The PCB is designed around a theoretical maximum total current of 30 A. This
rating is not verified for a PCB manufactured with 1 oz copper. For 1 oz
copper, a maximum fuse rating of **20 A is recommended**. A 30 A fuse should
only be considered with 2 oz copper and suitably rated wiring, connectors,
assembly, and thermal conditions.

Select the installed blade fuse to match the actual PCB copper weight and the
complete wiring harness. The fuse legend on the PCB allows the assembled
variant to be marked.

The copper paths, specified screw terminals, and optional solder-wire holes
are dimensioned so that each individual output can theoretically carry the
full board current. This permits high-current accessories such as heated grips
or a heated seat, provided the total load remains within the selected fuse and
board rating.

**There is only one overcurrent fuse on the PCB. The outputs are not fused
individually.** Each accessory branch must provide suitable overcurrent and
short-circuit protection for its own device and wiring. An internal fuse in an
accessory does not protect the cable between this board and that fuse; where
the branch cable cannot safely carry the main fuse current, install a separate
branch fuse close to the board.

## Enclosure

[`box.scad`](box.scad) is a minimal example enclosure rather than a finished
vehicle-qualified design. Its current geometry covers the three optional
direct-solder output connections, so those connections are inaccessible when
this example enclosure is used without modification. The three screw-terminal
outputs remain the intended accessible connections.

## Regulatory and Commercial Use

This is a privately developed, non-commercial open-source hardware project and
reference design. It has not undergone a conformity assessment, certification,
regulatory approval, automotive qualification, type approval, or independent
safety or EMC testing for any country or market. It carries no CE, UKCA, FCC,
UL, E-mark, or other regulatory approval, and no claim is made that the design
complies with the requirements of any particular jurisdiction or application.

The MIT License permits commercial use of the design files, but it does not
certify a resulting product or transfer responsibility for regulatory and
product compliance. Anyone who manufactures, modifies, integrates, imports,
distributes, sells, installs, or places a product based on this project on any
market is responsible for determining and fulfilling all requirements that
apply to their role, the finished product, its intended use, and every target
market. Depending on the jurisdiction, these may include testing, conformity
assessment, technical documentation, declarations, labeling and markings,
traceability, instructions, product safety, EMC, environmental requirements,
and vehicle or road-use approvals.

No certification or conformity mark may be inferred from the availability of
these design files. Any required mark or declaration must be issued by the
responsible economic operator only after the applicable procedure for the
finished product has been completed. This notice is not legal advice.

## License

This project is licensed under the [MIT License](LICENSE). Use, modification,
distribution, and commercial use are permitted under its terms. Manufacturer
datasheets in `datasheets/` remain the property of their respective rights
holders.

## Known Issue

**The `DZ85AB-5-PCB` relay socket footprint is incorrect.**

Do not manufacture the current PCB without verifying this footprint. Before a
new order, measure the actual relay socket pin and hole pattern or compare it
against a reliable manufacturer drawing, then correct the footprint.
