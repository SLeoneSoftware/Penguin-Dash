//
//  ViewController.swift
//  Penguin Dash
//
//  Created by Steven Leone on 7/6/18.
//  Copyright © 2018 Steven Leone. All rights reserved.
//
import UIKit
import AudioToolbox

class ViewController: UIViewController {

    //IB Outlet for UI
    @IBOutlet weak var seal1: UIImageView!
    @IBOutlet weak var seal2: UIImageView!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var btnJump: UIButton!
    @IBOutlet weak var totalLives: UILabel!
    @IBOutlet weak var lblgameOver: UIImageView!
    @IBOutlet weak var lblScore: UILabel!
    
    //Timer Variables
    var timer = Timer()
    var counter = 0
    var sealOneFalling = false
    var sealTwoFalling = false
    var gameStarted = false
    
    //Jumping Variables
    var jump = false
    var avatarVelocity = 30
    var gravity = -5
    var xOriginal = 0.00
    
    //Collision Variables
    var lives = 3
    var sealOnePosition = 0
    var sealTwoPosition = 0
    
    //Score
    var score = 0
    
    //Save Data
    let highScore = "highScore"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Avatar.center.y = view.frame.height - 220
        snowSnowFlakes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnStartPressed(_ sender: Any) {
        if gameStarted == false{
            totalLives.text = String(lives)
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: (#selector(ViewController.runFrame)), userInfo:nil, repeats: true)
            gameStarted = true
            score = 0
        }
        btnStart.isHidden = true
        lblgameOver.isHidden = true
        //Hiding Seals
        seal1.isHidden = true
        seal2.isHidden = true
    }
    @objc func runFrame(){
        score += 1
        lblScore.text = String(score)
        //Seal Falls
        let sealFall = arc4random_uniform(200)
        //Seal One
        if sealFall < 20{
            sealOneFalling = true
            seal1.isHidden = false
        }
        if sealOneFalling == true{
              UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                self.seal1.center.y += 15
                self.sealOnePosition = Int(self.seal1.center.x)
              });
        }
        //Collision into Avatar Seal One
        if (seal1.self.center.y > view.frame.height - 250) && (seal1.self.center.y < view.frame.height - 190){
            if sealOnePosition - Int(self.Avatar.center.x) < 20 {
                lives -= 1
                sealOneFalling = false
                seal1.isHidden = true
                seal1.self.center.y = 0
                seal1.isHidden = false
                totalLives.text = String(lives)
              AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                if lives == 0{
                    //Ending Game
                    gameStarted = false
                    timer.invalidate()
                    lblgameOver.isHidden = false
                    btnStart.isHidden = false
                    lives = 3
                //Hiding Seals at the Game Over
                    seal1.isHidden = true
                    seal2.isHidden = true
                    seal2.self.center.y = 0
                }
            }
        }
        if seal1.self.center.y > view.frame.height - 40 {
            sealOneFalling = false
            seal1.isHidden = true
            seal1.self.center.y = 0
        }
        //Seal Two
        if sealFall > 180 {
            if abs(seal1.center.y - seal2.center.y) > 50 {
                sealTwoFalling = true
                seal2.isHidden = false
            }
        }
        
        if sealTwoFalling == true{
            
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                    self.seal2.center.y += 15
                    self.sealTwoPosition = Int(self.seal2.center.x)
                });
        }
        //Collision into Avatar Seal Two
        if (seal2.self.center.y > view.frame.height - 250) && (seal2.self.center.y < view.frame.height - 170){
            if sealTwoPosition - Int(self.Avatar.center.x) > 12 {
                lives -= 1
                sealTwoFalling = false
                seal2.isHidden = true
                seal2.self.center.y = 0
                seal2.isHidden = false
                totalLives.text = String(lives)
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                if lives == 0{
                    gameStarted = false
                    timer.invalidate()
                    lblgameOver.isHidden = false
                    btnStart.isHidden = false
                    lives = 3
                    //Hiding Seals at the Game Over
                    seal1.isHidden = true
                    seal2.isHidden = true
                    seal1.self.center.y = 0
                }
            }
        }
        if seal2.self.center.y > view.frame.height - 40{
            sealTwoFalling = false
            seal2.isHidden = true
            seal2.self.center.y = 0
        }
        //Jumping Mechanics
        if jump == true{
            avatarVelocity += gravity
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                self.Avatar.center.x -= CGFloat(self.avatarVelocity)
            });
            if Avatar.center.x > CGFloat(self.xOriginal){
                jump = false
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                    self.Avatar.center.x = CGFloat(self.xOriginal)
                });
                avatarVelocity = 35
            }
        }
    }
    
    func snowSnowFlakes() {
        let emitter = Emitter.get(with: #imageLiteral(resourceName: "snowflake-1"), with: (.pi/16))
        emitter.emitterPosition = CGPoint(x: view.frame.width/4, y: 0)
        emitter.emitterSize = CGSize(width: view.frame.width/4, height: 2)
        view.layer.addSublayer(emitter)
    }
    
    func bubbles() {
        let emitter = Emitter.get(with: #imageLiteral(resourceName: "bubble"), with: (.pi/16))
        emitter.emitterPosition = CGPoint(x: 3 * view.frame.width/4, y: 0)
        emitter.emitterSize = CGSize(width: view.frame.width/4, height: 2)
        view.layer.addSublayer(emitter)
    }
    
    @IBAction func btnJumpClicked(_ sender: Any) {
        if jump == false{
            xOriginal = Double(CGFloat(self.Avatar.center.x))
            jump = true
        }
    }
}

