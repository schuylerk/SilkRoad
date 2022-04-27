//
//  DateView.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/22.
//

import UIKit

class DateView: UIView {

    let date = Date()
    let color = [UIColor(red: 0.275, green: 0.498, blue: 0.871, alpha: 1), UIColor(red: 0.553, green: 0.804, blue: 0.827, alpha: 1), UIColor.white, UIColor(red: 0.553, green: 0.804, blue: 0.827, alpha: 1),UIColor(red: 0.275, green: 0.498, blue: 0.871, alpha: 1) ]
    let backColor = [UIColor.white, UIColor.white, UIColor(red: 0.345, green: 0.373, blue: 0.867, alpha: 1), UIColor.white, UIColor.white]
    let mon = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    let DateCellID = "DateCellID"
    
    
    lazy var DatecollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false // 隐藏滑动条
        collectionView.alwaysBounceVertical = false
        
        collectionView.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: DateCellID)
        return collectionView
    }()
        
    lazy var MonLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 15)
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1)
        label.numberOfLines = 0
        label.text = "\(mon[month()]) \(year())"
        return label
    }()
    
    func year() -> Int {
            let calendar = NSCalendar.current
            let com = calendar.dateComponents([.year, .month, .day], from: date)
            return com.year!
    }

    func month() -> Int {
            let calendar = NSCalendar.current
            let com = calendar.dateComponents([.year, .month, .day], from: date)
            return com.month!
    }

    func day() -> Int {
            let calendar = NSCalendar.current
            let com = calendar.dateComponents([.year, .month, .day], from: date)
            return com.day!
    }
    
    func daysInCurrMonth() -> Int {
            let days: NSRange = (Calendar.current as NSCalendar).range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: date)
            return days.length
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        configUI()
    }
    
    func configUI() {
        self.addSubview(DatecollectionView)
        self.addSubview(MonLabel)
        
        MonLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(-20)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        DatecollectionView.snp.makeConstraints { make in
            make.top.equalTo(MonLabel.snp.bottom).offset(10)
            make.bottom.left.right.equalToSuperview().offset(0)
        }
        
    }
    
}

extension  DateView:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCellID, for: indexPath) as! DateCollectionViewCell
//        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.20).cgColor
//        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
//        cell.layer.shadowOpacity = 1
//        cell.clipsToBounds = true
//        cell.layer.cornerRadius = 10
        let a = [day() - 2, day() - 1, day(), day() + 1, day() + 2]
        cell.DayLabel.text = "\(a[indexPath.section])"
        cell.DayLabel.textColor = color[indexPath.section]
        cell.WhiteView.backgroundColor = backColor[indexPath.section]
        return cell
    }

}
    


extension DateView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50.fw, height: 50.fh)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(0.fh), left: CGFloat(0.fw), bottom: CGFloat(0.fh), right: CGFloat(15.fw))
    }
}
