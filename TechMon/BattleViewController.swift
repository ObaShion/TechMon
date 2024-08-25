//
//  BattleViewController.swift
//  TechMon
//
//  Created by 大場史温 on 2024/08/25.
//

import UIKit
import AVFoundation

class BattleViewController: UIViewController {
    
    @IBOutlet var playerNameLabel: UILabel!
    @IBOutlet var playerImageView: UIImageView!
    @IBOutlet var playerHPBar: UIProgressView!
    @IBOutlet var playerMPLabel: UILabel!
    
    @IBOutlet var enemyNameLabel: UILabel!
    @IBOutlet var enemyImageView: UIImageView!
    @IBOutlet var enemyHPBar: UIProgressView!
    
    let bgmPlayer = try! AVAudioPlayer(data: NSDataAsset(name: "bgm_battle")!.data)
    let victorySEPlayer = try! AVAudioPlayer(data: NSDataAsset(name: "fanfare")!.data)
    let gameoverSEPlayer = try! AVAudioPlayer(data: NSDataAsset(name: "gameover")!.data)
    
    var player: Character!
    var enemy: Character!
    
    var enemyAttackTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        player = Character(name: "勇者", imageName: "yusha", currentHP: 100, maxHP: 100, currentMP: 5, maxMP: 5, normalAttackPower: 20, specialAttackPower: 60, normalAttackSEName: "attack_normal", specialAttackSEName: "attack_special")
        
        enemy = Character(name: "ヴァンパイア", imageName: "vampire", currentHP: 300, maxHP: 300, currentMP: 0, maxMP: 0, normalAttackPower: 10, specialAttackPower: 0, normalAttackSEName: "enemy_attack", specialAttackSEName: "enemy_attack")
        
        playerNameLabel.text = player.name
        playerImageView.image = player.image
        enemyNameLabel.text = enemy.name
        enemyImageView.image = enemy.image
        
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bgmPlayer.currentTime = 0
        bgmPlayer.play()
        
        enemyAttackTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(enemyAttack), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        bgmPlayer.stop()
    }
    
    @objc func enemyAttack() {
        player.currentHP -= enemy.normalAttackPower
        if player.currentMP != player.maxMP {
            player.currentMP += 1
        }
        updateUI()
        
        damageAnimation(view: playerImageView)
        
        enemy.playNormalAttackSE()
        
        if player.isDefeated() {
            bgmPlayer.stop()
            finishBattle(isVictory: false)
        }
    }
    
    func finishBattle(isVictory: Bool) {
        enemyAttackTimer.invalidate()
        bgmPlayer.stop()
        
        var message: String!
        
        if isVictory {
            message = "勇者の勝利!"
            victorySEPlayer.currentTime = 0
            victorySEPlayer.play()
        } else {
            message = "勇者の敗北"
            gameoverSEPlayer.currentTime = 0
            gameoverSEPlayer.play()
        }
        
        let alert = UIAlertController(title: "バトル終了!", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { UIAlertAction in
            self.dismiss(animated: true)
        }))
        present(alert, animated: true)
        
    }
    
    func updateUI() {
        playerHPBar.progress = Float(player.currentHP) / Float(player.maxHP)
        playerMPLabel.text = "\(player.currentMP) / \(player.maxMP)"
        enemyHPBar.progress = Float(enemy.currentHP) / Float(enemy.maxHP)
    }
    
    func attack(damage: Int) {
        enemy.currentHP -= damage
        updateUI()
        
        damageAnimation(view: enemyImageView)
        
        if enemy.isDefeated() {
            finishBattle(isVictory: true)
        }
    }
    
    @IBAction func normalAttack() {
        attack(damage: player.normalAttackPower)
        player.playNormalAttackSE()
        player.currentHP = min(player.currentHP + 1, player.maxHP)
    }
    
    @IBAction func specialAttack() {
        if player.currentMP == player.maxMP {
            attack(damage: player.specialAttackPower)
            player.playSpecialAttackSE()
            player.currentMP = 0
        }
    }
    
    func damageAnimation(view: UIView) {
        UIView.animate(withDuration: 0.1, delay: 0.0, animations: {
            view.alpha = 0
            view.center.x -= 5
        }) { _ in
            view.alpha = 100
            view.center.x += 5
        }
    }
    
}
