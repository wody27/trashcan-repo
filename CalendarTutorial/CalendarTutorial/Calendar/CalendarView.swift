//
//  CalendarView.swift
//  CalendarTutorial
//
//  Created by 이재용 on 2021/04/16.
//

import UIKit

class CalendarView: UIView, MonthViewDelegate {
    var numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    var currentMonthIndex: Int = 0 // 오늘 달의 index
    var currentYear: Int = 0 // 오늘 년도
    var presentMonthIndex = 0 // 보여지는 달의 index
    var presentYear = 0 // 보여지는 달의 년도
    var todaysDate = 0 // 오늘 날짜
    var firstWeekDayOfMonth = 0 // (Sunday-Saturday 1-7)
    
    let monthView: MonthView = {
        let v = MonthView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let weekdaysView: WeekdaysView = {
        let v = WeekdaysView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let cv = UICollectionView(frame: CGRect.zero ,collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.allowsMultipleSelection = false
        return cv
    }()
    
    private func setupViews() {
        addSubview(monthView)
        monthView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        monthView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        monthView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        monthView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        addSubview(weekdaysView)
        weekdaysView.topAnchor.constraint(equalTo: monthView.bottomAnchor).isActive = true
        weekdaysView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        weekdaysView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        weekdaysView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: weekdaysView.bottomAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func getFirstWeekDay() -> Int {
        let day = ("\(currentYear)-\(currentMonthIndex)-01".date?.firstDayOfTheMonth.weekday)!
        //return day == 7 ? 1 : day
        return day
    }
    
    func didChangeMonth(monthIndex: Int, year: Int) {
        currentMonthIndex=monthIndex+1
        currentYear = year
        
        //for leap year, make february month of 29 days
        if monthIndex == 1 {
            if currentYear % 4 == 0 {
                numOfDaysInMonth[monthIndex] = 29
            } else {
                numOfDaysInMonth[monthIndex] = 28
            }
        }
        //end
        
        firstWeekDayOfMonth=getFirstWeekDay()
        
        collectionView.reloadData()
        print("HI")
//        monthView.buttonLeft.isEnabled = !(currentMonthIndex == presentMonthIndex && currentYear == presentYear)
    }
    
    private func initializeView() {
        currentMonthIndex = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        todaysDate = Calendar.current.component(.day, from: Date())
        firstWeekDayOfMonth=getFirstWeekDay()
        
        //for leap years, make february month of 29 days
        if currentMonthIndex == 2 && currentYear % 4 == 0 {
            numOfDaysInMonth[currentMonthIndex-1] = 29
        }
        //end
        
        
        setupViews()
        monthView.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DateCVC.self, forCellWithReuseIdentifier: "Cell")
    }
    
    //MARK: - 생성자
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        initializeView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension CalendarView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfDaysInMonth[currentMonthIndex-1] + firstWeekDayOfMonth - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? DateCVC else { return UICollectionViewCell() }
        cell.backgroundColor = .clear
        if indexPath.item <= firstWeekDayOfMonth - 2 {
            cell.isHidden=true
        } else {
            let calcDate = indexPath.item-firstWeekDayOfMonth+2
            cell.isHidden=false
            cell.label.text="\(calcDate)"
            if calcDate < todaysDate && currentYear == presentYear && currentMonthIndex == presentMonthIndex {
                cell.isUserInteractionEnabled=false
                cell.label.textColor = UIColor.lightGray
            } else {
                cell.isUserInteractionEnabled=true
                cell.label.textColor = Style.activeCellLabelColor
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/7 - 8
        let height: CGFloat = 40
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
}

struct Colors {
    static var darkGray = #colorLiteral(red: 0.3764705882, green: 0.3647058824, blue: 0.3647058824, alpha: 1)
    static var darkRed = #colorLiteral(red: 0.5019607843, green: 0.1529411765, blue: 0.1764705882, alpha: 1)
}

class DateCVC: UICollectionViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "00"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Colors.darkGray
        label.translatesAutoresizingMaskIntoConstraints=false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupViews() {
        addSubview(label)
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive=true
        label.leftAnchor.constraint(equalTo: self.leftAnchor).isActive=true
        label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive=true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive=true
    }
}

extension Date {
    var weekday: Int {
        get {
            Calendar.current.component(.weekday, from: self)
        }
    }
    var month: Int {
        get {
            Calendar.current.component(.month, from: self)
        }
    }
//    var firstDay: Date {
//        get {
//
//        }
//    }
    var firstDayOfTheMonth: Date {
        get {
            Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        }
    }
}

extension String {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
}
