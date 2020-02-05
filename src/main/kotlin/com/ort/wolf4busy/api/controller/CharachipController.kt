package com.ort.wolf4busy.api.controller

import com.ort.wolf4busy.api.view.charachip.CharachipView
import com.ort.wolf4busy.api.view.charachip.CharachipsView
import com.ort.wolf4busy.application.service.CharachipService
import com.ort.wolf4busy.domain.model.charachip.Chara
import com.ort.wolf4busy.domain.model.charachip.Charachip
import com.ort.wolf4busy.domain.model.charachip.Charachips
import com.ort.wolf4busy.domain.model.charachip.Charas
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RestController

@RestController
class CharachipController(
    val charachipService: CharachipService
) {

    // ===================================================================================
    //                                                                             Execute
    //                                                                           =========
    @GetMapping("/charachip/list")
    fun charachipList(): CharachipsView {
        val charachips: Charachips = charachipService.findCharaChipList()
        val charas: Charas = charachipService.findCharaList(charachips)
        return CharachipsView(
            charachips = charachips,
            charas = charas
        )
    }

    @GetMapping("/charachip/{charaChipId}")
    fun charachip(@PathVariable("charaChipId") charaChipId: Int): CharachipView {
        val charachip: Charachip = charachipService.findCharaChip(charaChipId)
        val charas: Charas = charachipService.findCharaList(charachip.id)
        return CharachipView(
            charachip = charachip,
            charas = charas
        )
    }

    @GetMapping("/chara/{charaId}")
    fun chara(@PathVariable("charaId") charaId: Int): Chara {
        return charachipService.findChara(charaId)
    }

    @GetMapping("/charachip/{charaChipId}/dummychara")
    fun dummyChara(@PathVariable("charaChipId") charaChipId: Int): Chara {
        return charachipService.findDummyChara(charaChipId)
    }
}
