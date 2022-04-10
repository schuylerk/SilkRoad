//
//  AnswerViewController.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/29.
//

import UIKit
import SnapKit
import SwiftyJSON

class AnswerViewController: UIViewController {
    
    var questions: [Question] = []
    
    var currentQuestionIndex: Int = 0 {
        didSet {
            QuestionLabel.text = "\(currentQuestionIndex+1)." + questions[currentQuestionIndex].title
            AnswerALabel.text = questions[currentQuestionIndex].options[0].content
            AnswerBLabel.text = questions[currentQuestionIndex].options[1].content
            AnswerCLabel.text = questions[currentQuestionIndex].options[2].content
            AnswerDLabel.text = questions[currentQuestionIndex].options[3].content
            if selectRecord[currentQuestionIndex] != "" {
                setOptionButtonColor(selectRecord[currentQuestionIndex])
            } else {
                setOptionButtonColor("")
            }
            if currentQuestionIndex == questions.count-1 {
                nextQuestionButton.setTitle("提交", for: .normal)
            } else {
                nextQuestionButton.setTitle("下一题>>", for: .normal)
            }
        }
    }
    
    var selectRecord: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "答题闯关"
        getQuestions {
            self.ConfigUI()
            self.selectRecord = Array(repeating: "", count: self.questions.count)
        }
        // Do any additional setup after loading the view.
    }
    
    lazy var QuestionLabel: UILabel = {
        let label = UILabel()
        label.text = "1." + (questions.first?.title ?? "")
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 20)
        label.textColor = .black
        label.numberOfLines = 10
        return label
    }()
    
    lazy var AnswerALabel: UILabel = {
        let label = UILabel()
        label.text = questions.first?.options[0].content
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.textColor = .black
        label.numberOfLines = 10
        return label
    }()
    
    lazy var AnswerBLabel: UILabel = {
        let label = UILabel()
        label.text = questions.first?.options[1].content
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.textColor = .black
        label.numberOfLines = 10
        return label
    }()
    
    lazy var AnswerCLabel: UILabel = {
        let label = UILabel()
        label.text = questions.first?.options[2].content
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.textColor = .black
        label.numberOfLines = 10
        return label
    }()
    
    lazy var AnswerDLabel: UILabel = {
        let label = UILabel()
        label.text = questions.first?.options[3].content
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.textColor = .black
        label.numberOfLines = 10
        return label
    }()
    
    lazy var lastQuestionButton: UIButton = {
        let button = UIButton()
        button.setTitle("<<上一题", for: .normal)
        button.setTitleColor(UIColor(hex: "#FF9D4F"), for: .normal)
        button.addTarget(self, action: #selector(lastHandler), for: .touchUpInside)
        return button
    }()
    
    lazy var nextQuestionButton: UIButton = {
        let button = UIButton()
        button.setTitle("下一题>>", for: .normal)
        button.setTitleColor(UIColor(hex: "#FF9D4F"), for: .normal)
        button.addTarget(self, action: #selector(nextHandler), for: .touchUpInside)
        return button
    }()
    
    @objc func lastHandler() {
        currentQuestionIndex = currentQuestionIndex <= 1 ? 0 : currentQuestionIndex-1
    }
    
    @objc func nextHandler() {
        if currentQuestionIndex == questions.count - 1 {
            let score = getScore()
            let integral = Int(5*score/100.0)
            if let value = UserDefaults.standard.value(forKey: "silkintegral") as? Int {
                UserDefaults.standard.set(value + integral, forKey: "silkintegral")
            } else {
                UserDefaults.standard.set(integral, forKey: "silkintegral")
            }
            let alert = UIAlertController(title: "得分", message: "题目得分：\(score)\n丝绸积分：\(integral)", preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "关闭", style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            })
            alert.addAction(closeAction)
            self.present(alert, animated: true, completion: nil)
        }
        currentQuestionIndex = (currentQuestionIndex >= questions.count-2 ? questions.count-1 : currentQuestionIndex+1)
    }
    
    func getScore() -> Float {
        var score: Float = 0.0
        for i in 0..<selectRecord.count {
            if selectRecord[i] != "" && selectRecord[i] == questions[i].answer.name {
                score += 100.0 / Float(questions.count)
            }
        }
        return score
    }
    
    lazy var AnswerAView: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 17.5
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.borderWidth = 0.5
        button.backgroundColor = .clear
        button.setTitle("A", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapOption(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var AnswerBView: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 17.5
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.borderWidth = 0.5
        button.backgroundColor = .clear
        button.setTitle("B", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapOption(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var AnswerCView: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 17.5
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.borderWidth = 0.5
        button.backgroundColor = .clear
        button.setTitle("C", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapOption(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var AnswerDView: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 17.5
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.borderWidth = 0.5
        button.backgroundColor = .clear
        button.setTitle("D", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapOption(button:)), for: .touchUpInside)
        return button
    }()
    
    @objc func tapOption(button: UIButton) {
        guard let optionName = button.titleLabel?.text else { return }
        setOptionButtonColor(optionName)
    }
    
    func setOptionButtonColor(_ optionName: String) {
        switch optionName {
        case "A":
            changeOptionButtonColor(AnswerAView, backgroundColor: UIColor(hex: "#FF9D4F"), titleColor: .white)
            changeOptionButtonColor(AnswerBView, backgroundColor: .clear, titleColor: .black)
            changeOptionButtonColor(AnswerCView, backgroundColor: .clear, titleColor: .black)
            changeOptionButtonColor(AnswerDView, backgroundColor: .clear, titleColor: .black)
            selectRecord[currentQuestionIndex] = "A"
        case "B":
            changeOptionButtonColor(AnswerBView, backgroundColor: UIColor(hex: "#FF9D4F"), titleColor: .white)
            changeOptionButtonColor(AnswerAView, backgroundColor: .clear, titleColor: .black)
            changeOptionButtonColor(AnswerCView, backgroundColor: .clear, titleColor: .black)
            changeOptionButtonColor(AnswerDView, backgroundColor: .clear, titleColor: .black)
            selectRecord[currentQuestionIndex] = "B"
        case "C":
            changeOptionButtonColor(AnswerCView, backgroundColor: UIColor(hex: "#FF9D4F"), titleColor: .white)
            changeOptionButtonColor(AnswerBView, backgroundColor: .clear, titleColor: .black)
            changeOptionButtonColor(AnswerAView, backgroundColor: .clear, titleColor: .black)
            changeOptionButtonColor(AnswerDView, backgroundColor: .clear, titleColor: .black)
            selectRecord[currentQuestionIndex] = "C"
        case "D":
            changeOptionButtonColor(AnswerDView, backgroundColor: UIColor(hex: "#FF9D4F"), titleColor: .white)
            changeOptionButtonColor(AnswerBView, backgroundColor: .clear, titleColor: .black)
            changeOptionButtonColor(AnswerCView, backgroundColor: .clear, titleColor: .black)
            changeOptionButtonColor(AnswerAView, backgroundColor: .clear, titleColor: .black)
            selectRecord[currentQuestionIndex] = "D"
        default:
            changeOptionButtonColor(AnswerCView, backgroundColor: .clear, titleColor: .black)
            changeOptionButtonColor(AnswerBView, backgroundColor: .clear, titleColor: .black)
            changeOptionButtonColor(AnswerAView, backgroundColor: .clear, titleColor: .black)
            changeOptionButtonColor(AnswerDView, backgroundColor: .clear, titleColor: .black)
        }
    }
    
    func changeOptionButtonColor(_ button: UIButton, backgroundColor: UIColor, titleColor: UIColor) {
        button.backgroundColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
    }
    
    func ConfigUI() {
        self.view.addSubview(QuestionLabel)
        self.view.addSubview(AnswerAView)
        self.view.addSubview(AnswerBView)
        self.view.addSubview(AnswerCView)
        self.view.addSubview(AnswerDView)
        self.view.addSubview(lastQuestionButton)
        self.view.addSubview(nextQuestionButton)
        self.view.addSubview(AnswerALabel)
        self.view.addSubview(AnswerBLabel)
        self.view.addSubview(AnswerCLabel)
        self.view.addSubview(AnswerDLabel)
        
        QuestionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(200)
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
            make.right.equalToSuperview().offset(-30.fw)
            make.top.equalTo(AnswerAView.snp.top).offset(0)
        }
        
        AnswerBLabel.snp.makeConstraints { make in
            make.left.equalTo(AnswerBView.snp.right).offset(20)
            make.width.equalTo(100)
            make.top.equalTo(AnswerBView.snp.top).offset(0)
            make.right.equalToSuperview().offset(-30.fw)
        }
        
        AnswerCLabel.snp.makeConstraints { make in
            make.left.equalTo(AnswerCView.snp.right).offset(20)
            make.width.equalTo(100)
            make.top.equalTo(AnswerCView.snp.top).offset(0)
            make.right.equalToSuperview().offset(-30.fw)
        }
        
        AnswerDLabel.snp.makeConstraints { make in
            make.left.equalTo(AnswerDView.snp.right).offset(20)
            make.width.equalTo(100)
            make.top.equalTo(AnswerDView.snp.top).offset(0)
            make.right.equalToSuperview().offset(-30.fw)
        }
        
        lastQuestionButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(100)
            make.top.equalTo(AnswerDView.snp.bottom).offset(50)
            make.height.equalTo(50)
        }
        
        nextQuestionButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(100)
            make.top.equalTo(lastQuestionButton).offset(0)
            make.height.equalTo(50)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func getQuestions(_ completion: @escaping (() -> Void)) {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "questions", ofType: "json")!))
            guard let jsonString = String(data: data, encoding: .utf8) else { return }
            guard let jsonArray = JSON(parseJSON: jsonString).array else { return }
            questions = jsonArray.map { json -> Question in
                return Question(
                    title: json["title"].stringValue,
                    options: json["options"].array!.map { json -> Option in
                        return Option(name: json["name"].stringValue, content: json["content"].stringValue)
                    },
                    answer: Option(name: json["answer"]["name"].stringValue))
            }
            completion()
        } catch {
            
        }
    }
    
}
