//
//  SKPickerView.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/9/7.
//

import UIKit

class SKPickerView: UIView {
    
    var rowHeight: CGFloat = 0
    var numberOfComponents: Int = 0
    var numberOfRowsInComponent: [Int] = []
    var titles: [[String]] = [[]]

    lazy var pickerView: UIPickerView = {
        let pv = UIPickerView(frame: CGRect(x: 0, y: 50.fh, width: Int(bounds.width), height: Int(bounds.height) - 50.fh))
        pv.delegate = self
        pv.dataSource = self
        return pv
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton(frame: CGRect(x: Int(bounds.width) - 100.fw, y: 0, width: 100.fw, height: 50.fh))
        button.setTitle("确定", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(tapSubmit), for: .touchUpInside)
        return button
    }()
    
    lazy var cancleButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100.fw, height: 50.fh))
        button.setTitle("取消", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(tapCancle), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(cancleButton)
        addSubview(submitButton)
        addSubview(pickerView)
    }

}

extension SKPickerView: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfRowsInComponent[component]
    }

}

extension SKPickerView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return rowHeight
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return titles[component][row]
    }
    
}

@objc
extension SKPickerView {
    
    func tapSubmit() {
        
    }
    
    func tapCancle() {
        
    }
    
}
