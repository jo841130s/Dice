//
//  ViewController.swift
//  Dice
//
//  Created by 黃冠中 on 2019/12/15.
//  Copyright © 2019 黃冠中. All rights reserved.
//

import UIKit
import AudioToolbox
import AVKit

class ViewController: UIViewController, AdbertADBannerDelegate {
    
    var timer : Timer?
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var diceView: UIView!
    @IBOutlet weak var diceImageView: UIImageView!
    @IBOutlet weak var upLabel: UILabel!
    @IBOutlet weak var doenLabel: UILabel!
    var blackView = UIView()
    var banner : AdbertADBanner!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        diceView.layer.borderWidth = 10
        diceView.layer.borderColor = UIColor.black.cgColor
        diceView.layer.cornerRadius = 20
        view.backgroundColor = UIColor.gray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        changeBackgroundColor()
        diceImageView.image = UIImage(named: "1")
        diceImageView.clipsToBounds = true
        diceImageView.layer.cornerRadius = 20
        banner = AdbertADBanner(appid: "ad-adb-18e46e12d521", andAPPKEY: "a961268138235")
        banner.delegate = self
        banner.fullScreenBanner = false
        banner.adSize = CGSize(width: 320, height: 50)
        banner.frame = CGRect(x:0, y:0, width:320, height:50)
        banner.requestAD()
    }
    
    func changeBackgroundColor() {
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: (#selector(getRandomColor)), userInfo: nil, repeats: true)
    }
    
    @objc func getRandomColor() {
        let red   = CGFloat((arc4random() % 256)) / 255.0
        let green = CGFloat((arc4random() % 256)) / 255.0
        let blue  = CGFloat((arc4random() % 256)) / 255.0
        let alpha = CGFloat(0.3)

        UIView.animate(withDuration: 5.0, delay: 0.0, options:[.repeat, .autoreverse], animations: {
            self.view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }, completion:nil)
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            rollingAnimation()
            let number = Int.random(in: 1 ..< 7)
            diceLayout(number: number)
        }
    }
    
    func rollingAnimation() {
        blackView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        blackView.tag = 123
        blackView.backgroundColor = UIColor.black
        playDiceVideoin(videoView: blackView)
        view.addSubview(blackView)
    }
    
    func playDiceVideoin(videoView: UIView) {
        let videoURL: NSURL = Bundle.main.url(forResource: "Dice", withExtension: "mp4")! as NSURL
        let player = AVPlayer(url: videoURL as URL)
        let playerLayer = AVPlayerLayer(player: player)
        NotificationCenter.default.addObserver(self, selector: #selector(playFinish),
        name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        playerLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        videoView.layer.addSublayer(playerLayer)
        player.play()
    }
    
    @objc func playFinish() {
        view.viewWithTag(123)?.removeFromSuperview()
    }
    
    func diceLayout(number:Int) {
        diceImageView.image = UIImage(named:"\(number)")
    }
    
    func adbertADViewDidReceiveAd(_ banner: AdbertADBanner!) {
         print("receive")
     }
    
     func adbertADView(_ banner: AdbertADBanner!, didFailToReceiveAdWithError error: Error!) {
         print("Adbert Ad did fail to receive")
     }
    
     func adbertADViewDidClicked(_ banner: AdbertADBanner!) {
         print("Adbert Ad did clicked")
     }
    
}

