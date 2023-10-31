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
    
    var cityName: String = ""
    
    var isCompleteAnswer: Bool = false
    
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
                let image: UIImage? = !isCompleteAnswer ? UIImage(named: "question_submit") : nil
                nextQuestionButton.setImage(image, for: .normal)
                nextQuestionButton.isEnabled = !isCompleteAnswer
            } else {
                nextQuestionButton.isEnabled = true
                nextQuestionButton.setImage(UIImage(named: "question_right"), for: .normal)
            }
            if isCompleteAnswer {
                answerLabel.text = "答案： " + questions[currentQuestionIndex].answer.name
            }
        }
    }
    
    var selectRecord: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = cityName + (isCompleteAnswer ? "-查看题目" : "-答题")
        navigationItem.leftBarButtonItem = UIBarButtonItem()
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 30.fw, height: 30.fw))
        let backImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30.fw, height: 30.fw))
        backImageView.image = UIImage(named: "back")
        backImageView.isUserInteractionEnabled = true
        backImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapBackButton)))
        customView.addSubview(backImageView)
        navigationItem.leftBarButtonItem?.customView = customView
        getQuestions {
            self.ConfigUI()
            self.selectRecord = Array(repeating: "", count: self.questions.count)
        }
    }
    
    @objc func tapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    lazy var QuestionLabel: UILabel = {
        let label = UILabel()
        label.text = "1." + (questions.first?.title ?? "")
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: CGFloat(20.fw))
        label.textColor = .black
        label.numberOfLines = 10
        return label
    }()
    
    lazy var AnswerALabel: UILabel = {
        let label = UILabel()
        label.text = questions.first?.options[0].content
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: CGFloat(18.fw))
        label.textColor = .black
        label.numberOfLines = 10
        return label
    }()
    
    lazy var AnswerBLabel: UILabel = {
        let label = UILabel()
        label.text = questions.first?.options[1].content
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: CGFloat(18.fw))
        label.textColor = .black
        label.numberOfLines = 10
        return label
    }()
    
    lazy var AnswerCLabel: UILabel = {
        let label = UILabel()
        label.text = questions.first?.options[2].content
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: CGFloat(18.fw))
        label.textColor = .black
        label.numberOfLines = 10
        return label
    }()
    
    lazy var AnswerDLabel: UILabel = {
        let label = UILabel()
        label.text = questions.first?.options[3].content
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: CGFloat(18.fw))
        label.textColor = .black
        label.numberOfLines = 10
        return label
    }()
    
    lazy var lastQuestionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "question_left"), for: .normal)
        button.addTarget(self, action: #selector(lastHandler), for: .touchUpInside)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        return button
    }()
    
    lazy var nextQuestionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "question_right"), for: .normal)
        button.addTarget(self, action: #selector(nextHandler), for: .touchUpInside)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        return button
    }()
    
    lazy var blackButton: UIButton = {
        let button = UIButton(frame: view.bounds)
        button.backgroundColor = .black
        button.alpha = 0.5
        button.isHidden = true
        button.addTarget(self, action: #selector(tapBlackButton), for: .touchUpInside)
        return button
    }()
    
    lazy var goadLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: Int(screenWidth)/2-100.fw, y: Int(screenHeight)/2+120.fw, width: 200.fw, height: 40.fh))
        label.textAlignment = .center
        label.textColor = .white
        label.layer.shadowColor = UIColor(hex: "#FFCCA3").cgColor
        label.layer.shadowOpacity = 1
        label.font = .systemFont(ofSize: CGFloat(20.fw))
        label.isHidden = true
        return label
    }()
    
    lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.text = "答案： " + questions[0].answer.name
        return label
    }()
    
    lazy var specialLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: Int(screenHeight) / 2 + 200.fw, width: Int(screenWidth), height: 100.fh))
        label.text = "恭喜通关！\n\n在岁月的长河中，人好比流星\n文化传承的意义，相当于把流星雨录下来反复播放。"
        label.isHidden = true
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(hex: "#FFCCA3")
        return label
    }()
    
    @objc func tapBlackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    lazy var goadImageView: UIImageView = {
        let imgV = UIImageView(frame: CGRect(x: Int(screenWidth)/2 - 100.fw, y: Int(screenHeight)/2 - 100.fw, width: 200.fw, height: 200.fw))
        imgV.image = UIImage(named: getGoadName())
        imgV.isHidden = true
        return imgV
    }()
    
    func getGoadName() -> String {
        switch cityName {
        case "西安":
            return "xagoad"
        case "兰州":
            return "lzgoad"
        case "乌鲁木齐":
            return "wlmqgoad"
        case "西宁":
            return "xngoad"
        case "敦煌":
            return "dhgoad"
        default:
            return ""
        }
    }
    
    @objc func lastHandler() {
        currentQuestionIndex = currentQuestionIndex <= 1 ? 0 : currentQuestionIndex-1
    }
    
    @objc func nextHandler() {
        if currentQuestionIndex == questions.count - 1 {
            if let _ = selectRecord.firstIndex(where: {$0==""}) {
                let alterController = UIAlertController(title: "提示", message: "有题目未完成", preferredStyle: .alert)
                present(alterController, animated: true, completion: {
                    self.dismiss(animated: true, completion: nil)
                })
                return
            }
            let score = getScore()
            if score == 100 {
                blackButton.isHidden = false
                goadImageView.isHidden = false
                goadImageView.frame = CGRect(x: screenWidth/2, y: screenHeight/2, width: 0, height: 0)
                UIView.animate(withDuration: 0.5, animations: { [self] in
                    goadImageView.frame = CGRect(x: screenWidth/2 - 100, y: screenHeight/2 - 100, width: 200, height: 200)
                }, completion: { [self] _ in
                    goadLabel.text = "获取勋章-" + cityName
                    goadLabel.isHidden = false
                })
                saveBadge(cityName)
                if let badges = getBadge(), badges.count == 5 {
                    specialLabel.isHidden = false
                }
            } else {
                var message = "\n"
                for i in 0..<selectRecord.count {
                    message += "\(i+1).  " + selectRecord[i]
                    message += ((selectRecord[i]==questions[i].answer.name) ? "  ✅" : ("  ❌")) + "   答案: " + questions[i].answer.name + "\n\n"
                }
                let alterController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
                let quitAction = UIAlertAction(title: "退出答题", style: .default, handler: { [self] _ in
                    navigationController?.popViewController(animated: true)
                })
                let continueAction = UIAlertAction(title: "继续答题", style: .default, handler: { [self] _ in
                    dismiss(animated: true, completion: nil)
                })
                alterController.addAction(quitAction)
                alterController.addAction(continueAction)
                present(alterController, animated: true, completion: nil)
            }
            return
        }
        currentQuestionIndex = (currentQuestionIndex >= questions.count-2 ? questions.count-1 : currentQuestionIndex+1)
    }
    
    func getScore() -> Float {
        var score: Float = 0.0
        var num = 0
        for i in 0..<selectRecord.count {
            if selectRecord[i] != "" && selectRecord[i] == questions[i].answer.name {
                num += 1
            }
        }
        score = Float(num) / Float(selectRecord.count) * 100.0
        return score
    }
    
    lazy var AnswerAView: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = CGFloat(17.fw)
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.borderWidth = 0.5
        button.backgroundColor = .clear
        button.setTitle("A", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapOption(button:)), for: .touchUpInside)
        button.isEnabled = !isCompleteAnswer
        return button
    }()
    
    lazy var AnswerBView: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = CGFloat(17.fw)
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.borderWidth = 0.5
        button.backgroundColor = .clear
        button.setTitle("B", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapOption(button:)), for: .touchUpInside)
        button.isEnabled = !isCompleteAnswer
        return button
    }()
    
    lazy var AnswerCView: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = CGFloat(17.fw)
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.borderWidth = 0.5
        button.backgroundColor = .clear
        button.setTitle("C", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapOption(button:)), for: .touchUpInside)
        button.isEnabled = !isCompleteAnswer
        return button
    }()
    
    lazy var AnswerDView: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = CGFloat(17.fw)
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.borderWidth = 0.5
        button.backgroundColor = .clear
        button.setTitle("D", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapOption(button:)), for: .touchUpInside)
        button.isEnabled = !isCompleteAnswer
        return button
    }()
    
    @objc func tapOption(button: UIButton) {
        guard let optionName = button.titleLabel?.text else { return }
        setOptionButtonColor(optionName)
    }
    
    func setOptionButtonColor(_ optionName: String) {
        var bgColors: [UIColor] = [.clear, .clear, .clear, .clear]
        var titleColors: [UIColor] = [.black, .black, .black, .black]
        switch optionName {
        case "A":
            bgColors[0] = UIColor(hex: "#FF9D4F")
            titleColors[0] = .white
        case "B":
            bgColors[1] = UIColor(hex: "#FF9D4F")
            titleColors[1] = .white
        case "C":
            bgColors[2] = UIColor(hex: "#FF9D4F")
            titleColors[2] = .white
        case "D":
            bgColors[3] = UIColor(hex: "#FF9D4F")
            titleColors[3] = .white
        default:
            break
        }
        changeOptionButtonColor(AnswerAView, backgroundColor: bgColors[0], titleColor: titleColors[0])
        changeOptionButtonColor(AnswerBView, backgroundColor: bgColors[1], titleColor: titleColors[1])
        changeOptionButtonColor(AnswerCView, backgroundColor: bgColors[2], titleColor: titleColors[2])
        changeOptionButtonColor(AnswerDView, backgroundColor: bgColors[3], titleColor: titleColors[3])
        if optionName != "" { selectRecord[currentQuestionIndex] = optionName }
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
        view.addSubview(blackButton)
        view.addSubview(goadImageView)
        view.addSubview(goadLabel)
        view.addSubview(specialLabel)
        if isCompleteAnswer {
            view.addSubview(answerLabel)
        }
        
        QuestionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.fw)
            make.right.equalToSuperview().offset(-20.fw)
            make.top.equalToSuperview().offset(200.fh)
            make.height.equalTo(100.fh)
        }
        
        AnswerAView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(50.fw)
            make.width.equalTo(34.fw)
            make.top.equalTo(QuestionLabel.snp.bottom).offset(15.fh)
            make.height.equalTo(34.fw)
        }
        
        AnswerBView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(50.fw)
            make.width.equalTo(34.fw)
            make.top.equalTo(AnswerAView.snp.bottom).offset(20.fh)
            make.height.equalTo(34.fw)
        }
        
        AnswerCView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(50.fw)
            make.width.equalTo(34.fw)
            make.top.equalTo(AnswerBView.snp.bottom).offset(20.fh)
            make.height.equalTo(34.fw)
        }
        
        AnswerDView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(50.fw)
            make.width.equalTo(34.fw)
            make.top.equalTo(AnswerCView.snp.bottom).offset(20.fh)
            make.height.equalTo(34.fw)
        }
        
        AnswerALabel.snp.makeConstraints { make in
            make.left.equalTo(AnswerAView.snp.right).offset(20.fw)
            make.right.equalToSuperview().offset(-30.fw)
            make.top.equalTo(AnswerAView.snp.top)
        }
        
        AnswerBLabel.snp.makeConstraints { make in
            make.left.equalTo(AnswerBView.snp.right).offset(20.fw)
            make.top.equalTo(AnswerBView.snp.top)
            make.right.equalToSuperview().offset(-30.fw)
        }
        
        AnswerCLabel.snp.makeConstraints { make in
            make.left.equalTo(AnswerCView.snp.right).offset(20.fw)
            make.top.equalTo(AnswerCView.snp.top).offset(0)
            make.right.equalToSuperview().offset(-30.fw)
        }
        
        AnswerDLabel.snp.makeConstraints { make in
            make.left.equalTo(AnswerDView.snp.right).offset(20.fw)
            make.top.equalTo(AnswerDView.snp.top).offset(0)
            make.right.equalToSuperview().offset(-30.fw)
        }
        
        lastQuestionButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40.fw)
            make.width.equalTo(25.fw)
            make.top.equalTo(AnswerDView.snp.bottom).offset(50.fh)
            make.height.equalTo(25.fw)
        }
        
        nextQuestionButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-40.fw)
            make.width.equalTo(25.fw)
            make.top.equalTo(lastQuestionButton).offset(0)
            make.height.equalTo(25.fw)
        }
        if isCompleteAnswer {
            answerLabel.snp.makeConstraints { maker in
                maker.left.equalTo(lastQuestionButton)
                maker.top.equalTo(lastQuestionButton.snp.bottom).offset(20.fh)
                maker.width.equalTo(200.fw)
                maker.height.equalTo(30.fh)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func getQuestions(_ completion: @escaping () -> Void) {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "questions", ofType: "json")!))
            guard let jsonString = String(data: data, encoding: .utf8) else { return }
            guard let jsonArray = JSON(parseJSON: jsonString)[cityName].array else { return }
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