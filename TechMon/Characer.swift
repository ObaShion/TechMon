//
//  Characer.swift
//  TechMon
//
//  Created by 大場史温 on 2024/08/25.
//

import AVFoundation
import UIKit

class Character {
    var name: String
    var image: UIImage
    var currentHP: Int
    var maxHP: Int
    var currentMP: Int
    var maxMP: Int
    var normalAttackPower: Int
    var specialAttackPower: Int
    var normalAttackSEPlayer: AVAudioPlayer
    var specialAttackSEPlayer: AVAudioPlayer
    
    init(name: String, imageName: String, currentHP: Int, maxHP: Int, currentMP: Int, maxMP: Int, normalAttackPower: Int, specialAttackPower: Int, normalAttackSEName: String, specialAttackSEName: String) {
        self.name = name
        self.image = UIImage(named: imageName)!
        self.currentHP = currentHP
        self.maxHP = maxHP
        self.currentMP = currentMP
        self.maxMP = maxMP
        self.normalAttackPower = normalAttackPower
        self.specialAttackPower = specialAttackPower
        self.normalAttackSEPlayer = try! AVAudioPlayer(data: NSDataAsset(name: normalAttackSEName)!.data)
        self.specialAttackSEPlayer = try! AVAudioPlayer(data: NSDataAsset(name: specialAttackSEName)!.data)
    }
    
    func playNormalAttackSE() {
        normalAttackSEPlayer.currentTime = 0
        normalAttackSEPlayer.play()
    }
    
    func playSpecialAttackSE() {
        specialAttackSEPlayer.currentTime = 0
        specialAttackSEPlayer.play()
    }
    
    func isDefeated() -> Bool {
        if self.currentHP <= 0 {
            return true
        } else {
            return false
        }
    }
    
}
