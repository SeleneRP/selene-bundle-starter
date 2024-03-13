# Bundle Starter

This bundle contains everything you need to start creating your own Selene bundles:

- `bundle.lua` defines all entrypoints for your bundle. You should give your bundle a unique id and name here. Ideally, your bundle id should match its folder name.
- Any assets or resource definitions handled by Godot should be placed inside the `untitled-bundle` folder. You should rename this folder to something that is unique to your bundle, to avoid asset conflicts with other bundles. Ideally, just rename it to your bundle id.
- Server-side only scripts should be placed inside the `server` folder, which prevents them from being included in the client bundle.
- UI or other client-side scripts should be placed inside the `client` folder.

## Exporting

This starter comes with an export preset already configured. 

After opening the project in Godot, in the menu bar click "Project -> Export", select the "Selene Bundle" preset, and press "Export PCK/ZIP...". You should save your bundle as a zip file, as PCK is not currently supported.

This preset will export all recognized assets, all `*.lua` files, as well as any files located within `client` and `server`.