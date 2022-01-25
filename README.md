# [NMRiH] Item Snatching

Allows you to snatch props carried by other players


https://user-images.githubusercontent.com/11559683/149901849-80af4ae6-afb7-4535-9f99-634a643d2f74.mp4



## Installation
1. Grab the latest ZIP from [releases](https://github.com/dysphie/nmrih-item-snatching/releases)
2. Extract its contents into `addons/sourcemod`
3. Refresh your loaded plugins (`sm plugins refresh` or `sm plugins load item-snatching`)

## ConVars

Saved to and read from `cfg/plugin.item-snatch.cfg`

- `sm_item_snatch_enabled` (Default: `1`) - Enables or disables item snatching


## Immunity

By default admins with the ban flag ("d") are immune to item snatching.
Immunity can be globally reconfigured via [Command Overrides](https://wiki.alliedmods.net/Overriding_Command_Access_(Sourcemod)#Global_Configuration) 
Simply add an `item_snatch_immunity` key to `configs/admin_overrides.cfg`, followed by the desired flag(s), like so:

```cpp
Overrides
{
	"item_snatch_immunity"	"z"	// Restrict immunity to root
}
```

Note that given an arbitrary number of flags, the client must require access to all specified flags in the string, as opposed to just any one of them.
