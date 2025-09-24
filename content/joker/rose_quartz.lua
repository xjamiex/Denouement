SMODS.Joker {
	key = 'rose_quartz',

    denouement_can_switch = true,

	config = { extra = { 
        Xmult = 1,
        Xmult_gain = 0.5, 
        Xmult_lost = 0.5, 
        --false = exhaust, vise versa
        switched = false
    }},

	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'recharge_rose_quartz', set = 'Other',
            vars = {
                card.ability.extra.Xmult_gain,
                colours = {
                    HEX('f77cd9'),
                    G.C.SUITS.Hearts,
                }
            }
        }
        info_queue[#info_queue+1] = {key = 'exhaust_rose_quartz', set = 'Other',
            vars = {
                card.ability.extra.Xmult_lost
            }
        }

		return { vars = {
            card.ability.extra.Xmult,
            card.ability.extra.Xmult_gain,
            card.ability.switched and '[EXHAUST]' or '[RECHARGE]',
            localize('Hearts', 'suits_singular'),
            colours = {
                HEX('f77cd9'),
                card.ability.switched and G.C.RED or HEX('f77cd9')
            }
        }}
	end,
	
	rarity = 3,
	atlas = 'jokers_atlas',
	pos = { x = 0, y = 0 },
	cost = 10,

	calculate = function(self, card, context)
    
		if context.joker_main then
            if card.ability.switched then
                return {
                    xmult = card.ability.extra.Xmult,
                    colour = G.C.RED
                }
            else
                return {
                    message = localize { type = 'variable', key = 'stored_rose_quartz'},
                    colour = HEX('f77cd9'),
                    focus = card
                }
            end
		end

        if context.final_scoring_step then
            if card.ability.extra.Xmult - card.ability.extra.Xmult_lost <= 1 then
                return
            end
            if card.ability.switched then
                card.ability.extra.Xmult = card.ability.extra.Xmult - card.ability.extra.Xmult_lost
            end

            return {
                message = localize { type = 'variable', key = 'exhausted_rose_quartz'},
                colour = HEX('f77cd9'),
                focus = card
            }
        end

        if context.individual and context.cardarea == G.play and not context.blueprint then
            if not card.ability.switched then
                if context.other_card:is_suit("Hearts") then
                    card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain

                    return {
                        message = localize { type = 'variable', key = 'charged_rose_quartz'},
                        colour = HEX('f77cd9'),
                        focus = card
                    }
                end
            end
        end
	end
}