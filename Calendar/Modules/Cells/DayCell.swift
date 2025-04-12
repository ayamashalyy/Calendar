//
//  DayCell.swift
//  test
//
//  Created by Aya Mashaly on 12/04/2025.
//

import UIKit

class DayCell: UICollectionViewCell {
    
    @IBOutlet weak var outerView: UIView?
    @IBOutlet weak var dayLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        outerView?.layer.cornerRadius = 15
        outerView?.clipsToBounds = true
    }
    
    func configure(day: Int, isSelected: Bool, isInCurrentMonth: Bool) {
        dayLabel?.text = "\(day)"
        
        if isSelected {
            outerView?.backgroundColor = .orange
            dayLabel?.textColor = .white
        } else {
            outerView?.backgroundColor = .clear
            if isInCurrentMonth {
                dayLabel?.textColor = .black
            } else {
                dayLabel?.textColor = .gray
            }
        }
    }
}
