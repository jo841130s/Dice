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
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport

class ViewController: UIViewController, GADFullScreenContentDelegate {

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
    @IBOutlet var rollButton: UIButton!
    
    var interstitial : GADInterstitialAd?
    
    var blackView = UIView()
    var rollDiceTimes = 0
    var colorCount = 0
    let colors = ["F8AC99","FBAE50","FCD418","81CCB5","82C2EB","CCB7D9","928CC4"]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rollButton.layer.cornerRadius = 10
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                self.loadInterstitial()
            })
        } else {
            loadInterstitial()
        }
        dice1.isHidden = true
        dice2.isHidden = true
        dice4.isHidden = true
        dice5.isHidden = true
        view.backgroundColor = getRandomColor()
        diceImageSetup(image: dice1)
        diceImageSetup(image: dice2)
        diceImageSetup(image: dice3)
        diceImageSetup(image: dice4)
        diceImageSetup(image: dice5)
    }
    
    func loadInterstitial() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-4893868639954563/1279400530",
                                    request: request,
                          completionHandler: { [self] ad, error in
            if let error = error {
              print("Failed to load interstitial ad with error: \(error.localizedDescription)")
              return
            }
            interstitial = ad
            interstitial?.fullScreenContentDelegate = self
            interstitial?.present(fromRootViewController: self)
          }
        )
    }
    
    @IBAction func rollButtonPressed(_ sender: Any) {
        rollDice()
    }
    
    func getRandomColor() -> UIColor {
        if colorCount > 6 {
            colorCount = 0
        }
        return hexStringToUIColor(hex: colors[colorCount])
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            rollDice()
        }
    }
    
    func rollDice() {
        if rollDiceTimes >= Int.random(in: 5...8) {
            rollDiceTimes = 0
            loadInterstitial()
        }
        rollDiceTimes += 1
        colorCount += 1
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
//        rollingAnimation()
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
    
    @IBAction func diceNumberControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            dice1.isHidden = true
            dice2.isHidden = true
            dice3.isHidden = false
            dice4.isHidden = true
            dice5.isHidden = true
        } else if sender.selectedSegmentIndex == 1 {
            dice1.isHidden = false
            dice2.isHidden = true
            dice3.isHidden = true
            dice4.isHidden = true
            dice5.isHidden = false
        } else if sender.selectedSegmentIndex == 2 {
            dice1.isHidden = false
            dice2.isHidden = true
            dice3.isHidden = false
            dice4.isHidden = true
            dice5.isHidden = false
        } else if sender.selectedSegmentIndex == 3 {
            dice1.isHidden = false
            dice2.isHidden = false
            dice3.isHidden = true
            dice4.isHidden = false
            dice5.isHidden = false
        } else if sender.selectedSegmentIndex == 4 {
            dice1.isHidden = false
            dice2.isHidden = false
            dice3.isHidden = false
            dice4.isHidden = false
            dice5.isHidden = false
        }
    }
    
    func diceViewSetup(view:UIView) {
        view.layer.borderWidth = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 20
    }
    
    func diceImageSetup(image:UIImageView) {
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
    }
    
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
    }

    /// Tells the delegate that the ad presented full screen content.
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did present full screen content.")
    }

    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
    }
    
}

