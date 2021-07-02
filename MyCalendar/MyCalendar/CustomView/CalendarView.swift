//
//  CalendarView.swift
//  MyCalendar
//
//  Created by 이재용 on 2021/06/21.
//

import UIKit

class CalendarView: UIView, MonthViewDelegate {

    func didChangeMonth(month: Int, year: Int) {
        presentedMonth = month
        presentedYear = year
        updateCalendarView()
    }
    
    // MARK: - Computed Property

    var currentYear: Int {
        get {
            Calendar.current.component(.year, from: Date())
        }
    }
    
    var currentMonth: Int {
        get {
            Calendar.current.component(.month, from: Date())
        }
    }
    
    var currentDate: Int {
        get {
            Calendar.current.component(.day, from: Date())
        }
    }
    
    var calendar: Calendar {
        get {
            var calendar = Calendar(identifier: .gregorian)
            calendar.locale = Locale(identifier: "ko")
            return calendar
        }
    }
    
    // MARK: - Static Property
    
    var previousMonth: Int = 0
    var previousYear: Int = 0
    
    var presentedMonth: Int = 0
    var presentedYear: Int = 0
    
    var followingMonth: Int = 0
    var followingYear: Int = 0
    
    var firstWeekdayOfPreviousMonth: Int = 0
    var firstWeekdayOfPresentedMonth: Int = 0
    var firstWeekayOfFollowingMonth: Int = 0
    var numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    
    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureAll()
    }
    
    convenience init(month: Int, year: Int) {
        self.init()
        presentedMonth = month
        presentedYear = year
        if presentedMonth < 2 {
            previousMonth = 12
            previousYear = presentedYear - 1
        } else {
            previousMonth = presentedMonth - 1
            previousYear = presentedYear
        }
        if presentedMonth > 11 {
            followingMonth = 1
            followingYear = presentedYear + 1
        } else {
            followingMonth = presentedMonth + 1
            followingYear = presentedYear
        }
        
    }
    
    // MARK: - Private Method

    private func configureAll() {
        configureCalendarView()
        setUpViews()
    }
    
    private func configureWithMonthAndYear() {
        updateCalendarView()
        setUpViews()
    }
    
    private func configureCalendarView() {
        firstWeekdayOfPresentedMonth = getCurrentFirstWeekday()
        // 윤년 계산
        if currentMonth == 2 && currentYear % 4 == 0 {
            numOfDaysInMonth[currentMonth-1] = 29
        }
        
        presentedMonth = currentMonth
        presentedYear = currentYear
    }
    
    private func updateCalendarView() {
        firstWeekdayOfPresentedMonth = getPresentedFirstWeekday()
        if presentedMonth == 2 && presentedMonth % 4 == 0 {
            numOfDaysInMonth[presentedMonth-1] = 29
        }
        self.middleCalendarCollectionView.reloadData()
//        UIView.animate(withDuration: 0.1) {
//            self.calendarCollectionView.reloadData()
//            self.calendarCollectionView.layoutIfNeeded()
//        }
//        UIView.transition(with: calendarCollectionView,
//                          duration: 0.35,
//                          options: .transitionCrossDissolve,
//                          animations: { self.calendarCollectionView.reloadData() })
    }
    
    private func setUpViews() {

        addSubview(monthView)
        monthView.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
        monthView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        monthView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        monthView.heightAnchor.constraint(equalToConstant: 24).isActive = true

        addSubview(weekdayView)
        weekdayView.topAnchor.constraint(equalTo: monthView.bottomAnchor, constant: 16).isActive = true
        weekdayView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        weekdayView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        weekdayView.heightAnchor.constraint(equalToConstant: 11).isActive = true

        addSubview(contentScrollView)
        contentScrollView.topAnchor.constraint(equalTo: weekdayView.bottomAnchor, constant: 12).isActive = true
        contentScrollView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        contentScrollView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        contentScrollView.heightAnchor.constraint(equalToConstant: 264).isActive = true
        
        let width = frame.width * 3
        contentScrollView.contentSize = CGSize(width: width, height: frame.height)
        contentScrollView.backgroundColor = .black
        
        for i in 0..<3 {
            
            
        }
//        addSubview(calendarCollectionView)
//        calendarCollectionView.topAnchor.constraint(equalTo: weekdayView.bottomAnchor, constant: 12).isActive = true
//        calendarCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
//        calendarCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
//        calendarCollectionView.heightAnchor.constraint(equalToConstant: 264).isActive = true
        
    }
    
    // 첫번째 날짜 구하기
    private func getCurrentFirstWeekday() -> Int {
        let day = ("\(currentYear)-\(currentMonth)-01".date?.firstDayOfTheMonth.weekday)!
        return day
    }
    
    private func getPresentedFirstWeekday() -> Int {
        let day = ("\(presentedYear)-\(presentedMonth)-01".date?.firstDayOfTheMonth.weekday)!
        return day
    }
    
    // 임시로 만들어둠
    private func getFirstWeekday(by date: Date) -> Int {
        let day = date.firstDayOfTheMonth.weekday
        return day
    }
    
    
    // MARK: - Views
    lazy var monthView: MonthView = {
        let view = MonthView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var weekdayView: WeekdayView = {
        let view = WeekdayView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var previousCalendarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsMultipleSelection = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DateCVCell.self, forCellWithReuseIdentifier: "DateCVCell")
        collectionView.collectionViewLayout.invalidateLayout()
        return collectionView
    }()
    
    lazy var presentedCalendarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsMultipleSelection = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DateCVCell.self, forCellWithReuseIdentifier: "DateCVCell")
        collectionView.collectionViewLayout.invalidateLayout()
        return collectionView
    }()
    
    lazy var followingCalendarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsMultipleSelection = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DateCVCell.self, forCellWithReuseIdentifier: "DateCVCell")
        collectionView.collectionViewLayout.invalidateLayout()
        return collectionView
    }()
    
    
    let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("DO Not Use on Storyboard")
    }
}

extension CalendarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 한달 수 + 앞에 이전 달 수
        let minimumCellNumber = numOfDaysInMonth[presentedMonth-1] + firstWeekdayOfPresentedMonth - 1
        // 7의 배수여야 하므로
        let dateNumber = minimumCellNumber % 7 == 0 ? minimumCellNumber : minimumCellNumber + (7 - (minimumCellNumber%7))
        return dateNumber
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCVCell.identifier, for: indexPath) as? DateCVCell else { return UICollectionViewCell() }
        
        let startWeekdayOfMonthIndex = firstWeekdayOfPresentedMonth - 1
        let minimumCellNumber = numOfDaysInMonth[presentedMonth-1] + firstWeekdayOfPresentedMonth - 1
        
        if indexPath.item < startWeekdayOfMonthIndex {
            // 이전 달의 부분
            // 색깔 회색 처리
            let previousMonth = presentedMonth < 2 ? 12 : presentedMonth - 1
            let previousMonthDate = numOfDaysInMonth[previousMonth-1]
            let date = previousMonthDate - (startWeekdayOfMonthIndex-1) + indexPath.row
            cell.configureDate(to: date)
            cell.isPreviousMonthDate()
        } else if indexPath.item >= minimumCellNumber {
            // 다음 달의 부분
            let date = indexPath.item - minimumCellNumber + 1
            cell.configureDate(to: date)
            cell.isFollowingMonthDate()
        } else {
            let date = indexPath.row - startWeekdayOfMonthIndex + 1
            cell.configureDate(to: date)
        }
        return cell
    }
}

extension CalendarView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 32) / 7
        let height: CGFloat = 44
        return CGSize(width: width, height: height)
    }
}
