//
//  AnswerViewController.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/29.
//

import UIKit

class AnswerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "答题闯关"
        ConfigUI()
        // Do any additional setup after loading the view.
    }
    
    lazy var OrangeView:UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "orangeback")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        return imageView
    }()

    lazy var OrangeLabel: UILabel = {
        let label = UILabel()
        label.text = "敦煌"
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 20)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    lazy var QuestionLabel: UILabel = {
        let label = UILabel()
        label.text = "1.莫高窟，意为开凿于沙漠高处的石窟，同时也称（        ）。"
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 20)
        label.textColor = .black
        label.numberOfLines = 10
        return label
    }()
    
    lazy var AnswerALabel: UILabel = {
        let label = UILabel()
        label.text = "千佛洞"
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.textColor = .black
        label.numberOfLines = 10
        return label
    }()
    
    lazy var AnswerBLabel: UILabel = {
        let label = UILabel()
        label.text = "水帘洞"
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.textColor = .black
        label.numberOfLines = 10
        return label
    }()
    
    lazy var AnswerCLabel: UILabel = {
        let label = UILabel()
        label.text = "难受想窟"
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.textColor = .black
        label.numberOfLines = 10
        return label
    }()
    
    lazy var AnswerDLabel: UILabel = {
        let label = UILabel()
        label.text = "海蚀洞"
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.textColor = .black
        label.numberOfLines = 10
        return label
    }()
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "<<上一题"
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 19)
        label.textColor = UIColor(red: 1, green: 0.552, blue: 0.2, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var nextDLabel: UILabel = {
        let label = UILabel()
        label.text = "下一题>>"
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 19)
        label.textColor = UIColor(red: 1, green: 0.552, blue: 0.2, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var AnswerAView:UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "answer-a")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var AnswerBView:UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "answer-b")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var AnswerCView:UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "answer-c")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var AnswerDView:UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "answer-d")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    func ConfigUI() {
        self.view.addSubview(OrangeView)
        OrangeView.addSubview(OrangeLabel)
        self.view.addSubview(QuestionLabel)
        self.view.addSubview(AnswerAView)
        self.view.addSubview(AnswerBView)
        self.view.addSubview(AnswerCView)
        self.view.addSubview(AnswerDView)
        self.view.addSubview(topLabel)
        self.view.addSubview(nextDLabel)
        self.view.addSubview(AnswerALabel)
        self.view.addSubview(AnswerBLabel)
        self.view.addSubview(AnswerCLabel)
        self.view.addSubview(AnswerDLabel)
        
        OrangeView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(0)
            make.width.equalTo(60)
            make.top.equalToSuperview().offset(120)
            make.height.equalTo(37)
        }
        
        OrangeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.width.equalToSuperview()
            make.top.equalToSuperview().offset(3)
            make.height.equalToSuperview()
        }
        
        QuestionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(OrangeView.snp.bottom).offset(35)
            make.height.equalTo(100)
        }
        
        AnswerAView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(50)
            make.width.equalTo(35)
            make.top.equalTo(QuestionLabel.snp.bottom).offset(15)
            make.height.equalTo(35)
        }
        
        AnswerBView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(50)
            make.width.equalTo(35)
            make.top.equalTo(AnswerAView.snp.bottom).offset(20)
            make.height.equalTo(35)
        }
        
        AnswerCView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(50)
            make.width.equalTo(35)
            make.top.equalTo(AnswerBView.snp.bottom).offset(20)
            make.height.equalTo(35)
        }
        
        AnswerDView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(50)
            make.width.equalTo(35)
            make.top.equalTo(AnswerCView.snp.bottom).offset(20)
            make.height.equalTo(35)
        }
        
        AnswerALabel.snp.makeConstraints { make in
            make.left.equalTo(AnswerAView.snp.right).offset(20)
            make.width.equalTo(100)
            make.top.equalTo(AnswerAView.snp.top).offset(0)
            make.height.equalTo(35)
        }
        
        AnswerBLabel.snp.makeConstraints { make in
            make.left.equalTo(AnswerBView.snp.right).offset(20)
            make.width.equalTo(100)
            make.top.equalTo(AnswerBView.snp.top).offset(0)
            make.height.equalTo(35)
        }
        
        AnswerCLabel.snp.makeConstraints { make in
            make.left.equalTo(AnswerCView.snp.right).offset(20)
            make.width.equalTo(100)
            make.top.equalTo(AnswerCView.snp.top).offset(0)
            make.height.equalTo(35)
        }
        
        AnswerDLabel.snp.makeConstraints { make in
            make.left.equalTo(AnswerDView.snp.right).offset(20)
            make.width.equalTo(100)
            make.top.equalTo(AnswerDView.snp.top).offset(0)
            make.height.equalTo(35)
        }
        
        topLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(100)
            make.top.equalTo(AnswerDView.snp.bottom).offset(50)
            make.height.equalTo(50)
        }
        
        nextDLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(100)
            make.top.equalTo(topLabel).offset(0)
            make.height.equalTo(50)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
}
