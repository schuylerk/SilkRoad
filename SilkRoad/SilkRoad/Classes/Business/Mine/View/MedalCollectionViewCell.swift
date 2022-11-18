//
//  MedalCollectionViewCell.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/28.
//

import UIKit
import MJRefresh

class MedalCollectionViewCell: UICollectionViewCell {
    
    let MedalCellID = "MedalCellIID"
    
    var name = [String]()
    var goad = [String]()
    
    var didSelectMedal: ((String) -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configUI()
        configData()
    }
    
    func configData() {
        guard let name = getBadge() else {
            self.name = []
            self.goad = []
            badgelabel.text = "丝绸勋章  0/5"
            return
        }
        self.name = name
        goad = name.map { string -> String in
            switch string {
            case "西安":
                return "xagoad"
            case "兰州":
                return "lzgoad"
            case "西宁":
                return "xngoad"
            case "敦煌":
                return "dhgoad"
            case "乌鲁木齐":
                return "wlmqgoad"
            default:
                return ""
            }
        }
        badgelabel.text = "丝绸勋章  \(name.count)/5"
    }
    
    lazy var badgelabel: UILabel = {
        let label = UILabel()
        label.text = "旅行徽章  \(name.count)/5"
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(refresh))
        mj_header.stateLabel?.isHidden = true
        mj_header.lastUpdatedTimeLabel?.isHidden = true
        collectionView.mj_header = mj_header
        
        collectionView.register(TravelCollectionViewCell.self, forCellWithReuseIdentifier: MedalCellID)
        return collectionView
    }()
    
    @objc func refresh() {
        configData()
        collectionView.reloadData()
        collectionView.mj_header?.endRefreshing()
    }
    
    func configUI() {
        self.addSubview(badgelabel)
        self.addSubview(collectionView)
        
        badgelabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(20.fw)
            make.width.equalToSuperview().offset(-40.fw)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(badgelabel.snp.bottom).offset(10.fh)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(20.fw)
            make.right.equalToSuperview().offset(-20.fw)
        }
    }
}

extension  MedalCollectionViewCell:  UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return name.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MedalCellID, for: indexPath) as! TravelCollectionViewCell
        cell.nameLabel.text = name[indexPath.item]
        cell.medalImageView.image = UIImage(named: goad[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectMedal?(goad[indexPath.item])
    }

}
    


extension MedalCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150.fw, height: 180.fh)
    }
    
}
