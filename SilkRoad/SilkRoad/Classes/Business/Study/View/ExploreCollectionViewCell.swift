//
//  ExploreCollectionViewCell.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/29.
//

import UIKit
import SwiftyJSON

class ExploreCollectionViewCell: UICollectionViewCell {
    
    var cellCallBack: (() -> Void)?
    
    let ObjectCellID = "ObjectCell"
    var Relic = [CultureRelic]()
    var cityName: String = ""
    
    
    func handyJSON(_ cityname: String) {
        do{
            self.cityName = cityname
            let data = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "cultureRelic", ofType: "json")!))
            if let jsonData = String(data: data, encoding: .utf8) {
                let json = JSON(parseJSON: jsonData)
                guard let jsonarray = json[cityname].array else {return}
                self.Relic = jsonarray.map{ json -> CultureRelic in
                    return CultureRelic(
                        intro:json["intro"].stringValue, name: json["name"].stringValue,
                        unearthedYear: json["unearthYear"].stringValue,
                        unearthPlace: json["unearthPlace"].stringValue,
                        dynasty: json["dynasty"].stringValue,
                        history: json["history"].stringValue,
                        evaluationStatus: json["evaluationStatus"].stringValue,
                        face: json["face"].stringValue
                    )
                }
            }
            else {print("false")}
        }
        catch{
            print("false")
            
        }
    }
    
    override func layoutSubviews() {
        ConfigUI()
    }
    
    lazy var explabel: UILabel = {
        let label = UILabel()
        label.text = "文物探索"
        label.frame = CGRect(x: 20, y: 5, width: 100, height: 50)
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 20)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.frame = CGRect(x: 20, y: 45, width: screenWidth, height: 280)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false // 隐藏滑动条
        collectionView.alwaysBounceHorizontal = true
        
        collectionView.register(ObjectCollectionViewCell.self, forCellWithReuseIdentifier: ObjectCellID)
        return collectionView
    }()
    
    func ConfigUI() {
        self.addSubview(explabel)
        self.addSubview(collectionView)
        
    }
    
    
    
}

extension  ExploreCollectionViewCell:  UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ObjectCellID, for: indexPath) as! ObjectCollectionViewCell
        //cell.updateUI(cul: Relic[indexPath.section], city: self.cityName)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let callback = cellCallBack {
            callback()
        }
        
    }
}
    


extension ExploreCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170.fw, height: 250.fh)
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(0.fh), left: CGFloat(0.fw), bottom: CGFloat(13.fh), right: CGFloat(20.fw))
    }
    
}
