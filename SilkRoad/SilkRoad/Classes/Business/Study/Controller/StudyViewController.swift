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
    

    let CityCellID = "CityCellID"
    var IntroduceData = [Introduce]()
    
    let name = ["西 安", "兰 州", "西 宁", "敦 煌", "乌 鲁 木 齐"]
    let picture = ["xian1", "lanzhou1", "xining1", "dunhuang1", "wulumuqi1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configUI()
        handyJSON()
    }
    
    lazy var Studylabel: UILabel = {
        let label = UILabel()
        label.text = "学习"
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 32)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "stdmainback"))
        imageView.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: 300.fh)
        return imageView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false // 隐藏滑动条
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(CityCollectionView.self, forCellWithReuseIdentifier: CityCellID)
        return collectionView
    }()
    
    lazy var searchView: SearchView = {
        let searchView = SearchView()
        searchView.backgroundColor = UIColor(hex: "#FDF5EF")
        searchView.layer.cornerRadius = CGFloat(20.fw)
        searchView.layer.borderColor = UIColor(hex: "#D8D0C9").cgColor
        searchView.layer.borderWidth = CGFloat(1.fw)
        searchView.searchTextField.delegate = self
        return searchView
    }()
    
//    lazy var searchBarBtn: UIButton = {
//        let btn = UIButton()
//        btn.titleLabel?.textAlignment = .left
//        btn.addTarget(self, action: #selector(searchBarClick), for: .touchUpInside)
//        return btn
//    }()
    
    lazy var blackView: UIView = {
        let blv = UIView()
        blv.backgroundColor = .black
        blv.alpha = 0.5
        blv.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(cancleSearch))
        blv.addGestureRecognizer(gesture)
        blv.isHidden = true
        return blv
    }()
    
    @objc func cancleSearch() {
        blackView.isHidden = true
        searchView.searchTextField.resignFirstResponder()
    }
    
    
    func configUI() {
        self.view.addSubview(imageView)
        self.view.addSubview(collectionView)
        self.view.addSubview(Studylabel)
        self.view.addSubview(blackView)
        self.view.addSubview(searchView)
        
        Studylabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-390.fh)
            make.left.equalToSuperview().offset(20.fw)
            make.width.equalToSuperview().offset(20.fw)
            make.height.equalToSuperview().offset(35.fh)
        }
    
        collectionView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(170.fh)
            make.left.equalToSuperview().offset(20.fw)
            make.right.equalToSuperview().offset(-20.fw)
            make.height.equalToSuperview().offset(1000.fh)
        }
    
        blackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        searchView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(20.fw)
            maker.right.equalToSuperview().offset(-20.fw)
            maker.height.equalTo(40.fw)
            maker.top.equalToSuperview().offset(120.fh)
        }
        
        
    }
    
    
    func handyJSON() {
        do{
            let data = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "introduce", ofType: "json")!))
            if let jsonData = String(data: data, encoding: .utf8) {
                let json = JSON(parseJSON: jsonData)
                guard let jsonarray = json.array else {return}
                self.IntroduceData = jsonarray.map{ json -> Introduce in
                    return Introduce(
                        name: json["name"].stringValue,
                        back: json["back"].stringValue,
                        introduce: json["introduce"].stringValue
                    )
                }
                
            }
            else {print("false")}
        }
        catch{
            print("false")
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
}


extension  StudyViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCellID, for: indexPath) as! CityCollectionView
        cell.Studylabel.text = name[indexPath.section]
        cell.BackView.image = UIImage(named: picture[indexPath.section])
        cell.clipsToBounds = true
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CityViewController()
        vc.updateUI(with: IntroduceData[indexPath.section])
        navigationController?.pushViewController(vc, animated: true)
    }
}
    


extension StudyViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Int(screenWidth - 40).fw, height: 135.fh)
    }
    
}


extension StudyViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        blackView.isHidden = false
    }
    
}
