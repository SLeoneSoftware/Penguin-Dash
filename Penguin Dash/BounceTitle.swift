//
//  BounceTitle.swift
//  Penguin Dash
//
//  Created by Steven Leone on 10/21/18.
//  Copyright © 2018 Steven Leone. All rights reserved.
//

import UIKit


class BounceTitle: UILabel {
    

    
    
    func Bounce() {

        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
            self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.transform = CGAffineTransform.identity
        }, completion: nil)
        
    }
    
}
