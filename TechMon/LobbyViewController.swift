//
//  LobbyViewController.swift
//  TechMon
//
//  Created by 大場史温 on 2024/08/25.
//

import UIKit
import AVFoundation

class LobbyViewController: UIViewController {
    
    let bgmPlayer = try! AVAudioPlayer(data: NSDataAsset(name: "bgm_lobby")!.data)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bgmPlayer.currentTime = 0
        bgmPlayer.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        bgmPlayer.stop()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
