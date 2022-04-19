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
    
        self.title = "积分中心"
        ConfigUI()
    }
    
    lazy var WhiteView: UIView = {
        let layerView = UIView()
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.23).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        layerView.frame = CGRect(x: 20, y: 106, width: 390, height: 100)
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
        label.frame = CGRect(x: 82, y: 165, width: 100, height: 16)
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 14)
        label.textColor = UIColor(red: 0.312, green: 0.312, blue: 0.312, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var signlabel: UILabel = {
        let label = UILabel()
        label.text = "签到领积分"
        label.frame = CGRect(x: 280, y: 135, width: 120, height: 19)
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var signdatelabel: UILabel = {
        let label = UILabel()
        label.text = "已连续签到\(1)天"
        label.frame = CGRect(x: 280, y: 157, width: 100, height: 13)
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 12)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var DateView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Date"))
        imageView.frame = CGRect(x: 221, y: 134, width: 50, height: 50)
        return imageView
    }()
    
    lazy var LineView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "line"))
        imageView.frame = CGRect(x: 200, y: 134, width: 5, height: 50)
        return imageView
    }()
    
    lazy var ScoreView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Score"))
        imageView.frame = CGRect(x: 10, y: 225, width: 400, height: 251)
        return imageView
    }()

    lazy var recomendlabel: UILabel = {
        let label = UILabel()
        label.text = "推荐"
        label.frame = CGRect(x: 25, y: 479, width: 200, height: 30)
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 22)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
 
    
    func ConfigUI() {
        self.view.addSubview(WhiteView)
        self.view.addSubview(scorelabel)
        self.view.addSubview(silkscorelabel)
        self.view.addSubview(signlabel)
        self.view.addSubview(signdatelabel)
        self.view.addSubview(DateView)
        self.view.addSubview(ScoreView)
        self.view.addSubview(recomendlabel)
        self.view.addSubview(LineView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
}
