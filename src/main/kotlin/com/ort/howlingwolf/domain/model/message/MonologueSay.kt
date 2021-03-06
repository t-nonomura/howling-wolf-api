package com.ort.howlingwolf.domain.model.message

import com.ort.howlingwolf.domain.model.village.Village
import com.ort.howlingwolf.domain.model.village.participant.VillageParticipant
import com.ort.howlingwolf.fw.exception.HowlingWolfBusinessException

object MonologueSay {

    fun isViewable(village: Village, participant: VillageParticipant?): Boolean {
        // 村として可能か
        if (!village.isViewableMonologueSay()) return false
        // 参加者として可能か
        participant ?: return false
        return participant.isViewableMonologueSay()
    }

    fun isSayable(village: Village, participant: VillageParticipant): Boolean {
        // 参加者として可能か
        if (!participant.isSayableMonologueSay()) return false
        // 村として可能か
        return village.isSayableMonologueSay()
    }

    fun assertSay(village: Village, participant: VillageParticipant) {
        if (!isSayable(village, participant)) throw HowlingWolfBusinessException("発言できません")
    }
}
