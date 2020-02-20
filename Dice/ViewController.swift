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
    
    @IBOutlet weak var diceView1: UIView!
    @IBOutlet weak var diceView2: UIView!
    @IBOutlet weak var diceView3: UIView!
    @IBOutlet weak var diceView4: UIView!
    @IBOutlet weak var diceView5: UIView!
    @IBOutlet weak var dice1: UIImageView!
    @IBOutlet weak var dice2: UIImageView!
    @IBOutlet weak var dice3: UIImageView!
    @IBOutlet weak var dice4: UIImageView!
    @IBOutlet weak var dice5: UIImageView!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var upLabel: UILabel!
    @IBOutlet weak var bannerView: UIView!
    var blackView = UIView()
    var banner : AdbertADBanner!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        diceView1.layer.borderWidth = 10
        diceView1.layer.borderColor = UIColor.black.cgColor
        diceView1.layer.cornerRadius = 20
        diceView1.isHidden = true
        diceView2.layer.borderWidth = 10
        diceView2.layer.borderColor = UIColor.black.cgColor
        diceView2.layer.cornerRadius = 20
        diceView2.isHidden = true
        diceView3.layer.borderWidth = 10
        diceView3.layer.borderColor = UIColor.black.cgColor
        diceView3.layer.cornerRadius = 20
        diceView4.layer.borderWidth = 10
        diceView4.layer.borderColor = UIColor.black.cgColor
        diceView4.layer.cornerRadius = 20
        diceView4.isHidden = true
        diceView5.layer.borderWidth = 10
        diceView5.layer.borderColor = UIColor.black.cgColor
        diceView5.layer.cornerRadius = 20
        diceView5.isHidden = true
        view.backgroundColor = UIColor.gray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = getRandomColor()
        dice1.clipsToBounds = true
        dice1.layer.cornerRadius = 20
        dice2.clipsToBounds = true
        dice2.layer.cornerRadius = 20
        dice3.clipsToBounds = true
        dice3.layer.cornerRadius = 20
        dice4.clipsToBounds = true
        dice4.layer.cornerRadius = 20
        dice5.clipsToBounds = true
        dice5.layer.cornerRadius = 20
        banner = AdbertADBanner(appid: "ad-adb-18e46e12d521", andAPPKEY: "a961268138235")
        banner.delegate = self
        banner.fullScreenBanner = false
        banner.adSize = CGSize(width: 320, height: 50)
        banner.frame = CGRect(x:(UIScreen.main.bounds.width - banner.adSize.width)/2, y:0, width:320, height:50)
        banner.requestAD()
    }
    
    
    
    func getRandomColor() -> UIColor {
        let red   = CGFloat((arc4random() % 256)) / 255.0
        let green = CGFloat((arc4random() % 256)) / 255.0
        let blue  = CGFloat((arc4random() % 256)) / 255.0
        let alpha = CGFloat(0.3)
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            rollingAnimation()
            let number1 = Int.random(in: 1 ..< 7)
            let number2 = Int.random(in: 1 ..< 7)
            let number3 = Int.random(in: 1 ..< 7)
            let number4 = Int.random(in: 1 ..< 7)
            let number5 = Int.random(in: 1 ..< 7)
            diceLayout(number: number1, dice: dice1)
            diceLayout(number: number2, dice: dice2)
            diceLayout(number: number3, dice: dice3)
            diceLayout(number: number4, dice: dice4)
            diceLayout(number: number5, dice: dice5)
            view.backgroundColor = getRandomColor()
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
    
    func diceLayout(number:Int,dice:UIImageView) {
        dice.image = UIImage(named:"\(number)")
    }
    
    func adbertADViewDidReceiveAd(_ banner: AdbertADBanner!) {
        print("receive")
        bannerView.addSubview(banner)
        banner.showAD()
        
     }
    
     func adbertADView(_ banner: AdbertADBanner!, didFailToReceiveAdWithError error: Error!) {
        print("Adbert Ad did fail to receive")
     }
    
     func adbertADViewDidClicked(_ banner: AdbertADBanner!) {
        print("Adbert Ad did clicked")
     }
    
    @IBAction func diceNumberControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            diceView1.isHidden = true
            diceView2.isHidden = true
            diceView3.isHidden = false
            diceView4.isHidden = true
            diceView5.isHidden = true
        } else if sender.selectedSegmentIndex == 1 {
            diceView1.isHidden = false
            diceView2.isHidden = true
            diceView3.isHidden = true
            diceView4.isHidden = true
            diceView5.isHidden = false
        } else if sender.selectedSegmentIndex == 2 {
            diceView1.isHidden = false
            diceView2.isHidden = true
            diceView3.isHidden = false
            diceView4.isHidden = true
            diceView5.isHidden = false
        } else if sender.selectedSegmentIndex == 3 {
            diceView1.isHidden = false
            diceView2.isHidden = false
            diceView3.isHidden = true
            diceView4.isHidden = false
            diceView5.isHidden = false
        } else if sender.selectedSegmentIndex == 4 {
            diceView1.isHidden = false
            diceView2.isHidden = false
            diceView3.isHidden = false
            diceView4.isHidden = false
            diceView5.isHidden = false
        }
    }
}

