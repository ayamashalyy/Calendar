//
//  CalendarViewController.swift
//  test
//
//  Created by Aya Mashaly on 12/04/2025.
//

import UIKit

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var calendarView: UIView?
    @IBOutlet weak var arrowLeftView: UIView?
    @IBOutlet weak var arrowRightView: UIView?
    @IBOutlet weak var previousButton: UIButton?
    @IBOutlet weak var nextButton: UIButton?
    @IBOutlet weak var monthLabel: UILabel?
    @IBOutlet weak var yearLabel: UILabel?
    @IBOutlet weak var collectionView: UICollectionView?
    
    var currentDate = Date()
    var calendar = Calendar.current
    var currentMonth: Int = 0
    var currentYear: Int = 0
    var firstDayOfMonth: Date?
    var numberOfDaysInMonth: Int = 0
    var firstDayWeekday: Int = 0
    var previousMonthDays: Int = 0
    var today: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setupCollectionView()
        setupCalendar()
    }
    
    private func setUpUI() {
        calendarView?.backgroundColor = .white
        calendarView?.layer.cornerRadius = 25
        calendarView?.layer.masksToBounds = false
        
        calendarView?.layer.shadowColor = UIColor.black.cgColor
        calendarView?.layer.shadowOpacity = 0.1
        calendarView?.layer.shadowOffset = CGSize(width: 0, height: 4)
        calendarView?.layer.shadowRadius = 10
        
        
        arrowLeftView?.backgroundColor = .white
        arrowLeftView?.layer.cornerRadius = 25
        arrowLeftView?.layer.masksToBounds = false
        
        arrowLeftView?.layer.shadowColor = UIColor.black.cgColor
        arrowLeftView?.layer.shadowOpacity = 0.1
        arrowLeftView?.layer.shadowOffset = CGSize(width: 0, height: 4)
        arrowLeftView?.layer.shadowRadius = 10
        
        arrowRightView?.backgroundColor = .white
        arrowRightView?.layer.cornerRadius = 25
        arrowRightView?.layer.masksToBounds = false
        
        arrowRightView?.layer.shadowColor = UIColor.black.cgColor
        arrowRightView?.layer.shadowOpacity = 0.1
        arrowRightView?.layer.shadowOffset = CGSize(width: 0, height: 4)
        arrowRightView?.layer.shadowRadius = 10
        
    }
    
    private func setupCollectionView() {
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.register(UINib(nibName: "DayCell", bundle: nil), forCellWithReuseIdentifier: "DayCell")
        collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DayHeader")
        
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            let numberOfColumns: CGFloat = 7
            let spacing: CGFloat = 0
            
            let totalWidth = collectionView?.frame.width ?? 0
            let cellWidth = (totalWidth - (spacing * (numberOfColumns - 1))) / numberOfColumns
            
            layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
            
            layout.minimumInteritemSpacing = spacing
            layout.minimumLineSpacing = spacing
        }
    }
    
    private func setupCalendar() {
        let components = calendar.dateComponents([.month, .year, .day], from: currentDate)
        currentMonth = components.month ?? 4
        currentYear = components.year ?? 2025
        today = components.day ?? 12
        
        updateCalendar()
    }
    
    private func updateCalendar() {
        
        var components = DateComponents()
        components.year = currentYear
        components.month = currentMonth
        components.day = 1
        firstDayOfMonth = calendar.date(from: components)
        
        numberOfDaysInMonth = calendar.range(of: .day, in: .month, for: firstDayOfMonth!)?.count ?? 0
        
        let weekday = calendar.component(.weekday, from: firstDayOfMonth!)
        firstDayWeekday = (weekday + 5) % 7
        
        if let previousMonth = calendar.date(byAdding: .month, value: -1, to: firstDayOfMonth!) {
            previousMonthDays = calendar.range(of: .day, in: .month, for: previousMonth)?.count ?? 0
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        if let date = firstDayOfMonth {
            monthLabel?.text = dateFormatter.string(from: date)
        }
        yearLabel?.text = "\(currentYear)"
        
        collectionView?.reloadData()
    }
    
    @IBAction func previousButtonTapped(_ sender: UIButton) {
        currentMonth -= 1
            if currentMonth < 1 {
                currentMonth = 12
                currentYear -= 1
            }
            updateCalendar()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        currentMonth += 1
            if currentMonth > 12 {
                currentMonth = 1
                currentYear += 1
            }
            updateCalendar()
    }
}
