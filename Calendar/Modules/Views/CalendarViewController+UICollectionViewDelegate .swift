//
//  CalendarViewController+UICollectionViewDelegate .swift
//  test
//
//  Created by Aya Mashaly on 12/04/2025.
//

import Foundation
import UIKit

extension CalendarViewController: UICollectionViewDataSource, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! DayCell
            
            let dayIndex = indexPath.item
            var day: Int = 0
            var isInCurrentMonth: Bool = false
            var isSelected: Bool = false
            
            if dayIndex < firstDayWeekday {
                day = previousMonthDays - firstDayWeekday + dayIndex + 1
                isInCurrentMonth = false
            } else if dayIndex < firstDayWeekday + numberOfDaysInMonth {
                day = dayIndex - firstDayWeekday + 1
                isInCurrentMonth = true
                let currentDateComponents = calendar.dateComponents([.month, .year], from: Date())
                let isCurrentMonthAndYear = (currentMonth == currentDateComponents.month && currentYear == currentDateComponents.year)
                isSelected = isCurrentMonthAndYear && (day == today)
            } else {
                day = dayIndex - firstDayWeekday - numberOfDaysInMonth + 1
                isInCurrentMonth = false
            }
            
            cell.configure(day: day, isSelected: isSelected, isInCurrentMonth: isInCurrentMonth)
            return cell
        }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "DayHeader", for: indexPath)
           
            let stackView = UIStackView(frame: headerView.bounds)
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = 0
            headerView.addSubview(stackView)
            
            let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
            for day in days {
                let label = UILabel()
                label.text = day
                label.textAlignment = .center
                label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
                label.textColor = .gray
                stackView.addArrangedSubview(label)
            }
            
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
}
