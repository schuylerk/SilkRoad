//
//  ProductOrderCell.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/4/6.
//

import UIKit
import SnapKit

class ProductOrderCell: UICollectionViewCell {
    
    let unitPriceCellReuseID = "unitPrice"
    let purchaseQuantityCellReuseID = "purchaseQuantity"
    let orderRemarksReuseID = "orderRemarks"
    
    lazy var faceImageView: UIImageView = {
        let imgV = UIImageView()
        imgV.backgroundColor = .systemGray6
        return imgV
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#FFAD80")
        label.font = UIFont(name: "Arial", size: 14)
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tbv = UITableView()
        tbv.tableFooterView = UIView()
        tbv.separatorStyle = .none
        tbv.register(UnitPriceCell.self, forCellReuseIdentifier: unitPriceCellReuseID)
        tbv.register(PurchaseQuantityCell.self, forCellReuseIdentifier: purchaseQuantityCellReuseID)
        tbv.register(OrderRemarksCell.self, forCellReuseIdentifier: orderRemarksReuseID)
        tbv.dataSource = self
        tbv.delegate = self
        tbv.backgroundColor = .clear
        return tbv
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setup()
    }
    
    func setup() {
        self.addSubview(faceImageView)
        self.addSubview(nameLabel)
        self.addSubview(tableView)
        faceImageView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(20)
            maker.top.equalToSuperview().offset(30)
            maker.width.equalTo(200)
            maker.height.equalTo(150)
        }
        nameLabel.snp.makeConstraints { maker in
            maker.centerY.equalTo(faceImageView)
            maker.left.equalTo(faceImageView.snp.right).offset(30)
        }
        tableView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(faceImageView.snp.bottom).offset(30)
            maker.left.equalToSuperview().offset(60)
            maker.bottom.equalToSuperview().offset(-30)
        }
    }
    
}

extension ProductOrderCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: unitPriceCellReuseID, for: indexPath) as! UnitPriceCell
            cell.nameLabel.text = "单价"
            cell.valueLabel.text = "***"
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: purchaseQuantityCellReuseID, for: indexPath) as! PurchaseQuantityCell
            cell.nameLabel.text = "购买数量"
            cell.valueLabel.text = "0"
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: orderRemarksReuseID, for: indexPath) as! OrderRemarksCell
            cell.nameLabel.text = "备注"
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0, 1:
            return 30
        case 2:
            return 100
        default:
            return 1
        }
    }
    
}
