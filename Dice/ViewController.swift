//
//  ViewController.swift
//  Dice
//
//  Created by 黃冠中 on 2019/12/15.
//  Copyright © 2019 黃冠中. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer : Timer?
    @IBOutlet weak var numberOfDice: UISegmentedControl!
    @IBOutlet weak var centerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        changeBackgroundColor()
    }
    
    @IBAction func numberOfDice(_ sender: UISegmentedControl) {
        diceLayout(number: sender.numberOfSegments)
    }
    
    func changeBackgroundColor() {
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: (#selector(getRandomColor)), userInfo: nil, repeats: true)
    }
    
    @objc func getRandomColor() {
        let red   = CGFloat((arc4random() % 256)) / 255.0
        let green = CGFloat((arc4random() % 256)) / 255.0
        let blue  = CGFloat((arc4random() % 256)) / 255.0
        let alpha = CGFloat(1.0)

        UIView.animate(withDuration: 5.0, delay: 0.0, options:[.repeat, .autoreverse], animations: {
            self.view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }, completion:nil)
    }
    
    func diceLayout(number:Int) {
        if number == 0 {
            
        } else if number == 1 {
            
        } else if number == 2 {
                   
        } else if number == 3 {
                   
        } else if number == 4 {
                   
        } else if number == 5 {
                   
        }
    }
    
    
}

