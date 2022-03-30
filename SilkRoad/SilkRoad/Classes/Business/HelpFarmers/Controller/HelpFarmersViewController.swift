//
//  HelpFarmersViewController.swift
//  SilkRoad
//
//  Created by student on 2022/3/25.
//

import UIKit
import SnapKit

class HelpFarmersViewController: UIViewController {
    
    let commodityCellReuseID = "commodity"
    
    var commodityData = [Commodity]()
    
    lazy var colorLayer: ColorLayer = {
        let layer = ColorLayer(
            CGPoint(x: 0.5, y: 0),
            endPoint: CGPoint(x: 0.5, y: 1.0),
            colors: [UIColor(hex: "#FFCCA3").cgColor, UIColor(hex: "#F8F8F8").cgColor],
            locations: [0, 0.5])
        layer.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        return layer
    }()
    
    lazy var searchView: SearchView = {
        let sv = SearchView()
        sv.backgroundColor = UIColor(hex: "#FDF5EF")
        sv.layer.cornerRadius = CGFloat(20.fw)
        sv.layer.borderColor = UIColor(hex: "#D8D0C9").cgColor
        sv.layer.borderWidth = CGFloat(1.fw)
        sv.searchTextField.delegate = self
        return sv
    }()
    
    lazy var commodityCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        let clv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        clv.delegate = self
        clv.dataSource = self
        clv.register(CommodityCell.self, forCellWithReuseIdentifier: commodityCellReuseID)
        clv.backgroundColor = .clear
        clv.showsVerticalScrollIndicator = false
        return clv
    }()
    
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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setNav()
        setUI()
        self.commodityData = [
            Commodity(face: "", description: "我是描述我是描述我是描述我是描述我是描述我是描述我是描述我是描述我是描述我是描述我是描述我是描述", purchasedNum: 425, price: 425.5),
            Commodity(face: "", description: "描述我是描述我是描述我是描述是描述", purchasedNum: 425, price: 425.5),
            Commodity(face: "", description: "我是描述", purchasedNum: 425, price: 425.5),
            Commodity(face: "", description: "我是描述我是描述我是描述我是描述我是描述我是描述我是描述我是描述我是描述我是描述我是描述我是描述", purchasedNum: 425, price: 425.5)
        ]
    }
    
    func setNav() {
        self.title = "助农平台"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.font: UIFont(name: "Arial", size: 25) as Any]
    }
    
    func setUI() {
        view.backgroundColor = .white
        view.layer.addSublayer(colorLayer)
        view.addSubview(commodityCollectionView)
        commodityCollectionView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(20.fw)
            maker.right.equalToSuperview().offset(-20.fw)
            maker.top.equalToSuperview().offset(200)
            maker.bottom.equalToSuperview()
        }
        view.addSubview(blackView)
        blackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        view.addSubview(searchView)
        searchView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(20.fw)
            maker.right.equalToSuperview().offset(-20.fw)
            maker.height.equalTo(40.fw)
            maker.top.equalToSuperview().offset(150.fh)
        }
    }

}

extension HelpFarmersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return commodityData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let commodity = commodityData[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commodityCellReuseID, for: indexPath) as! CommodityCell
        cell.backgroundColor = .white
        cell.configCell(CommodityCellModel(
            face: commodity.face,
            description: commodity.description,
            purchasedNum: commodity.purchasedNum,
            price: commodity.price))
        cell.layer.cornerRadius = CGFloat(15.fw)
        return cell
    }
    
}

extension HelpFarmersViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = commodityData[indexPath.row]
        let height = model.descriptionRect().height
        print(height)
        return CGSize(width: 180.fw, height: 280.fh + Int(height))
    }
    
}

extension HelpFarmersViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        blackView.isHidden = false
    }
    
}
