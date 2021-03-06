package com.ort.howlingwolf.application.coordinator

import com.ort.dbflute.allcommon.CDef
import com.ort.dbflute.exbhv.PlayerBhv
import com.ort.howlingwolf.HowlingWolfTest
import com.ort.howlingwolf.application.service.*
import com.ort.howlingwolf.domain.model.player.Players
import com.ort.howlingwolf.domain.model.village.Village
import com.ort.howlingwolf.domain.model.village.VillageDays
import com.ort.howlingwolf.domain.model.village.VillageStatus
import com.ort.howlingwolf.domain.model.village.participant.VillageParticipants
import com.ort.howlingwolf.domain.model.village.setting.*
import com.ort.howlingwolf.fw.exception.HowlingWolfBusinessException
import com.ort.howlingwolf.fw.security.HowlingWolfUser
import org.assertj.core.api.Assertions.assertThat
import org.junit.Test
import org.junit.runner.RunWith
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.context.junit4.SpringRunner
import org.springframework.transaction.annotation.Transactional
import java.time.LocalDateTime

@RunWith(SpringRunner::class)
@SpringBootTest
@Transactional
class VillageCoordinatorTest : HowlingWolfTest() {

    // ===================================================================================
    //                                                                           Attribute
    //                                                                           =========
    @Autowired
    lateinit var playerBhv: PlayerBhv
    @Autowired
    lateinit var villageCoordinator: VillageCoordinator
    @Autowired
    lateinit var villageService: VillageService
    @Autowired
    lateinit var messageService: MessageService
    @Autowired
    lateinit var charachipService: CharachipService
    @Autowired
    lateinit var playerService: PlayerService
    @Autowired
    lateinit var abilityService: AbilityService
    @Autowired
    lateinit var voteService: VoteService
    @Autowired
    lateinit var commitService: CommitService

    // ===================================================================================
    //                                                                                Test
    //                                                                           =========
    @Test
    fun test_registerVillage() {
        // ## Arrange ##
        val paramVillage = createVillageRegisterParam()
        val player = playerBhv.selectByPK(2).get()
        val user = HowlingWolfUser(player.uid, player.authorityCodeAsAuthority)

        // ## Act ##
        val villageId = villageCoordinator.registerVillage(paramVillage, user)

        // ## Assert ##
        val village = villageService.findVillage(villageId)
        assertThat(village.creatorPlayerId).isEqualTo(1)
        assertThat(village.participant.count).isEqualTo(1)
        val messages = messageService.findMessages(
            villageId,
            village.day.latestDay().id,
            listOf(CDef.MessageType.通常発言),
            null,
            null
        )
        assertThat(messages.list).isNotEmpty
    }

    @Test(expected = HowlingWolfBusinessException::class)
    fun test_assertParticipate() {
        // ## Arrange ##
        val paramVillage = createVillageRegisterParam()
        val player = playerBhv.selectByPK(2).get()
        val user = HowlingWolfUser(player.uid, player.authorityCodeAsAuthority)
        val villageId = villageCoordinator.registerVillage(paramVillage, user)
        val village = villageService.findVillage(villageId)
        val charas = charachipService.findCharaList(village.setting.charachip.charachipId)

        // ## Act ##
        // ## Assert ##
        villageCoordinator.assertParticipate(
            villageId = villageId,
            user = user,
            charaId = charas.list[1].id,
            isSpectate = false,
            password = ""
        )
        // 見学不可設定なので見学はできない
        villageCoordinator.assertParticipate(
            villageId = villageId,
            user = user,
            charaId = charas.list[1].id,
            isSpectate = true,
            password = ""
        )
    }

    @Test
    fun test_participate() {
        // ## Arrange ##
        val paramVillage = createVillageRegisterParam()
        val player = playerBhv.selectByPK(2).get()
        val user = HowlingWolfUser(player.uid, player.authorityCodeAsAuthority)
        val villageId = villageCoordinator.registerVillage(paramVillage, user)
        var village = villageService.findVillage(villageId)
        val charas = charachipService.findCharaList(village.setting.charachip.charachipId)

        // ## Act ##
        villageCoordinator.participate(
            villageId = villageId,
            playerId = 2,
            charaId = charas.list[1].id,
            message = "入村しましたよ",
            isSpectate = false
        )

        // ## Assert ##
        village = villageService.findVillage(villageId)
        assertThat(village.participant.memberList.any { it.charaId == charas.list[1].id })
    }

