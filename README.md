# Katana-MK2-FxFloorBoard-nix-flake

Nix flake recipe for Katana-MK2-FxFloorBoard

![image](https://github.com/kczulko/Katana-MK2-FxFloorBoard-nix-flake/assets/19495571/8fde91e4-5747-41cd-adcd-14e30bf5729b)

## Important notes

Unfortunately, this build is not fully reproducible. There is no reproducible link for the sources which
moreover are a bit behind the "oficial" releases. In the time of writing, sources are from 
[06.08.2023](https://sourceforge.net/projects/fxfloorboard/files/KatanaFxFloorBoard/Katana%20FxFloorboard%20for%20MK2%20Desktop/)
and can be overridden at any time.

## Howto

```bash
$ nix run github:kczulko/Katana-MK2-FxFloorBoard-nix-flake
```

## Patches

To assure `help` functionality, [simple patch](./patches/help.patch) was added.
