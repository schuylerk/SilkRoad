//
//  IntegralViewController.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/29.
//

import UIKit

class IntegralViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.953, alpha: 1)
        self.navigationController?.navigationBar.isHidden = true
        self.title = "积分中心"
        ConfigUI()
    }
    
    lazy var WhiteView: UIView = {
        let layerView = UIView()
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.23).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        layerView.frame = CGRect(x: 20.fw, y: 106.fh, width: 390.fw, height: 100.fh)
        layerView.layer.shadowOpacity = 1
        layerView.backgroundColor = .white
        layerView.layer.cornerRadius = 14
        layerView.alpha = 1
        return layerView
    }()
    
    lazy var scorelabel: UILabel = {
        let label = UILabel()
        //此label可改数值
        label.text = "\((UserDefaults.standard.value(forKey: "silkintegral") as? Int) ?? 0)"
        label.frame = CGRect(x: 79, y: 123, width: 59, height: 44)
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 36)
        label.textColor = UIColor(red: 1, green: 0.383, blue: 0.383, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var silkscorelabel: UILabel = {
        let label = UILabel()
        label.text = "丝绸积分"
        label.frame = CGRect(x: 82.fw, y: 165.fh, width: 100.fw, height: 16.fh)
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 14)
        label.textColor = UIColor(red: 0.312, green: 0.312, blue: 0.312, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var signlabel: UILabel = {
        let label = UILabel()
        label.text = "签到领积分"
        label.frame = CGRect(x: 280.fw, y: 135.fh, width: 120.fw, height: 19.fh)
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var signdatelabel: UILabel = {
        let label = UILabel()
        label.text = "已连续签到\(1)天"
        label.frame = CGRect(x: 280.fw, y: 157.fh, width: 100.fw, height: 13.fh)
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 12)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var DateView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Date"))
        imageView.frame = CGRect(x: 221.fw, y: 134.fh, width: 50.fw, height: 50.fh)
        return imageView
    }()
    
    lazy var LineView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "line"))
        imageView.frame = CGRect(x: 200.fw, y: 134.fh, width: 5.fw, height: 50.fh)
        return imageView
    }()
    
    lazy var ScoreView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Score"))
        imageView.frame = CGRect(x: 10.fw, y: 225.fh, width: 400.fw, height: 251.fh)
        return imageView
    }()

    lazy var leftButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "back"), for: .normal)
            button.frame = CGRect(x: 20.fw, y: 50.fh, width: 30.fw, height: 30.fh)
            button.addTarget(self, action: #selector(clickLeftBackButton), for: .allEvents)
            
            return button
        }()
        
    @objc func clickLeftBackButton(){
        self.navigationController?.popViewController(animated: true)
        tabBarController?.tabBar.isHidden = false
    }
    
    func ConfigUI() {
        view.addSubview(leftButton)
        self.view.addSubview(WhiteView)
        self.view.addSubview(scorelabel)
        self.view.addSubview(silkscorelabel)
        self.view.addSubview(signlabel)
        self.view.addSubview(signdatelabel)
        self.view.addSubview(DateView)
        self.view.addSubview(ScoreView)
        self.view.addSubview(LineView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
}