    @Test
    fun test_changeSkillRequest() {
        // ## Arrange ##
        val paramVillage = createVillageRegisterParam()
        val player = playerBhv.selectByPK(2).get()
        val user = HowlingWolfUser(player.uid, player.authorityCodeAsAuthority)
        val villageId = villageCoordinator.registerVillage(paramVillage, user)
        var village = villageService.findVillage(villageId)
        val charas = charachipService.findCharaList(village.setting.charachip.charachipId)
        villageCoordinator.participate(
            villageId = villageId,
            playerId = 2,
            charaId = charas.list[1].id,
            message = "入村しましたよ",
            isSpectate = false
        )
        val first = CDef.Skill.人狼
        val second = CDef.Skill.村人

        // ## Act ##
        villageCoordinator.changeSkillRequest(
            villageId,
            user,
            first.code(),
            second.code()
        )

        // ## Assert ##
        village = villageService.findVillage(villageId)
        val participant = villageCoordinator.findParticipant(village, user)
        assertThat(participant?.skillRequest?.first?.toCdef()).isEqualTo(first)
        assertThat(participant?.skillRequest?.second?.toCdef()).isEqualTo(second)
    }

    @Test
    fun test_leave() {
        // ## Arrange ##
        val paramVillage = createVillageRegisterParam()
        val player = playerBhv.selectByPK(2).get()
        val user = HowlingWolfUser(player.uid, player.authorityCodeAsAuthority)
        val villageId = villageCoordinator.registerVillage(paramVillage, user)
        var village = villageService.findVillage(villageId)
        val charas = charachipService.findCharaList(village.setting.charachip.charachipId)
        villageCoordinator.participate(
            villageId = villageId,
            playerId = 2,
            charaId = charas.list[1].id,
            message = "入村しましたよ",
            isSpectate = false
        )

        // ## Act ##
        villageCoordinator.leave(villageId, user)

        // ## Assert ##
        village = villageService.findVillage(villageId)
        val participant = villageCoordinator.findParticipant(village, user)
        assertThat(participant).isNull()
    }

    @Test
    fun test_confirmToSay() {
        // ## Arrange ##
        val paramVillage = createVillageRegisterParam()
        val player = playerBhv.selectByPK(2).get()
        val user = HowlingWolfUser(player.uid, player.authorityCodeAsAuthority)
        val villageId = villageCoordinator.registerVillage(paramVillage, user)
        val village = villageService.findVillage(villageId)
        val charas = charachipService.findCharaList(village.setting.charachip.charachipId)
        villageCoordinator.participate(
            villageId = villageId,
            playerId = 2,
            charaId = charas.list[1].id,
            message = "入村しましたよ",
            isSpectate = false
        )
        val messageText = "message text"

        // ## Act ##
        // ## Assert ##
        villageCoordinator.confirmToSay(
            villageId,
            user,
            messageText,
            CDef.MessageType.通常発言.code(),
            CDef.FaceType.通常.code()
        )
    }

    @Test
    fun test_say() {
        // ## Arrange ##
        val paramVillage = createVillageRegisterParam()
        val player = playerBhv.selectByPK(2).get()
        val user = HowlingWolfUser(player.uid, player.authorityCodeAsAuthority)
        val villageId = villageCoordinator.registerVillage(paramVillage, user)
        var village = villageService.findVillage(villageId)
        val charas = charachipService.findCharaList(village.setting.charachip.charachipId)
        villageCoordinator.participate(
            villageId = villageId,
            playerId = 2,
            charaId = charas.list[1].id,
            message = "入村しましたよ",
            isSpectate = false
        )
        val messageText = "message text"

        // ## Act ##
        villageCoordinator.say(
            villageId,
            user,
            messageText,
            CDef.MessageType.通常発言.code(),
            CDef.FaceType.通常.code()
        )

        // ## Assert ##
        village = villageService.findVillage(villageId)
        val participant = villageCoordinator.findParticipant(village, user)
        val messages = messageService.findMessages(
            villageId,
            village.day.latestDay().id,
            listOf(CDef.MessageType.通常発言),
            null,
            null
        )
        assertThat(messages.list.any {
            it.fromVillageParticipantId == participant?.id
                && it.content.text == messageText
        }).isTrue()
    }

