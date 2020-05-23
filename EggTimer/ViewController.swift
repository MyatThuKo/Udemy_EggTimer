//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var player: AVAudioPlayer!
    let eggsHardness = ["Soft": 300, "Medium": 420, "Hard": 720]
    var totalTime = 0
    var timesPassed = 0
    
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        totalTime = eggsHardness[hardness]!
        progressBar.progress = 0.0
        timesPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(upDateTime), userInfo: nil, repeats: true)
    }
    
    @objc func upDateTime() {
        if timesPassed < totalTime {
            timesPassed += 1
            
            let percentageProgress = Float(timesPassed) / Float(totalTime)
            print(percentageProgress)
            progressBar.progress = percentageProgress
        } else {
            timer.invalidate()
            titleLabel.text = "It's done!"
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
}
