//
//  UIView + Border.swift
//  Snacktacular
//
//  Created by Kyle Gangi on 4/15/20.
//  Copyright © 2020 John Gallaugher. All rights reserved.
//

import UIKit
import Foundation


extension UIView{
    
    func addBorder(width: CGFloat, radius: CGFloat, color: UIColor){
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = radius
    }
    
    func noBorder(){
        self.layer.borderWidth = 0.0
        
    }
    
}
