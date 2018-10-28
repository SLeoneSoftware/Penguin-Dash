//
//  TitleViewController.swift
//  Penguin Dash
//
//  Created by Steven Leone on 9/21/18.
//  Copyright © 2018 Steven Leone. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController {

    @IBOutlet weak var lblTitleTwo: BounceTitle!
    @IBOutlet weak var lblTitleOne: BounceTitle!
    @IBOutlet weak var playButton: UIButton!
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        snowSnowflakes()
  
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            self.lblTitleOne.center.x = ( self.view.frame.width / 2 ) - 75
            self.lblTitleTwo.center.x = ( self.view.frame.width / 2 ) + 75
        });
        lblTitleOne.Bounce()
        lblTitleTwo.Bounce()
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: (#selector(ViewController.runFrame)), userInfo:nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func snowSnowflakes() {
        
        let emitter = Emitter.get(with: #imageLiteral(resourceName: "snowflake-1"), with: (.pi/4))
        emitter.emitterPosition = CGPoint(x: view.frame.width/2, y: 0)
        emitter.emitterSize = CGSize(width: view.frame.width, height: 2)
        view.layer.addSublayer(emitter)
    }
    
    @objc func runFrame(){
            lblTitleOne.Bounce()
            lblTitleTwo.Bounce()
    }
}