    @Test
    fun test_setAbility() {
        // ## Arrange ##
        val paramVillage = createVillageRegisterParam()
        val player = playerBhv.selectByPK(2).get()
        val user = HowlingWolfUser(player.uid, player.authorityCodeAsAuthority)
        val villageId = villageCoordinator.registerVillage(paramVillage, user)
        var village = villageService.findVillage(villageId)
        val charas = charachipService.findCharaList(village.setting.charachip.charachipId)
        (2..11).forEach {
            villageCoordinator.participate(
                villageId = villageId,
                playerId = it,
                charaId = charas.list[it].id,
                message = "入村しましたよ",
                firstRequestSkill = if (it == 2) CDef.Skill.占い師 else CDef.Skill.おまかせ,
                isSpectate = false
            )
        }
        village = villageService.findVillage(villageId)
        village = villageService.updateVillageDifference(
            village,
            village.addNewDay().changeStatus(CDef.VillageStatus.進行中).assignSkill()
        )
        val dummy = village.dummyChara()
        val participant = villageCoordinator.findParticipant(village, user)

        // ## Act ##
        villageCoordinator.setAbility(
            villageId,
            user,
            dummy.id,
            CDef.AbilityType.占い.code()
        )

        // ## Assert ##
        val abilities = abilityService.findVillageAbilities(villageId)
        assertThat(abilities.list.any {
            it.ability.toCdef() == CDef.AbilityType.占い
                && it.myselfId == participant?.id
                && it.targetId == village.dummyChara().id
        }).isTrue()
    }

    @Test
    fun test_setVote() {
        // ## Arrange ##
        val paramVillage = createVillageRegisterParam()
        val player = playerBhv.selectByPK(2).get()
        val user = HowlingWolfUser(player.uid, player.authorityCodeAsAuthority)
        val villageId = villageCoordinator.registerVillage(paramVillage, user)
        var village = villageService.findVillage(villageId)
        val charas = charachipService.findCharaList(village.setting.charachip.charachipId)
        (2..11).forEach {
            villageCoordinator.participate(
                villageId = villageId,
                playerId = it,
                charaId = charas.list[it].id,
                message = "入村しましたよ",
                firstRequestSkill = if (it == 2) CDef.Skill.占い師 else CDef.Skill.おまかせ,
                isSpectate = false
            )
        }
        village = villageService.findVillage(villageId)
        village = villageService.updateVillageDifference(
            village,
            village.addNewDay().addNewDay().changeStatus(CDef.VillageStatus.進行中).assignSkill()
        )
        val dummy = village.dummyChara()
        val participant = villageCoordinator.findParticipant(village, user)

        // ## Act ##
        villageCoordinator.setVote(
            villageId, user, dummy.id
        )

        // ## Assert ##
        val votes = voteService.findVillageVotes(villageId)
        assertThat(votes.list.any {
            it.myselfId == participant?.id
                && it.targetId == village.dummyChara().id
        }).isTrue()
    }

    @Test
    fun test_setCommit() {
        // ## Arrange ##
        val paramVillage = createVillageRegisterParam()
        val player = playerBhv.selectByPK(2).get()
        val user = HowlingWolfUser(player.uid, player.authorityCodeAsAuthority)
        val villageId = villageCoordinator.registerVillage(paramVillage, user)
        var village = villageService.findVillage(villageId)
        val charas = charachipService.findCharaList(village.setting.charachip.charachipId)
        (2..11).forEach {
            villageCoordinator.participate(
                villageId = villageId,
                playerId = it,
                charaId = charas.list[it].id,
                message = "入村しましたよ",
                firstRequestSkill = if (it == 2) CDef.Skill.占い師 else CDef.Skill.おまかせ,
                isSpectate = false
            )
        }
        village = villageService.findVillage(villageId)
        village = villageService.updateVillageDifference(
            village,
            village.addNewDay().changeStatus(CDef.VillageStatus.進行中).copy(
                setting = village.setting.copy(
                    rules = village.setting.rules.copy(availableCommit = true)
                )
            )
        )
        val participant = villageCoordinator.findParticipant(village, user)

        // ## Act ##
        villageCoordinator.setCommit(
            villageId, user, true
        )

        // ## Assert ##
        val commits = commitService.findCommits(villageId)
        assertThat(commits.list.any {
            it.myselfId == participant?.id && it.isCommitting
        }).isTrue()
    }

