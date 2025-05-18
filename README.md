# talos-boot-assets

This is a Talos Linux image factory line for Apple T2 chip devices. 

## Overview

The repository contains a workflow that runs on a cronjob every hour to check and see if a new official [Talos Linux](https://github.com/siderolabs/talos) release has been pushed.

If it detects a newer version is available _(compared to the tag(s) in this repo)_ it will use [Talos Imager](https://github.com/siderolabs/talos/tree/main/pkg/imager) to build new [Boot Assets](https://www.talos.dev/v1.5/talos-guides/install/boot-assets/).

## Patch Updates

Things sometimes break between Talos releases.

If you need to generate a new patch you simply use `git diff > {file in question}`.

## Apple T2 Patches

The patches in the `patches/pkgs/` directory are taken from the [linux-t2-patches](https://github.com/t2linux/linux-t2-patches) repository and is the patches that requires most work with the Talos kernel build since it sometimes break.

To update for the latest kernel you'll need to goto `linux-t2-patches` and compare it to the [Talos pkgs repo](https://github.com/siderolabs/pkgs/releases). Find your release and the kernel version.

Now cross-check the Talos kernel version with the release branch for that kernel in `linux-t2-patches` and update a local fork of `pkgs` with that kernel and the hash of the [driver-kernel release](https://github.com/t2linux/linux-t2-patches/commits/main/version) (at the time of writing Talos is at `6.12`).

## Talos Patches

Talos patches are patches to the [Talos OS](https://github.com/siderolabs/talos) itself. This breaks less often.

Mac minis require an EFI patch to boot with Linux. This simply increases the EFI partition size and can be found `patches/pkgs/`.

If you need to update it you'll need to clone the `talos` repo and generate a new diff.
