//
//  IntroduceObjectViewController.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/29.
//

import UIKit

class IntroduceObjectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
        // Do any additional setup after loading the view.
        ConfigUI()
    }
    
    lazy var Biglabel: UILabel = {
        let label = UILabel()
        label.text = "敦煌大鼎"
        label.frame = CGRect(x: 210, y: 144, width: 200, height: 51)
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 38)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var Yearlabel: UILabel = {
        let label = UILabel()
        label.text = "出土年份： 1987"
        label.frame = CGRect(x: 209, y: 208, width: 200, height: 20)
        label.font = UIFont.init(name: "Source Han Serif CN", size: 15)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var Placelabel: UILabel = {
        let label = UILabel()
        label.text = "出土地点： 敦煌"
        label.frame = CGRect(x: 209, y: 235, width: 200, height: 20)
        label.font = UIFont.init(name: "Source Han Serif CN", size: 15)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var Yearslabel: UILabel = {
        let label = UILabel()
        label.text = "所属朝代： 明朝"
        label.frame = CGRect(x: 209, y: 262, width: 200, height: 20)
        label.font = UIFont.init(name: "Source Han Serif CN", size: 15)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var HistoryLabel: UILabel = {
        let label = UILabel()
        label.text = "文物历史"
        label.frame = CGRect(x: 26, y: 328, width: 200, height: 27)
        label.font = UIFont.init(name: "Source Han Serif CN", size: 20)
        label.textColor = UIColor(red: 0.62, green: 0.478, blue: 0.353, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var HisIntrLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 25, y: 330, width: 370, height: 120)
        label.text = "     文物历史介绍文物历史介绍文物历史介绍文物历史介绍文物历史介绍文物历史介绍"
        label.font = UIFont.init(name: "Source Han Serif CN", size: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var RemarkLabel: UILabel = {
        let label = UILabel()
        label.text = "评价地位"
        label.frame = CGRect(x: 26, y: 478, width: 200, height: 27)
        label.font = UIFont.init(name: "Source Han Serif CN", size: 20)
        label.textColor = UIColor(red: 0.62, green: 0.478, blue: 0.353, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var RemIntrLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 25, y: 480, width: 370, height: 120)
        label.text = "     文物评价文物评价文物评价文物评价文物评价文物评价文物评价文物评价文物评价"
        label.font = UIFont.init(name: "Source Han Serif CN", size: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var BackView:UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 25, y: 113, width: 164, height: 169)
        let image = UIImage(named: "wenwuimage")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    func ConfigUI() {
        self.view.addSubview(Biglabel)
        self.view.addSubview(Yearlabel)
        self.view.addSubview(Placelabel)
        self.view.addSubview(Yearslabel)
        self.view.addSubview(HistoryLabel)
        self.view.addSubview(HisIntrLabel)
        self.view.addSubview(RemarkLabel)
        self.view.addSubview(RemIntrLabel)
        self.view.addSubview(BackView)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    

}
