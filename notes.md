# Development Notes — LouisReconDecompiler

> Simple Luau script inspection tool developed by Louis.

## Project Information

- **Current Version:** `1.0.0`
- **Status:** Initial Release
- **Last Updated:** October 14, 2026
- **Executor Credits:** [Xeno](https://www.xeno.now/)

## Implemented Features

- [x] **Name Filtering** — Filter scripts by name.
- [x] **Alphabetical and Numeric Sorting** — Sort LocalScripts and ModuleScripts by name, in ascending order (`0–9`, `A–Z`).
- [x] **Error Notifications** — Display an error status when a decompilation attempt fails.
- [x] **Clipboard Support** — Copy the decompiled source to the clipboard when the required API is available.
- [x] **Fallback Output** — Print the source to the F9 developer console when clipboard support is unavailable.

## Known Limitations

- The tool has only been tested with Xeno. Compatibility with other executors has not been verified.
- Some features depend on executor-specific APIs.
- Script discovery and source retrieval may be limited by the execution environment, script availability, or obfuscation.
- Some LocalScripts or ModuleScripts may not be discovered or successfully decompiled.
- The GUI is still incomplete and may need visual improvements.

## Planned Improvements

- Improve the GUI with a sci-fi aesthetic inspired by *Rick and Morty*.

> **Maintenance Notice:** This is a simple tool developed primarily for experimentation and learning. Long-term maintenance and frequent updates are not planned. Do not expect regular releases or ongoing support.

## Changelog

### `v1.0.0` — Initial Release

- Created the initial graphical interface.
- Added discovery of LocalScripts and ModuleScripts in selected client-accessible containers.
- Implemented alphabetical and numeric sorting.
- Added script name filtering.
- Added decompilation error notifications.
- Implemented clipboard integration and console output fallback.

