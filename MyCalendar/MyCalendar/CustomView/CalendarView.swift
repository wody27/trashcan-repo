//
//  CalendarView.swift
//  MyCalendar
//
//  Created by 이재용 on 2021/06/21.
//

import UIKit
import Differ

struct MyDateExpression {
    var year: Int
    var month: Int
}

enum CalendarScrollDirection {
    case left
    case right
    case none
}

enum CalendarShape {
    case week
    case month
}

class CalendarView: UIView {

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
    var firstWeekdayOfFollowingMonth: Int = 0
    var numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    
    var scrollDirection: CalendarScrollDirection = .none
    var calendarShapeMode: CalendarShape = .month
    
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
        configureCalendarFirstWeekday()
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
        previousYear = getPreviousMonth(year: presentedYear, month: presentedMonth).year
        previousMonth = getPreviousMonth(year: presentedYear, month: presentedMonth).month
        followingYear = getFollowingMonth(year: presentedYear, month: presentedMonth).year
        followingMonth = getFollowingMonth(year: presentedYear, month: presentedMonth).month
        monthView.updateYearAndMonth(to: MyDateExpression(year: presentedYear, month: presentedMonth))
    }

    private func updateCalendarView(middle date: MyDateExpression) {
        
        // 윤년 계산
        if date.month == 2 && date.year % 4 == 0 {
            numOfDaysInMonth[date.month-1] = 29
        }
        
        monthView.updateYearAndMonth(to: date)
        
        self.presentedYear = date.year
        self.presentedMonth = date.month
        
        self.previousYear = self.getPreviousMonth(year: self.presentedYear, month: self.presentedMonth).year
        self.previousMonth = self.getPreviousMonth(year: self.presentedYear, month: self.presentedMonth).month
        
        self.followingYear = self.getFollowingMonth(year: self.presentedYear, month: self.presentedMonth).year
        self.followingMonth = self.getFollowingMonth(year: self.presentedYear, month: self.presentedMonth).month
        
        self.firstWeekdayOfPreviousMonth = self.getPreviousFirstWeekday()
        self.firstWeekdayOfPresentedMonth = self.getPresentedFirstWeekday()
        self.firstWeekdayOfFollowingMonth = self.getFollowingFirstWeekday()
        
        self.previousCalendarCollectionView.reloadData()
        self.presentedCalendarCollectionView.reloadData()
        self.followingCalendarCollectionView.reloadData()
        
        let xPosition1 = self.frame.width * CGFloat(1)
        contentScrollView.setContentOffset(CGPoint(x: xPosition1, y: 0), animated: false)
    }
    
    func changeCalendarMode() {
        let date = MyDateExpression(year: currentYear, month: currentMonth)
        monthView.updateYearAndMonth(to: date)
        
        self.presentedYear = date.year
        self.presentedMonth = date.month
        
        self.previousYear = self.getPreviousMonth(year: self.presentedYear, month: self.presentedMonth).year
        self.previousMonth = self.getPreviousMonth(year: self.presentedYear, month: self.presentedMonth).month
        
        self.followingYear = self.getFollowingMonth(year: self.presentedYear, month: self.presentedMonth).year
        self.followingMonth = self.getFollowingMonth(year: self.presentedYear, month: self.presentedMonth).month
        
        self.firstWeekdayOfPreviousMonth = self.getPreviousFirstWeekday()
        self.firstWeekdayOfPresentedMonth = self.getPresentedFirstWeekday()
        self.firstWeekdayOfFollowingMonth = self.getFollowingFirstWeekday()
        
        
        
        if calendarShapeMode == .month {
            calendarShapeMode = .week
            contentScrollView.isScrollEnabled = false
        } else {
            calendarShapeMode = .month
            contentScrollView.isScrollEnabled = true
        }
        presentedCalendarCollectionView.performBatchUpdates {
            self.presentedCalendarCollectionView.reloadSections(IndexSet(integer: 0))
        } completion: { _ in
            
            self.previousCalendarCollectionView.reloadData()
            self.presentedCalendarCollectionView.reloadData()
            self.followingCalendarCollectionView.reloadData()
            
        }

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
        contentScrollView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentScrollView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        contentScrollView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        let screenSize = UIScreen.main.bounds
        contentScrollView.contentSize = CGSize(width: screenSize.width * 3, height: 300)
        
        let width = screenSize.width
        let xPosition = self.frame.width * CGFloat(0)
        previousCalendarCollectionView.frame = CGRect(x: xPosition, y: 0, width: width, height: 300)
        contentScrollView.contentSize.width = self.frame.width * 1
        contentScrollView.addSubview(previousCalendarCollectionView)
        
        let xPosition1 = self.frame.width * CGFloat(1)
        presentedCalendarCollectionView.frame = CGRect(x: xPosition1, y: 0, width: width, height: 300)
        contentScrollView.contentSize.width = self.frame.width * 2
        contentScrollView.addSubview(presentedCalendarCollectionView)
        
        let xPosition2 = self.frame.width * CGFloat(2)
        followingCalendarCollectionView.frame = CGRect(x: xPosition2, y: 0, width: width, height: 300)
        contentScrollView.contentSize.width = self.frame.width * 3
        contentScrollView.addSubview(followingCalendarCollectionView)
        
        contentScrollView.setContentOffset(CGPoint(x: xPosition1, y: 0), animated: false)
        
    }
    
    private func configureCalendarFirstWeekday() {
        firstWeekdayOfPreviousMonth = getPreviousFirstWeekday()
        firstWeekdayOfPresentedMonth = getCurrentFirstWeekday()
        firstWeekdayOfFollowingMonth = getFollowingFirstWeekday()
        
    }
    
    // 첫번째 날짜 구하기
