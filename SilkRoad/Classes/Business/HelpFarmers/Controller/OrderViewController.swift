//
//  OrderViewController.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/4/6.
//

import UIKit
import SnapKit

class OrderViewController: UIViewController {
    
    let receiveAddressCellReuseID = "receiveAddress"
    let productOrderCellReuseID = "productOrder"
    var commoDity = Commodity()
    
    var CallBack: ((Int) -> Void)?
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "hf_back"), for: .normal)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    lazy var colorLayer: ColorLayer = {
        let layer = ColorLayer(
            CGPoint(x: 0.5, y: 0),
            endPoint: CGPoint(x: 0.5, y: 1.0),
            colors: [UIColor(hex: "#FFCCA3").cgColor, UIColor(hex: "#FAEDE2").cgColor],
            locations: [0, 0.5])
        layer.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        return layer
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        let clv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        clv.register(ReceiveAddressCell.self, forCellWithReuseIdentifier: receiveAddressCellReuseID)
        clv.register(ProductOrderCell.self, forCellWithReuseIdentifier: productOrderCellReuseID)
        clv.delegate = self
        clv.dataSource = self
        clv.backgroundColor = .clear
        return clv
    }()
    
    lazy var submitOrderView: UIView = {
        let vi = UIView()
        vi.layer.borderWidth = 0.5
        vi.layer.borderColor = UIColor.systemGray.cgColor
        vi.backgroundColor = .white
        vi.addSubview(submitLabel)
        vi.addSubview(submitButton)
        submitLabel.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.left.equalToSuperview().offset(30)
        }
        submitButton.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.right.equalToSuperview().offset(-20)
            maker.width.equalTo(100)
            maker.height.equalTo(40)
        }
        return vi
    }()
    
    lazy var submitLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "共0件  合计: 0元"
        label.font = UIFont(name: "Arial", size: 14)
        return label
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("提交订单", for: .normal)
        button.backgroundColor = UIColor(hex: "#FFAD62")
        button.layer.cornerRadius = 8
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.isHidden = true
        
        setUI()
        NotificationCenter.default.addObserver(self, selector: #selector(updateSubmitLabel),name: .init("updateSubmitLabel"),object: nil)
    }
    
    @objc func updateSubmitLabel(notification: NSNotification){
        guard let userinfo = notification.userInfo else{return}
        self.submitLabel.text = "共\(userinfo["count"] as! Int)件  合计: \(userinfo["count"] as! Int * Int(self.commoDity.price)) 元"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
    }
    
    func setUI() {
        view.layer.addSublayer(colorLayer)
        view.addSubview(collectionView)
        view.addSubview(submitOrderView)
        view.addSubview(backButton)
        collectionView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(10)
            maker.right.equalToSuperview().offset(-10)
            maker.top.equalToSuperview().offset(110)
            maker.bottom.equalToSuperview().offset(-100)
        }
        
        submitOrderView.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-50)
            maker.height.equalTo(100)
        }
        
        backButton.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(15.fw)
            maker.top.equalToSuperview().offset(50.fh)
            maker.width.height.equalTo(30)
        }
    }
    
    func updateUI(_ data: Commodity){
        self.commoDity = data
    }

}

extension OrderViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: receiveAddressCellReuseID, for: indexPath) as! ReceiveAddressCell
            cell.titleLabel.text = "收货地址 "
            cell.addresseeLabel.text = "收件人:  小王子"
            cell.telephoneNumberLabel.text = "148157433333"
            cell.addressLabel.text = "湖南省株洲市天元区泰山路88号"
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.systemGray.cgColor
            cell.layer.borderWidth = 0.5
            cell.backgroundColor = .white
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productOrderCellReuseID, for: indexPath) as! ProductOrderCell
            cell.updateUI(self.commoDity)
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.systemGray.cgColor
            cell.layer.borderWidth = 0.5
            cell.backgroundColor = .white
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
}

extension OrderViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
        case 0:
            return CGSize(width: screenWidth-20, height: 100)
        case 1:
            return CGSize(width: screenWidth-20, height: 400)
        default:
            return .zero
        }
    }
    
}
