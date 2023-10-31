//
//  IntroduceObjectViewController.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/29.
//

import UIKit
import SnapKit

class IntroduceObjectViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    lazy var colorLayer: ColorLayer = {
        let layer = ColorLayer(
            CGPoint(x: 0.5, y: 0),
            endPoint: CGPoint(x: 0.5, y: 1.0),
            colors: [UIColor(hex: "#FFCCA3").cgColor, UIColor(hex: "#F8F8F8").cgColor],
            locations: [0, 0.5])
        layer.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        return layer
    }()
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.frame = CGRect(x: 20.fw, y: 50.fh, width: 30.fw, height: 30.fw)
        button.addTarget(self, action: #selector(clickLeftBackButton), for: .touchUpInside)
        return button
    }()
    
    @objc func clickLeftBackButton(){
        navigationController?.popViewController(animated: true)
    }
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: CGFloat(20.fw))
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.text = "出土年份："
        label.font = UIFont.init(name: "Source Han Serif CN", size: CGFloat(10.fw))
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var placeLabel: UILabel = {
        let label = UILabel()
        label.text = "出土地点："
        label.font = UIFont.init(name: "Source Han Serif CN", size: CGFloat(10.fw))
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var yearslabel: UILabel = {
        let label = UILabel()
        label.text = "所属朝代："
        label.font = UIFont.init(name: "Source Han Serif CN", size: CGFloat(10.fw))
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var faceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    lazy var introduceScrollView: UIScrollView = {
        let sclv = UIScrollView(frame: CGRect(x: 20.fw, y: 350.fh, width: Int(screenWidth) - 40.fw, height: Int(screenHeight) - 380.fh))
        sclv.addSubview(introduceLabel)
        sclv.showsVerticalScrollIndicator = false
        sclv.showsHorizontalScrollIndicator = false
        return sclv
    }()
    
    lazy var introduceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    func configUI() {
        view.layer.addSublayer(colorLayer)
        view.addSubview(leftButton)
        view.addSubview(faceImageView)
        view.addSubview(nameLabel)
        view.addSubview(yearLabel)
        view.addSubview(placeLabel)
        view.addSubview(yearslabel)
        view.addSubview(introduceScrollView)
        faceImageView.snp.makeConstraints { maker in
            maker.left.equalTo(leftButton)
            maker.width.height.equalTo(160.fw)
            maker.top.equalTo(leftButton.snp.bottom).offset(20.fh)
        }
        nameLabel.snp.makeConstraints { maker in
            maker.left.equalTo(faceImageView.snp.right).offset(20.fw)
            maker.top.equalTo(faceImageView)
            maker.right.equalToSuperview().offset(-20.fw)
        }
        yearLabel.snp.makeConstraints { make in
            make.left.right.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(30.fh)
        }
        placeLabel.snp.makeConstraints { make in
            make.left.right.equalTo(yearLabel)
            make.top.equalTo(yearLabel.snp.bottom).offset(10.fh)
        }
        yearslabel.snp.makeConstraints { make in
            make.left.right.equalTo(placeLabel)
            make.top.equalTo(placeLabel.snp.bottom).offset(10.fh)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    func updateUI(data: CultureRelic){
        nameLabel.text = data.name
        yearLabel.attributedText = addAttributes("出土年份：" + data.unearthedYear)
        placeLabel.attributedText = addAttributes("出土地点：" + data.unearthPlace)
        yearslabel.attributedText = addAttributes("所属朝代：" + data.dynasty)
        
        let text = data.intro + "\n" + data.history
        let attributedText = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        paragraphStyle.paragraphSpacing = 10
        paragraphStyle.firstLineHeadIndent = 4
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: text.count))
        introduceLabel.attributedText = attributedText
        let forBounds = CGRect(x: 0, y: 0, width: screenWidth - CGFloat(40.fw), height: CGFloat.greatestFiniteMagnitude)
        let rect = introduceLabel.textRect(forBounds: forBounds, limitedToNumberOfLines: 0)
        introduceScrollView.contentSize = rect.size
        introduceLabel.frame.origin = .zero
        introduceLabel.frame.size = introduceScrollView.contentSize
    }
    
    func addAttributes(_ text: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor, value: UIColor(red: 0, green: 0, blue: 0, alpha: 0.8), range: NSRange(location: 0, length: 5))
        attributedText.addAttribute(.foregroundColor, value: UIColor(red: 0, green: 0, blue: 0, alpha: 0.6), range: NSRange(location: 5, length: text.count - 5))
        attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: CGFloat(15.fw)), range: NSRange(location: 0, length: text.count))
        return attributedText
    }
    

}