private func getCurrentFirstWeekday() -> Int {
    let day = ("\(currentYear)-\(currentMonth)-01".date?.firstDayOfTheMonth.weekday)!
    return day
}
    
    private func getPreviousFirstWeekday() -> Int {
        let py = getPreviousMonth(year: presentedYear, month: presentedMonth).year
        let pm = getPreviousMonth(year: presentedYear, month: presentedMonth).month
        let day = ("\(py)-\(pm)-01".date?.firstDayOfTheMonth.weekday)!
        return day
    }
    
    private func getFollowingFirstWeekday() -> Int {
        let fy = getFollowingMonth(year: presentedYear, month: presentedMonth).year
        let fm = getFollowingMonth(year: presentedYear, month: presentedMonth).month
        
        let day = ("\(fy)-\(fm)-01".date?.firstDayOfTheMonth.weekday)!
        return day

    }
    
    private func getPresentedFirstWeekday() -> Int {
        let day = ("\(presentedYear)-\(presentedMonth)-01".date?.firstDayOfTheMonth.weekday)!
        return day
    }
    
    private func getFirstWeekday(by date: Date) -> Int {
        let day = date.firstDayOfTheMonth.weekday
        return day
    }
    
    private func getPreviousMonth(year: Int, month: Int) -> MyDateExpression {
        var pm: Int = 0
        var py: Int = 0
        
        if month < 2 {
            pm = 12
            py = year - 1
        } else {
            pm = month - 1
            py = year
        }
        
        return MyDateExpression(year: py, month: pm)
    }
    
    private func getFollowingMonth(year: Int, month: Int) -> MyDateExpression {
        var fm: Int = 0
        var fy: Int = 0
        
        if month > 11 {
            fm = 1
            fy = year + 1
        } else {
            fm = month + 1
            fy = year
        }
        return MyDateExpression(year: fy, month: fm)
    }
    
    // MARK: - Views
    lazy var monthView: MonthView = {
        let view = MonthView()
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
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
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
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
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
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsMultipleSelection = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DateCVCell.self, forCellWithReuseIdentifier: "DateCVCell")
        collectionView.collectionViewLayout.invalidateLayout()
        return collectionView
    }()
    
    
    lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("DO Not Use on Storyboard")
    }
}

extension CalendarView: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        switch targetContentOffset.pointee.x {
        case 0:
            scrollDirection = .left
            
        case self.frame.width * CGFloat(1):
            scrollDirection = .none
            break
        case self.frame.width * CGFloat(2):
            scrollDirection = .right
            
        default:
            break
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        switch scrollDirection {
        case .left:
            let py = getPreviousMonth(year: presentedYear, month: presentedMonth).year
            let pm = getPreviousMonth(year: presentedYear, month: presentedMonth).month
            updateCalendarView(middle: MyDateExpression(year: py, month: pm))
        case .none:
            break
        case .right:
            let fy = getFollowingMonth(year: presentedYear, month: presentedMonth).year
            let fm = getFollowingMonth(year: presentedYear, month: presentedMonth).month
            updateCalendarView(middle: MyDateExpression(year: fy, month: fm))
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView == contentScrollView {
            
            // 여기서 업데이트 해야한다.
        }
    }
    
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView == contentScrollView {
//            print("scrollViewDidScroll")
//            print(scrollView.contentOffset)
//        }
//    }
    
}

extension CalendarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case previousCalendarCollectionView:
            // 한달 수 + 앞에 이전 달 수
            let minimumCellNumber = numOfDaysInMonth[previousMonth-1] + firstWeekdayOfPreviousMonth - 1
            // 7의 배수여야 하므로
            let dateNumber = minimumCellNumber % 7 == 0 ? minimumCellNumber : minimumCellNumber + (7 - (minimumCellNumber%7))
            return dateNumber
        case presentedCalendarCollectionView:
            // 한달 수 + 앞에 이전 달 수
            switch calendarShapeMode {
            case .week:
                return 7
            case .month:
                let minimumCellNumber = numOfDaysInMonth[presentedMonth-1] + firstWeekdayOfPresentedMonth - 1
                // 7의 배수여야 하므로
                let dateNumber = minimumCellNumber % 7 == 0 ? minimumCellNumber : minimumCellNumber + (7 - (minimumCellNumber%7))
                return dateNumber
            }
            
