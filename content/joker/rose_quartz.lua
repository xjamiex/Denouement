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

G.FUNCS.can_switch_state = function (card)
    return true
end

G.FUNCS.switch_state = function (e, mute, nosave)
    --e.config.button = nil
    local card = e.config.ref_table
    local tex = card.config.center.pos
    local tex_x = tex.x --i dont fucking know
    card.ability.switched = not card.ability.switched

    if card.ability.switched then
        tex_x = tex_x + 1
    end

    card.children.center:set_sprite_pos {x = tex_x, y = 0}

    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Swapped!", colour = HEX('f77cd9')})
end


local use_and_sell_buttons = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
    --before
    local switch = nil
    local sell = nil

    if card.area and card.area.config.type == 'joker' then
        if card.config.center.denouement_can_switch then
            sell = {n=G.UIT.C, config={align = "cr"}, nodes={
                {n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card'}, nodes={
                    {n=G.UIT.B, config = {w=0.1,h=0.6}},
                    {n=G.UIT.C, config={align = "tm"}, nodes={
                    {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                        {n=G.UIT.T, config={text = localize('b_sell'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
                    }},
                    {n=G.UIT.R, config={align = "cm"}, nodes={
                        {n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.4, shadow = true}},
                        {n=G.UIT.T, config={ref_table = card, ref_value = 'sell_cost_label',colour = G.C.WHITE, scale = 0.55, shadow = true}}
                    }}
                    }}
                }},
            }}

            switch = {n=G.UIT.C, config={align = "cr"}, nodes={
                {n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = HEX('f77cd9'), one_press = false, button = 'switch_state', func = 'can_switch_state'}, nodes={
                    {n=G.UIT.B, config = {w=0.1,h=0.6}},
                    {n=G.UIT.T, config={text = "Switch",colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
                }}
                }}

            local t = {
                n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
                {n=G.UIT.C, config={padding = 0.15, align = 'cl'}, nodes={
                {n=G.UIT.R, config={align = 'cl'}, nodes={
                    sell
                }},
                {n=G.UIT.R, config={align = 'cr'}, nodes={
                    switch
                }},
                }},
            }}
            return t
        else return use_and_sell_buttons(card) end
    end

    use_and_sell_buttons(card)
end