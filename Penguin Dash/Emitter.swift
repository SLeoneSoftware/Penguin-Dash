//
//  Emitter.swift
//  Penguin Dash
//
//  Created by Steven Leone on 9/27/18.
//  Copyright © 2018 Steven Leone. All rights reserved.
//

import UIKit

class Emitter {
    static func get(with image: UIImage, with range: Double) -> CAEmitterLayer{
        let emitter = CAEmitterLayer()
        emitter.emitterShape = kCAEmitterLayerLine
        emitter.emitterCells = generateEmitterCells(with: image, with: range)
        
        
        return emitter
    }
    
    static func generateEmitterCells(with image: UIImage, with range: Double) -> [CAEmitterCell] {
        var cells = [CAEmitterCell]()
        let cell = CAEmitterCell()
        cell.contents = image.cgImage
        cell.birthRate = 1
        cell.lifetime = 50
        cell.velocity = CGFloat(25)
        cell.emissionRange = CGFloat(range)
        cell.emissionLongitude = (.pi)
        cell.scale = 0.05
        cell.scaleRange = 0.025
        cells.append(cell)
        return cells
    }
}
