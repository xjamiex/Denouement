return {
    descriptions = {
        Back={},
        Blind={},
        Edition={},
        Enhanced={},
        Joker={
            j_denouement_rose_quartz = {
                name = {
                    'Rose Quartz',
                },
                text = {
                    "Switches bwtween {V:1}[RECHARGE]{} state",
                    "and {C:red}[EXHAUST]{} state",
                    "{C:inactive}current state:{V:2} #3#",
                    "{C:inactive}currently {X:mult,C:white} X#1#{} Mult",
		        }
            }
        },
        Other={
            recharge_rose_quartz = {
                name = {
                    '{V:1}[RECHARGE]{}'
                },
                text = {
                    "While in {V:1}[RECHARGE]{}",
                    "Gain {X:mult,C:white} X#1#{} Mult",
                    "when a played card with {V:2}Heart{}",
                    "suits is scored",
                    "{C:inactive}Xmult is not applied in this state"
                }
            },
            exhaust_rose_quartz = {
                name = {
                    '{C:red}[EXHAUST]{}'
                },
                text = {
                    "While in {C:red}[EXHAUST]{}",
                    "Lose {X:mult,C:white} X#1#{} Mult",
                    "every hand",
                    "{C:inactive}Xmult is applied in this state"
                }
            }
        },
        Planet={},
        Spectral={},
        Stake={},
        Tag={},
        Tarot={},
        Voucher={},
    },
    misc = {
        achievement_descriptions={},
        achievement_names={},
        blind_states={},
        challenge_names={},
        collabs={},
        dictionary={},
        high_scores={},
        labels={},
        poker_hand_descriptions={},
        poker_hands={},
        quips={},
        ranks={},
        suits_plural={},
        suits_singular={},
        tutorial={},
        v_dictionary={
            charged_rose_quartz = {
                "Charged!"
            },
            stored_rose_quartz = {
                "Stored!"
            },
            exhausted_rose_quartz = {
                "Exhausted!"
            },
        },
        v_text={},
    },
}