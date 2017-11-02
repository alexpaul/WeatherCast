//
//  WeatherCell.swift
//  WeatherCast
//
//  Created by Alex Paul on 11/1/17.
//  Copyright © 2017 Alex Paul. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "WeatherCell")
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed("WeatherCell", owner: self, options: nil)
        contentView.addSubview(containerView)
        containerView.backgroundColor = UIColor(red: 0.000, green: 0.671, blue: 0.867, alpha: 1.00)
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    

}
