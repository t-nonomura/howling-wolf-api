package com.ort.wolf4busy.domain.model.daychange

import com.ort.wolf4busy.domain.model.charachip.Charas
import com.ort.wolf4busy.domain.model.message.Message
import com.ort.wolf4busy.domain.model.village.Village

// 無惨な死
object MiserableDeath {

    fun process(dayChange: DayChange, charas: Charas): DayChange {
        val latestDay = dayChange.village.day.latestDay()

        val miserableDeathCharaList = dayChange.village.participant.memberList.filter {
            !it.isAlive() && it.dead?.villageDay?.id == latestDay.id && it.dead.toCdef().isMiserableDeath
        }.map { member ->
            charas.chara(member.charaId)
        }

        return dayChange.copy(
            messages = dayChange.messages.add(createMiserableDeathMessage(dayChange.village, Charas(miserableDeathCharaList)))
        ).setIsChange(dayChange)
    }

    // ===================================================================================
    //                                                                        Assist Logic
    //                                                                        ============
    /**
     * 無惨メッセージ
     * @param village village
     * @param charas 犠牲者キャラ
     * @return 無惨メッセージ
     */
    private fun createMiserableDeathMessage(
        village: Village,
        charas: Charas
    ): Message {
        val text = if (charas.list.isEmpty()) {
            "今日は犠牲者がいないようだ。人狼は襲撃に失敗したのだろうか。"
        } else {
            charas.list.shuffled().joinToString(
                prefix = "次の日の朝、以下の村人が無惨な姿で発見された。\n",
                separator = "、\n"
            ) { it.charaName.name }
        }
        return Message.createPublicSystemMessage(text, village.day.latestDay().id)
    }
}