    @Test
    fun test_findActionSituation_エラーが起きないこと() {
        // ## Arrange ##
        val paramVillage = createVillageRegisterParam()
        val player = playerBhv.selectByPK(2).get()
        val user = HowlingWolfUser(player.uid, player.authorityCodeAsAuthority)
        val villageId = villageCoordinator.registerVillage(paramVillage, user)
        var village = villageService.findVillage(villageId)
        val players: Players = playerService.findPlayers(villageId)
        val charas = charachipService.findCharaList(village.setting.charachip.charachipId)

        // ## Act ##
        // ## Assert ##
        villageCoordinator.findActionSituation(village, user, players, charas)

        // ## Arrange ##
        (2..11).forEach {
            villageCoordinator.participate(
                villageId = villageId,
                playerId = it,
                charaId = charas.list[it].id,
                message = "入村しましたよ",
                firstRequestSkill = if (it == 2) CDef.Skill.占い師 else CDef.Skill.おまかせ,
                isSpectate = false
            )
        }

        // ## Act ##
        // ## Assert ##
        villageCoordinator.findActionSituation(village, user, players, charas)

        // ## Arrange ##
        village = villageService.findVillage(villageId)
        village = villageService.updateVillageDifference(
            village,
            village.addNewDay().addNewDay().changeStatus(CDef.VillageStatus.進行中).assignSkill().copy(
                setting = village.setting.copy(
                    rules = village.setting.rules.copy(availableCommit = true)
                )
            )
        )

        // ## Act ##
        // ## Assert ##
        villageCoordinator.findActionSituation(village, user, players, charas)

        // ## Arrange ##
        villageCoordinator.say(
            villageId,
            user,
            "hoge",
            CDef.MessageType.通常発言.code(),
            CDef.FaceType.通常.code()
        )

        // ## Act ##
        // ## Assert ##
        villageCoordinator.findActionSituation(village, user, players, charas)

        // ## Arrange ##
        villageCoordinator.setAbility(
            villageId,
            user,
            village.dummyChara().id,
            CDef.AbilityType.占い.code()
        )

        // ## Act ##
        // ## Assert ##
        villageCoordinator.findActionSituation(village, user, players, charas)

        // ## Arrange ##
        villageCoordinator.setVote(villageId, user, village.dummyChara().id)

        // ## Act ##
        // ## Assert ##
        villageCoordinator.findActionSituation(village, user, players, charas)

        // ## Arrange ##
        villageCoordinator.setCommit(villageId, user, true)

        // ## Act ##
        // ## Assert ##
        villageCoordinator.findActionSituation(village, user, players, charas)
    }

    // ===================================================================================
    //                                                                        Assist Logic
    //                                                                        ============
    private fun createVillageRegisterParam(): Village {
        return Village(
            id = 1, // dummy
            name = "dummy village name",
            creatorPlayerId = 1,
            status = VillageStatus(CDef.VillageStatus.プロローグ),
            setting = createVillageSettingsParam(),
            participant = VillageParticipants(
                count = 1, // dummy
                memberList = listOf()
            ),
            spectator = VillageParticipants(
                count = 0, // dummy
                memberList = listOf() // dummy
            ),
            day = VillageDays(
                dayList = listOf() // dummy
            ),
            winCamp = null
        )
    }

    private fun createVillageSettingsParam(): VillageSettings {
        return VillageSettings(
            capacity = PersonCapacity(
                min = 10,
                max = 16
            ),
            time = VillageTime(
                termType = CDef.Term.長期.code(),
                startDatetime = LocalDateTime.now(),
                dayChangeIntervalSeconds = 86400
            ),
            charachip = VillageCharachip(
                dummyCharaId = 1,
                charachipId = 1
            ),
            organizations = VillageOrganizations(),
            rules = VillageRules(
                openVote = false,
                availableSkillRequest = true,
                availableSpectate = false,
                openSkillInGrave = false,
                visibleGraveMessage = false,
                availableSuddenlyDeath = true,
                availableCommit = false,
                messageRestrict = VillageMessageRestricts()
            ),
            password = VillagePassword(
                joinPasswordRequired = false,
                joinPassword = null
            )
        )
    }
}