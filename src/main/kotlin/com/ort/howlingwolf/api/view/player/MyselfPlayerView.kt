package com.ort.howlingwolf.api.view.player

import com.ort.howlingwolf.api.view.village.VillagesView
import com.ort.howlingwolf.domain.model.player.Player
import com.ort.howlingwolf.domain.model.village.Villages
import com.ort.howlingwolf.fw.security.HowlingWolfUser

data class MyselfPlayerView(
    val id: Int,
    val nickname: String,
    val twitterUserName: String,
    val isAvailableCreateVillage: Boolean,
    val participateProgressVillages: VillagesView,
    val participateFinishedVillages: VillagesView,
    val createProgressVillages: VillagesView,
    val createFinishedVillages: VillagesView
) {
    constructor(
        player: Player,
        participantVillages: Villages,
        createVillages: Villages,
        user: HowlingWolfUser
    ) : this(
        id = player.id,
        nickname = player.nickname,
        twitterUserName = player.twitterUserName,
        isAvailableCreateVillage = player.isAvailableCreateVillage(user),
        participateProgressVillages = VillagesView(participantVillages.list.filter {
            !it.status.isSolved()
        }),
        participateFinishedVillages = VillagesView(participantVillages.list.filter {
            it.status.isSolved()
        }),
        createProgressVillages = VillagesView(createVillages.list.filter {
            !it.status.isSolved()
        }),
        createFinishedVillages = VillagesView(createVillages.list.filter {
            it.status.isSolved()
        })
    )
}