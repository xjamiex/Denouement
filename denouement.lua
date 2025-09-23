DE_UTIL = {}

SMODS.load_file("utilities/definitions.lua")()
SMODS.load_file("utilities/misc_functions.lua")()

-- Load the atlases
SMODS.load_file("content/atlas.lua")()

DE_UTIL.register_items(DE_UTIL.ENABLED_JOKERS, "content/joker")