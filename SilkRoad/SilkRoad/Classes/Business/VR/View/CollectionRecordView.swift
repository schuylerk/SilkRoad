//
//  CollectionRecordView.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/4/2.
//

import UIKit

class CollectionRecordView: UIView {
    
    lazy var colorLayer: ColorLayer = {
        let layer = ColorLayer(
            CGPoint(x: 0, y: 0.5),
            endPoint: CGPoint(x: 1, y: 0.5),
            colors: [UIColor(hex: "#FFCCA3").cgColor, UIColor(hex: "#F8F8F8").cgColor],
            locations: [0, 0.5])
        layer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        return layer
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Arial", size: 16)
        return label
    }()
    
    lazy var slashView: UIView = {
        let sv = UIView()
        sv.backgroundColor = UIColor(hex: "#FFCCA3")
        return sv
    }()

}
