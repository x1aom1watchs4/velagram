# NesaOS reference build baseline

This is the first **system build** milestone for NesaOS. It builds upstream openvela for its documented ARM64 emulator target. It does not build firmware for Xiaomi Watch S4.

## Why this target

The official openvela Ubuntu quick start documents the target:

`vendor/openvela/boards/vela/configs/goldfish-arm64-v8a-ap/`

and the matching emulator launch command. The official openvela hardware-porting guidance recommends a stable `trunk` release baseline rather than the fast-moving `dev` branch.

## Host requirements

Follow the upstream requirements before starting:

- Ubuntu 22.04 (x86_64 or arm64).
- At least 16 GB RAM.
- At least 40 GB free disk space.
- Git, curl, CMake, Python 3, libc++abi-dev, build-essential, and Git LFS.
- The upstream quick-start guide currently states that WSL and Docker are not supported for this build flow.

Install the documented packages:

```sh
sudo apt update
sudo apt install git curl cmake python3 libc++abi-dev build-essential
```

Install and initialize Git LFS using the current official Git LFS installation instructions, then:

```sh
git lfs install
```

Install Google's `repo` tool as described in the official openvela Ubuntu quick start. Verify it with:

```sh
repo --version
```

## Checkout and build helper

A helper script automates the stable manifest checkout, sync, revision lock, ARM64 emulator build, and build-log/artifact capture:

```sh
bash /path/to/velagram/NesaOS/system/scripts/build_openvela_reference.sh
```

By default it uses `~/work/nesaos-openvela` and four parallel build jobs. You can choose another workspace and job count:

```sh
JOBS=4 bash /path/to/velagram/NesaOS/system/scripts/build_openvela_reference.sh ~/work/nesaos-openvela
```

The script requires the documented host dependencies and the `repo` tool to be installed. It refuses to initialize a non-empty directory that is not already an openvela repo checkout. It records `manifest.lock.xml`, the build log, exit status, and artifact listing under `nesaos-build-logs/`.

For a release-quality baseline, select and record a specific official openvela `trunk-*` release tag rather than relying indefinitely on a moving branch; confirm that the same tag is available in the manifests repository before pinning it. Review the script before running it; it downloads and builds upstream source code.

## Configure and build the reference target

From the root of the synced openvela workspace:

```sh
./build.sh vendor/openvela/boards/vela/configs/goldfish-arm64-v8a-ap/ --cmake -j$(nproc)
```

Expected output directory:

```text
cmake_out/vela_goldfish-arm64-v8a-ap/
```

The upstream guide says the build artifacts, including `nuttx`, are placed there.

## Run the emulator

```sh
./emulator.sh cmake_out/vela_goldfish-arm64-v8a-ap/
```

A successful boot should reach the documented emulator console prompt:

```text
goldfish-armv8a-ap>
```

## What counts as a successful NesaOS milestone

Do not mark this milestone complete until a developer has attached:

1. Host OS and tool versions.
2. The exact `manifest.lock.xml`.
3. The full build log and exit status.
4. The generated artifact listing.
5. Emulator launch log and a captured successful console boot.

This proves only that the upstream openvela reference target builds and boots. It does not prove any Watch S4 compatibility.

## Next NesaOS engineering steps

After the reference build is reproducible:

1. Identify the actual upstream native system/UI framework and app registration model from the checked-out source.
2. Create a minimal NesaOS system service or native shell component against verified APIs.
3. Integrate the NesaOS launcher and settings as system-level components, not as a Quick App.
4. Keep Watch S4 porting blocked until board identity, drivers, boot contract, signing, and vendor-authorized recovery/update path are established.

## Upstream references

- [openvela Ubuntu Quick Start](https://github.com/open-vela/docs/blob/dev/en/quickstart/openvela_ubuntu_quick_start.md)
- [openvela project and hardware-porting guidance](https://doc.openvela.com/document?id=198&language=en&version=trunk)
- [openvela manifests](https://github.com/open-vela/manifests)
