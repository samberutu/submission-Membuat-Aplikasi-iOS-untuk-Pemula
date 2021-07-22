//
//  DinamicLabelSize.swift
//  RestaurantApp
//
//  Created by Samlo Berutu on 08/07/21.
//

import UIKit

class DinamicLabelSize {
    
    static func getMaxHeight(text : String?, width : CGFloat) -> CGFloat{
        
        var currentHeight : CGFloat
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        
        label.text = text
        label.numberOfLines = 0
        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        
        currentHeight = label.frame.height
        label.removeFromSuperview()
        
        return currentHeight
    }
}