        case followingCalendarCollectionView:
            // 한달 수 + 앞에 이전 달 수
            let minimumCellNumber = numOfDaysInMonth[followingMonth-1] + firstWeekdayOfFollowingMonth - 1
            // 7의 배수여야 하므로
            let dateNumber = minimumCellNumber % 7 == 0 ? minimumCellNumber : minimumCellNumber + (7 - (minimumCellNumber%7))
            return dateNumber
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCVCell.identifier, for: indexPath) as? DateCVCell else { return UICollectionViewCell() }
        switch collectionView {
        case previousCalendarCollectionView:
            let startWeekdayOfMonthIndex = firstWeekdayOfPreviousMonth - 1
            let minimumCellNumber = numOfDaysInMonth[previousMonth-1] + firstWeekdayOfPreviousMonth - 1
            
            if indexPath.item < startWeekdayOfMonthIndex {
                // 이전 달의 부분
                // 색깔 회색 처리
                let previousMonth = previousMonth < 2 ? 12 : previousMonth - 1
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
        case presentedCalendarCollectionView:
            switch calendarShapeMode {
            case .week:
                let startWeekdayOfMonthIndex = firstWeekdayOfPresentedMonth - 1
                let minimumCellNumber = numOfDaysInMonth[presentedMonth-1] + firstWeekdayOfPresentedMonth - 1
                
                let indexOfWeekday = startWeekdayOfMonthIndex + currentDate
                var startOfWeekThatLocatesToday: Int = 0
                var endOfWeekThatLocatesToday: Int = 0
                if indexOfWeekday >= 0 && indexOfWeekday < 7  {
                    startOfWeekThatLocatesToday = 0
                    endOfWeekThatLocatesToday = 6
                } else if indexOfWeekday >= 7 && indexOfWeekday < 14 {
                    startOfWeekThatLocatesToday = 7
                    endOfWeekThatLocatesToday = 13
                } else if indexOfWeekday >= 14 && indexOfWeekday < 21 {
                    startOfWeekThatLocatesToday = 14
                    endOfWeekThatLocatesToday = 20
                } else if indexOfWeekday >= 21 && indexOfWeekday < 28 {
                    startOfWeekThatLocatesToday = 21
                    endOfWeekThatLocatesToday = 27
                } else if indexOfWeekday >= 28 && indexOfWeekday < 35 {
                    startOfWeekThatLocatesToday = 28
                    endOfWeekThatLocatesToday = 34
                } else {
                    startOfWeekThatLocatesToday = 35
                    endOfWeekThatLocatesToday = 41
                }
                
                let dateNumber = minimumCellNumber % 7 == 0 ? minimumCellNumber : minimumCellNumber + (7 - (minimumCellNumber%7))
                
                if indexOfWeekday >= 0 && indexOfWeekday < 7 {
                    if indexPath.item < startWeekdayOfMonthIndex {
                        let previousMonth = presentedMonth < 2 ? 12 : presentedMonth - 1
                        let previousMonthDate = numOfDaysInMonth[previousMonth-1]
                        let date = previousMonthDate - (startWeekdayOfMonthIndex-1) + indexPath.row
                        cell.configureDate(to: date)
                        cell.isPreviousMonthDate()
                    } else {
                        let date = indexPath.row - startWeekdayOfMonthIndex + 1
                        cell.configureDate(to: date)
                    }
                } else if (dateNumber - 10) == endOfWeekThatLocatesToday {
                    if indexPath.item >= minimumCellNumber {
                        let date = startOfWeekThatLocatesToday + indexPath.item - minimumCellNumber + 1
                        cell.configureDate(to: date)
                        cell.isFollowingMonthDate()
                    }
                } else {
                    let date = startOfWeekThatLocatesToday - startWeekdayOfMonthIndex + 1 + indexPath.item
                    cell.configureDate(to: date)
                    
                }
                
                return cell
            case .month:
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
            
            
        case followingCalendarCollectionView:
            let startWeekdayOfMonthIndex = firstWeekdayOfFollowingMonth - 1
            let minimumCellNumber = numOfDaysInMonth[followingMonth-1] + firstWeekdayOfFollowingMonth - 1
            
            if indexPath.item < startWeekdayOfMonthIndex {
                // 이전 달의 부분
                // 색깔 회색 처리
                let previousMonth = followingMonth < 2 ? 12 : followingMonth - 1
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
        default:
            return UICollectionViewCell()
        }
        
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
