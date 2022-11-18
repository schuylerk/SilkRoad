//
//  ExploreCollectionViewCell.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/29.
//

import UIKit
import SwiftyJSON

class ExploreCollectionViewCell: UICollectionViewCell {
    
    var cellCallBack: ((CultureRelic,String) -> Void)?
    
    let ObjectCellID = "ObjectCell"
    var Relic = [CultureRelic]()
    var cityName: String = ""
    
    
    func handyJSON(_ cityname: String) {
        do{
            self.cityName = cityname
            print(cityname)
            let data = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "cultureRelic", ofType: "json")!))
            if let jsonData = String(data: data, encoding: .utf8) {
                let json = JSON(parseJSON: jsonData)
                guard let jsonarray = json[cityname].array else {print("aa")
                    return}
                self.Relic = jsonarray.map{ json -> CultureRelic in
                    return CultureRelic(
                        intro:json["intro"].stringValue, name: json["name"].stringValue,
                        unearthedYear: json["unearthedYear"].stringValue,
                        unearthPlace: json["unearthPlace"].stringValue,
                        dynasty: json["dynasty"].stringValue,
                        history: json["history"].stringValue,
                        evaluationStatus: json["evaluationStatus"].stringValue,
                        face: json["face"].stringValue
                    )
                }
                collectionView.reloadData()
            }
            else {print("false")}
        }
        catch{
            print("false")
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        ConfigUI()
    }
    
    lazy var explabel: UILabel = {
        let label = UILabel()
        label.text = "文物探索"
        label.frame = CGRect(x: 20.fw, y: 5.fh, width: 100.fw, height: 50.fh)
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: CGFloat(20.fw))
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.frame = CGRect(x: 20.fw, y: 45.fh, width: Int(screenWidth-CGFloat(40.fw)), height: 310.fh)
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
        return Relic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ObjectCellID, for: indexPath) as! ObjectCollectionViewCell
        cell.updateUI(cul: Relic[indexPath.section], city: self.cityName)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let callback = cellCallBack {
            callback(self.Relic[indexPath.section],Relic[indexPath.section].face)
        }
    }
}

extension ExploreCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170.fw, height: 280.fh)
    }
}
