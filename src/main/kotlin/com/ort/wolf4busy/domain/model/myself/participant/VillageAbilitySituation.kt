package com.ort.wolf4busy.domain.model.myself.participant

import com.ort.wolf4busy.domain.model.ability.Ability
import com.ort.wolf4busy.domain.model.village.Village
import com.ort.wolf4busy.domain.model.village.ability.VillageAbilities
import com.ort.wolf4busy.domain.model.village.participant.VillageParticipant

data class VillageAbilitySituation(
    val type: Ability,
    val targetList: List<VillageParticipant>,
    val target: VillageParticipant?,
    val usable: Boolean,
    val isAvailableNoTarget: Boolean
) {
    constructor(
        village: Village,
        participant: VillageParticipant?,
        ability: Ability,
        villageAbilities: VillageAbilities
    ) : this(
        type = ability,
        targetList = ability.getSelectableTargetList(village, participant),
        target = ability.getSelectingTarget(village, participant, villageAbilities),
        usable = ability.getSelectableTargetList(village, participant).isNotEmpty(),
        isAvailableNoTarget = ability.canNoTarget(village)
    )
}
