//
//  ViewController.swift
//  Dice
//
//  Created by 黃冠中 on 2019/12/15.
//  Copyright © 2019 黃冠中. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController, AdbertADBannerDelegate, GADBannerViewDelegate{
    
    var timer : Timer?
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var diceView: UIView!
    let diceImageView = UIImageView()
    var banner : AdbertADBanner!
    var bannerView: GADBannerView!
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var adViewUp: UIView!
    @IBOutlet weak var upLabel: UILabel!
    @IBOutlet weak var doenLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        diceView.layer.borderWidth = 10
        diceView.layer.borderColor = UIColor.black.cgColor
        diceView.layer.cornerRadius = 20
        banner = AdbertADBanner.init(appid: "ad-adb-1c8bc3c1d521", andAPPKEY: "a961268138235")
        banner.frame = CGRect(x: 0, y: 0, width:adView.bounds.width, height:adView.bounds.height)
        banner.delegate = self
        banner.requestAD()
        view.backgroundColor = UIColor.gray
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        adViewUp.addSubview(bannerView)
        bannerView.load(GADRequest())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        changeBackgroundColor()
        diceImageView.frame.size = diceView.frame.size
        diceImageView.frame.origin = CGPoint(x: 0, y: 0)
        diceImageView.image = UIImage(named: "1")
        diceImageView.clipsToBounds = true
        diceImageView.layer.cornerRadius = 20
        diceView.addSubview(diceImageView)
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
            let number = Int.random(in: 1 ..< 7)
            diceLayout(number: number)
        }
    }
    
    func diceLayout(number:Int) {
        diceImageView.image = UIImage(named:"\(number)")
    }
    
    func adbertADViewDidReceiveAd(_ banner: AdbertADBanner!) {
        adView.addSubview(banner)
        banner.showAD()
    }
    
    func adbertADView(_ banner: AdbertADBanner!, didFailToReceiveAdWithError error: Error!) {
        print("adbert ad receive fail")
    }
    
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("adViewDidReceiveAd")
    }

    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
        didFailToReceiveAdWithError error: GADRequestError) {
      print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("adViewWillPresentScreen")
    }

    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("adViewWillDismissScreen")
    }

    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("adViewDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
      print("adViewWillLeaveApplication")
    }
}

