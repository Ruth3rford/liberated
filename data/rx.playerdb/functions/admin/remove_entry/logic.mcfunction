# source: rx.playerdb:admin/remove_entry/logic
execute if score $in.uid rx.playerdb.io < $uid.next rx.uid run function #rx.playerdb:api/v2/select
execute unless score $in.uid rx.playerdb.io < $uid.next rx.uid run scoreboard players set $size rx.temp 0
execute if score $size rx.temp matches 1 run data modify storage rx.playerdb:temp UUID set from storage rx.playerdb:main players[{selected: 1b}].info.UUID
execute if score $size rx.temp matches 1 run function uuid/select
execute if score $size rx.temp matches 1 run data modify storage rx.playerdb:main uuid[{selected: 1b}].entries[-1].hasEntry set value 0b
execute if score $size rx.temp matches 1 run tellraw @a[tag=rx.admin] ["", {"nbt": "playerdb.name", "storage": "rx:info"}, {"text": " "}, {"text": "Removal Success: Removed ", "color": "#1DF368"}, {"text": "\n\n"}, {"text": "\u2192 Don't forget to reset their rx.playerdb.hnt score (unless you ran admin/delete_player)", "color": "gold"}]
execute if score $size rx.temp matches 1 run data remove storage rx.playerdb:main players[{selected: 1b}]
execute unless score $size rx.temp matches 1 run tellraw @a[tag=rx.admin] ["", {"nbt": "playerdb.name", "storage": "rx:info"}, {"text": " "}, {"text": "Removal Error: Entry does not exist", "color": "#CE4257"}]