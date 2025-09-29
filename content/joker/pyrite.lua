SMODS.Joker {
	key = 'pyrite',

    denouement_can_switch = true,

	config = { extra = { 
		money_gain = 6,
		money_transfer = 3,
		money_stored = 0,
        --false = cache
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
                card.ability.extra.money_transfer,
				colours = {
                    G.C.SUITS.Diamonds,
                }
            }
        }

		return { vars = {
            card.ability.extra.money_gain,
            card.ability.extra.money_transfer,
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
            if not card.ability.switched then
                card.ability.extra.money_stored = card.ability.extra.money_stored + card.ability.extra.money_gain
                return {
                    message = localize { type = 'variable', key = 'cached_pyrite'},
                    colour = HEX('c78544'),
                    focus = card
                }
            end
        end

        if context.individual and context.cardarea == G.play and not context.blueprint then
            if card.ability.switched and context.other_card:is_suit("Diamonds") then
                if card.ability.extra.money_stored then
                    G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money_transfer
                    card.ability.extra.money_stored = card.ability.extra.money_stored - card.ability.extra.money_transfer
                end

                return {
                    dollars = card.ability.extra.money_transfer,

                    message = localize { type = 'variable', key = 'transfer_pyrite'},
                    colour = HEX('c78544'),
                    focus = card,
                    func = function() -- This is for timing purposes, it runs after the dollar manipulation
                        G.E_MANAGER:add_event(Event({
                        func = function()
                        G.GAME.dollar_buffer = 0
                        return true
                        end
                    }))
                    end
                }
            end
        end
	end
}