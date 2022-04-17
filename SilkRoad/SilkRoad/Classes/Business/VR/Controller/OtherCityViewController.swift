//
//  OtherCityViewController.swift
//  GA
//
//  Created by WSH on 2022/4/14.
//

import UIKit

class OtherCityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        ConfigUI()
        Animation()
    }
    
    lazy var label1: UILabel = {
        let label = UILabel(frame: CGRect(x: -340, y: 50, width: 340, height: 150))
        label.text = "你好，我是杨洋洋111111111111111111111111111111111111111111111111你好，我是杨洋洋111111111111111111111111111111111111111111111111你好，我是杨洋洋111111111111111111111111111111111111111111111111你好，我是杨洋洋111111111111111111111111111111111111111111111111你好，我是杨洋洋111111111111111111111111111111111111111111111111"
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
   
    lazy var label2: UILabel = {
        let label = UILabel(frame: CGRect(x: -340, y: 230, width: 340, height: 200))
        label.text = "你好，我是杨洋洋11111111111111111111111你好，我是杨洋洋111111111111111111111111111111111111111111111111你好，我是杨洋洋111111111111111111111111111111111111111111111111你好，我是杨洋洋111111111111111111111111111111111111111111111111你好，我是杨洋洋111111111111111111111111111111111111111111111111你好，我是杨洋洋111111111111111111111111111111111111111111111111"
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    lazy var label3: UILabel = {
        let label = UILabel(frame: CGRect(x: -340, y: 460, width: 340, height: 200))
        label.text = "你好，我是杨洋洋你好，我是杨洋洋111111111111111111111111111111111111111111111111你好，我是杨洋洋111111111111111111111111111111111111111111111111你好，我是杨洋洋111111111111111111111111111111111111111111111111你好，我是杨洋洋111111111111111111111111111111111111111111111111你好，我是杨洋洋111111111111111111111111111111111111111111111111你好，我是杨洋洋111111111111111111111111111111111111111111111111"
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "vr_back"), for: .normal)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()
    
    @objc func back() {
        //self.navigationController?.popViewController(animated: true)
    }
    
    
    func ConfigUI() {
        self.view.addSubview(label1)
        self.view.addSubview(label2)
        self.view.addSubview(label3)
        self.view.addSubview(backButton)
        
        backButton.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(15.fw)
            maker.top.equalToSuperview().offset(50.fh)
            maker.width.height.equalTo(30)
        }
    }
    
    func Animation() {
        
        UIView.animate(withDuration: 3, delay: 1, animations: {
            self.label1.transform = CGAffineTransform(translationX: 360, y: 0)
        })
        
        UIView.animate(withDuration: 3, delay: 3, animations: {
            self.label2.transform = CGAffineTransform(translationX: 380, y: 0)
        })
        UIView.animate(withDuration: 3, delay: 6, animations: {
            self.label3.transform = CGAffineTransform(translationX: 380, y: 0)
        })
    }
    
}
