SMODS.Joker {
	key = 'pyrite',

    denouement_can_switch = true,

	config = { extra = { 
		money_gain = 10,
		money_transferred = 1,
		money_stored = 0,
        --false = ??
        switched = false
    }},

	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'cache_pyrite', set = 'Other',
            vars = {
                card.ability.extra.money_gain,
                colours = {
                    HEX('c78544')
                }
            }
        }
        info_queue[#info_queue+1] = {key = 'transfer_pyrite', set = 'Other',
            vars = {
                card.ability.extra.money_transferred,
				colours = {
                    G.C.SUITS.Diamonds,
                }
            }
        }

		return { vars = {
            card.ability.extra.money_gain,
            card.ability.extra.money_transferred,
            card.ability.switched and '[TRANSFER]' or '[CACHE]',
			card.ability.extra.money_stored,
            localize('Diamonds', 'suits_singular'),
            colours = {
                HEX('c78544'),
				G.C.SUITS.Diamonds,
                card.ability.switched and G.C.SUITS.Diamonds or HEX('c78544')
            }
        }}
	end,
	
	rarity = 3,
	atlas = 'jokers_atlas',
	pos = { x = 0, y = 1 },
	cost = 10,

	calculate = function(self, card, context)
        if context.buying_card then
            card.ability.extra.money_stored = card.ability.extra.money_stored + card.ability.extra.money_gain
            return {
                message = localize { type = 'variable', key = 'cached_pyrite'},
                colour = HEX('c78544'),
                focus = card
            }
        end
	end
}