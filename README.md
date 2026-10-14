# LuauDecompiler

A lightweight Luau script inspection and decompilation tool developed by Louis.

## Features

- **Script Discovery** — Finds `LocalScripts` and `ModuleScripts` in selected client-accessible containers.
- **Name Filtering** — Quickly filters scripts by name.
- **Alphabetical Sorting** — Organizes scripts in ascending order (`0–9`, `A–Z`).
- **Clipboard Support** — Copies decompiled source code when the executor provides the required API.
- **Console Fallback** — Prints the source to the F9 developer console when clipboard support is unavailable.
- **Error Handling** — Displays status messages when a decompilation attempt fails.

## Compatibility

- Developed and tested with **Xeno**.
- Requires an execution environment that provides the necessary decompilation API.
- Compatibility with other executors has not been verified.

## Installation

1. Download `DecompilerLuauByLouis.lua` from this repository.
2. Open it in your supported Luau execution environment.
3. Execute the script and use the GUI to inspect available scripts.

## Limitations

- Script discovery is limited to the containers scanned by the tool.
- Source retrieval depends on the executor's capabilities and the target script's availability.
- Some scripts may not be accessible or successfully decompiled.
- The GUI is an early version and may receive visual improvements.

## Project Status

**Version:** `1.0.0`  
**Status:** Initial release  
**Last updated:** October 14, 2026

This project was created primarily for experimentation and learning. Long-term maintenance and frequent updates are not guaranteed.

## Credits

- **Developer:** Louis — [@eolouiszz](https://github.com/eolouiszz)
- **Executor:** [Xeno](https://www.xeno.now/)

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
