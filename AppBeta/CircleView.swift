//
//  CircleView.swift
//  AppBeta
//
//  Created by Khoi Nguyen on 8/25/16.
//  Copyright © 2016 Khoi Nguyen. All rights reserved.
//

import UIKit

class CircleView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: Shadow_Gray , green: Shadow_Gray, blue: Shadow_Gray, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
      
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true

    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = self.frame.width / 2
    }

}
