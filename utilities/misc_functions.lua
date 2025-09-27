function DE_UTIL.register_items(items, path)
  for i = 1, #items do
    SMODS.load_file(path .. "/" .. items[i] .. ".lua")()
  end
end

--for dual state jokers
local use_and_sell_buttons = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
    --before
    local switch = nil
    local sell = nil

    if card.area and card.area == G.pack_cards then
        use_and_sell_buttons(card)
        return
    end

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
            {n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = false, button = 'switch_state', func = 'can_switch_state'}, nodes={
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
        use_and_sell_buttons(card)
        return t
    end

    use_and_sell_buttons(card)
end

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

    card.children.center:set_sprite_pos {x = tex_x, y = tex.y}

    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Swapped!", colour = G.C.UI.BACKGROUND_INACTIVE})
end