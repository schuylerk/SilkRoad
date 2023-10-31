//
//  StudyViewController.swift
//  SilkRoad
//
//  Created by student on 2022/3/25.
//

import UIKit
import SnapKit
import SwiftyJSON

class StudyViewController: UIViewController {
    
    let name = ["西 安", "兰 州", "西 宁", "敦 煌", "乌 鲁 木 齐"]
    let picture = ["xian1", "lanzhou1", "xining1", "dunhuang1", "wulumuqi1"]
    let cityCellID = "cityCellID"
    var introduceData = [CityIntroduce(), CityIntroduce(), CityIntroduce(), CityIntroduce(), CityIntroduce()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        DispatchQueue.global().async {
            self.introduceData = self.getCityIntroduceData()
        }
    }
    
    lazy var studyLabel: UILabel = {
        let label = UILabel()
        label.text = "学习"
        label.font = UIFont.systemFont(ofSize: CGFloat(32.fw))
        return label
    }()
    
    lazy var colorLayer: ColorLayer = {
        let layer = ColorLayer(
            CGPoint(x: 0.5, y: 0),
            endPoint: CGPoint(x: 0.5, y: 1.0),
            colors: [UIColor(hex: "#FFCCA3").cgColor, UIColor(hex: "#F8F8F8").cgColor],
            locations: [0, 0.5])
        layer.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        return layer
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CityCollectionViewCell.self, forCellWithReuseIdentifier: cityCellID)
        return collectionView
    }()
    
    func configUI() {
        view.layer.addSublayer(colorLayer)
        view.addSubview(collectionView)
        view.addSubview(studyLabel)
        studyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80.fh)
            make.left.equalToSuperview().offset(20.fw)
            make.width.equalToSuperview().offset(-40.fw)
            make.height.equalTo(35.fh)
        }
        collectionView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(130.fh)
            make.left.equalToSuperview().offset(20.fw)
            make.right.equalToSuperview().offset(-20.fw)
            make.bottom.equalToSuperview().offset(-50.fh)
        }
    }
    
    func configCityIntroduceData() -> [CityIntroduce] {
        do {
            guard let path = Bundle.main.path(forResource: "introduce", ofType: "json") else {
                print("获取城市介绍json文件失败")
                return []
            }
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            guard let jsonString = String(data: data, encoding: .utf8) else {
                print("data转字符串失败")
                return []
            }
            let json = JSON(parseJSON: jsonString)
            guard let jsonArray = json.array else {
                print("json转json数组失败")
                return []
            }
            UserDefaults.standard.set(jsonString, forKey: "cityintroduce")
            return jsonArray.map {
                return CityIntroduce(
                    name: $0["name"].stringValue,
                    back: $0["back"].stringValue,
                    introduce: $0["introduce"].stringValue
                )
            }
        } catch {
            print("获取指定URL的数据失败")
            return []
        }
    }
    
    func getCityIntroduceData() -> [CityIntroduce] {
        guard let jsonString = UserDefaults.standard.value(forKey: "cityintroduce") as? String else {
            return configCityIntroduceData()
        }
        let json = JSON(parseJSON: jsonString)
        guard let jsonArray = json.array else {
            print("json转json数组失败")
            return []
        }
        return jsonArray.map {
            return CityIntroduce(
                name: $0["name"].stringValue,
                back: $0["back"].stringValue,
                introduce: $0["introduce"].stringValue
            )
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = true
    }
    
}


extension StudyViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return name.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cityCellID, for: indexPath) as? CityCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.studyLabel.text = name[indexPath.section]
        cell.backgroundImageView.image = UIImage(named: picture[indexPath.section])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CityViewController()
        vc.updateUI(with: introduceData[indexPath.section])
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension StudyViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Int(screenWidth) - 40.fw, height: 150.fh)
    }
    
}
