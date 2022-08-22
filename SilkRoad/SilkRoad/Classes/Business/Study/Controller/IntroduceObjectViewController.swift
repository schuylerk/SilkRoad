//
//  IntroduceObjectViewController.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/29.
//

import UIKit

class IntroduceObjectViewController: UIViewController {
    
    var Data = CultureRelic()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
        // Do any additional setup after loading the view.
        //navigationController?.navigationBar.isHidden = false
        ConfigUI()
    }
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.frame = CGRect(x: 20.fw, y: 50.fh, width: 30.fw, height: 30.fh)
        button.addTarget(self, action: #selector(clickLeftBackButton), for: .touchUpInside)
        return button
    }()
    
    @objc func clickLeftBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "stdmainback"))
        imageView.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: 300.fh)
        return imageView
    }()
    
    lazy var Biglabel: UILabel = {
        let label = UILabel()
        label.text = "敦煌大鼎"
        label.frame = CGRect(x: 220.fw, y: 144.fh, width: 200.fw, height: 60.fw)
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 20)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var Yearlabel2: UILabel = {
        let label = UILabel()
        label.text = "出土年份："
        label.frame = CGRect(x: 209, y: 208, width: 90, height: 20)
        label.font = UIFont.init(name: "Source Han Serif CN", size: 15)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var Yearlabel: UILabel = {
        let label = UILabel()
        label.text = "出土年份： 1987"
        label.font = UIFont.init(name: "Source Han Serif CN", size: 12)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var Placelabel2: UILabel = {
        let label = UILabel()
        label.text = "出土地点："
        label.frame = CGRect(x: 209, y: 235, width: 90, height: 20)
        label.font = UIFont.init(name: "Source Han Serif CN", size: 15)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var Placelabel: UILabel = {
        let label = UILabel()
        label.text = "出土地点： 敦煌"
        label.font = UIFont.init(name: "Source Han Serif CN", size: 12)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var Yearslabel2: UILabel = {
        let label = UILabel()
        label.text = "所属朝代："
        label.frame = CGRect(x: 209, y: 262, width: 90, height: 20)
        label.font = UIFont.init(name: "Source Han Serif CN", size: 15)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var Yearslabel: UILabel = {
        let label = UILabel()
        label.text = "所属朝代： 明朝"
        label.font = UIFont.init(name: "Source Han Serif CN", size: 12)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var HistoryLabel: UILabel = {
        let label = UILabel()
        label.text = "文物介绍一"
        label.frame = CGRect(x: 26, y: 328, width: 200, height: 27)
        label.font = UIFont.init(name: "Source Han Serif CN", size: 20)
        label.textColor = UIColor(red: 0.62, green: 0.478, blue: 0.353, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var HisIntrLabel: UILabel = {
        let label = UILabel()
        label.text = "     文物历史介绍文物历史介绍文物历史介绍文物历史介绍文物历史介绍文物历史介绍"
        label.font = UIFont.init(name: "Source Han Serif CN", size: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var RemarkLabel: UILabel = {
        let label = UILabel()
        label.text = "文物介绍二"
        label.font = UIFont.init(name: "Source Han Serif CN", size: 20)
        label.textColor = UIColor(red: 0.62, green: 0.478, blue: 0.353, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var RemIntrLabel: UILabel = {
        let label = UILabel()
        label.text = "     文物评价文物评价文物评价文物评价文物评价文物评价文物评价文物评价文物评价"
        label.font = UIFont.init(name: "Source Han Serif CN", size: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var BackView:UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 25, y: 113, width: 160, height: 160)
        let image = UIImage(named: "wenwuimage")
        imageView.image = image
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    func ConfigUI() {
        self.view.addSubview(imageView)
        self.view.addSubview(leftButton)
        self.view.addSubview(Biglabel)
        self.view.addSubview(Yearlabel)
        self.view.addSubview(Placelabel)
        self.view.addSubview(Yearslabel)
        self.view.addSubview(HistoryLabel)
        self.view.addSubview(HisIntrLabel)
        self.view.addSubview(RemarkLabel)
        self.view.addSubview(RemIntrLabel)
        self.view.addSubview(BackView)
        self.view.addSubview(Yearslabel2)
        self.view.addSubview(Placelabel2)
        self.view.addSubview(Yearlabel2)
        
        Yearlabel.snp.makeConstraints { make in
            make.left.equalTo(Yearlabel2.snp.right)
            make.right.equalToSuperview().offset(-5)
            make.top.bottom.equalTo(Yearlabel2)
        }
        
        Yearslabel.snp.makeConstraints { make in
            make.left.equalTo(Yearslabel2.snp.right)
            make.right.equalToSuperview().offset(-5)
            make.top.bottom.equalTo(Yearslabel2)
        }
        
        Placelabel.snp.makeConstraints { make in
            make.left.equalTo(Placelabel2.snp.right)
            make.right.equalToSuperview().offset(-5)
            make.top.bottom.equalTo(Placelabel2)
        }
        
        HisIntrLabel.snp.makeConstraints { make in
            make.left.equalTo(HistoryLabel)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(130)
            make.top.equalTo(HistoryLabel.snp.bottom)
        }
        
        RemarkLabel.snp.makeConstraints { make in
            make.left.equalTo(HistoryLabel)
            make.right.equalTo(HistoryLabel)
            make.height.equalTo(27)
            make.top.equalTo(HisIntrLabel.snp.bottom).offset(5)
        }
        
        RemIntrLabel.snp.makeConstraints {make in
            make.left.equalTo(HistoryLabel)
            make.right.equalTo(HisIntrLabel)
            make.top.equalTo(RemarkLabel.snp.bottom)
            make.height.equalTo(120)
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func updateUI(data: CultureRelic){
        self.Biglabel.text = data.name
        self.Yearlabel.text =  data.unearthedYear
        self.Placelabel.text = data.unearthPlace
        self.Yearslabel.text = data.dynasty
        self.HisIntrLabel.text = data.intro
        self.RemIntrLabel.text = data.history
    }

}
