package com.ort.wolf4busy.domain.model.village.action

import com.ort.dbflute.allcommon.CDef
import com.ort.wolf4busy.Wolf4busyTest
import com.ort.wolf4busy.domain.model.charachip.Charas
import com.ort.wolf4busy.domain.model.dead.Dead
import com.ort.wolf4busy.domain.model.message.Message
import com.ort.wolf4busy.domain.model.village.VillageStatus
import com.ort.wolf4busy.dummy.DummyDomainModelCreator
import org.assertj.core.api.Assertions.assertThat

import org.junit.Test
import org.junit.runner.RunWith
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.context.junit4.SpringRunner

@RunWith(SpringRunner::class)
@SpringBootTest
class VillageSaySituationTest : Wolf4busyTest() {

    // ===================================================================================
    //                                                                                Test
    //                                                                           =========
    @Test
    fun test_constructor_isAvailableSay_参加していない() {
        // ## Arrange ##
        val village = DummyDomainModelCreator.createDummyVillage()
        val participant = null
        val charas = DummyDomainModelCreator.createDummyCharas()
        val latestDayMessageList: List<Message> = listOf()

        // ## Act ##
        val villageSaySituation = VillageSaySituation(village, participant, charas, latestDayMessageList)

        // ## Assert ##
        assertThat(villageSaySituation.isAvailableSay).isFalse()
    }

    @Test
    fun test_constructor_isAvailableSay_生存() {
        // ## Arrange ##
        val village = DummyDomainModelCreator.createDummyVillage().copy(
            status = VillageStatus(CDef.VillageStatus.進行中)
        )
        val participant = DummyDomainModelCreator.createDummyAliveVillager()
        val charas = Charas(listOf(DummyDomainModelCreator.createDummyChara().copy(id = participant.charaId)))
        val latestDayMessageList: List<Message> = listOf()

        // ## Act ##
        val villageSaySituation = VillageSaySituation(village, participant, charas, latestDayMessageList)

        // ## Assert ##
        assertThat(villageSaySituation.isAvailableSay).isTrue()
    }

    @Test
    fun test_constructor_isAvailableSay_突然死_進行中() {
        // ## Arrange ##
        val village = DummyDomainModelCreator.createDummyVillage().copy(
            status = VillageStatus(CDef.VillageStatus.進行中)
        )
        val participant = DummyDomainModelCreator.createDummyDeadWolf().copy(
            dead = Dead(CDef.DeadReason.突然, DummyDomainModelCreator.createDummyVillageDay())
        )
        val charas = Charas(listOf(DummyDomainModelCreator.createDummyChara().copy(id = participant.charaId)))
        val latestDayMessageList: List<Message> = listOf()

        // ## Act ##
        val villageSaySituation = VillageSaySituation(village, participant, charas, latestDayMessageList)

        // ## Assert ##
        assertThat(villageSaySituation.isAvailableSay).isFalse()
    }

    @Test
    fun test_constructor_isAvailableSay_突然死_エピローグ() {
        // ## Arrange ##
        val village = DummyDomainModelCreator.createDummyVillage().copy(
            status = VillageStatus(CDef.VillageStatus.エピローグ)
        )
        val participant = DummyDomainModelCreator.createDummyDeadWolf().copy(
            dead = Dead(CDef.DeadReason.突然, DummyDomainModelCreator.createDummyVillageDay())
        )
        val charas = Charas(listOf(DummyDomainModelCreator.createDummyChara().copy(id = participant.charaId)))
        val latestDayMessageList: List<Message> = listOf()

        // ## Act ##
        val villageSaySituation = VillageSaySituation(village, participant, charas, latestDayMessageList)

        // ## Assert ##
        assertThat(villageSaySituation.isAvailableSay).isTrue()
    }

    @Test
    fun test_constructor_isAvailableSay_廃村() {
        // ## Arrange ##
        val village = DummyDomainModelCreator.createDummyVillage().copy(
            status = VillageStatus(CDef.VillageStatus.廃村)
        )
        val participant = DummyDomainModelCreator.createDummyDeadWolf()
        val charas = Charas(listOf(DummyDomainModelCreator.createDummyChara().copy(id = participant.charaId)))
        val latestDayMessageList: List<Message> = listOf()

        // ## Act ##
        val villageSaySituation = VillageSaySituation(village, participant, charas, latestDayMessageList)

        // ## Assert ##
        assertThat(villageSaySituation.isAvailableSay).isFalse()
    }
}