# Bundle Starter

This bundle acts as a basic template for getting started with creating your own Selene bundles.

## Setup

1. Rename `untitled-bundle` to a unique name for your bundle, containing only lowercase letters, numbers, and dashes or underscores.
2. Set a name for your bundle in `bundle.lua`.

## Structure

- `bundle.lua` defines the manifest for your bundle. Here you also specify any client or server scripts that should be loaded.
- Assets and resource definitions should be placed inside the `untitled-bundle` (or whatever you renamed it to) folder.
- Server-side only scripts should be placed inside the `server` folder. They will not be sent to connecting clients.
- UI or other client-side scripts should be placed inside the `client` folder.

## Exporting

This starter comes with an export preset already configured. 

After opening the project in Godot, in the menu bar click "Project -> Export", select the "Selene Bundle" preset, and press "Export PCK/ZIP...". You should save your bundle as a zip file, as PCK is not currently supported.

This preset will export all recognized assets, all `*.lua` files, as well as any files located within `client` and `server`.