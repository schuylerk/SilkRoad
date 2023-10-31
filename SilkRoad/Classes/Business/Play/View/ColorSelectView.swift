//
//  ColorSelectView.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/10/30.
//

import UIKit

class ColorSelectView: UIView, UITextFieldDelegate {
    
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var selectAlpha: CGFloat = 1
    var determineHandler: ((UIColor) -> Void)?
    var cancleHandler: (() -> Void)?
    
    lazy var showColorView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var showColorBgImageView: UIImageView = {
        let imgv = UIImageView()
        return imgv
    }()
    
    lazy var hexTextField: UITextField = {
        let tf = UITextField()
        tf.text = "000000"
        tf.textColor = .gray
        tf.font = .systemFont(ofSize: CGFloat(12.fw))
        tf.delegate = self
        return tf
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.text = "RGB"
        label.textColor = .gray
        label.font = .systemFont(ofSize: CGFloat(12.fw))
        label.textAlignment = .right
        return label
    }()
    
    lazy var redSlider: ColorSelectSlider = {
        let slider = ColorSelectSlider()
        slider.selectType = .red
        slider.colorChange = { [self] in
            red = $0
            let text = Int(red * 255).toHexString(length: 2) + Int(green * 255).toHexString(length: 2) + Int(blue * 255).toHexString(length: 2)
            hexTextField.text = text.uppercased()
            showColorView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: selectAlpha)
            greenSlider.updateColorView(red: red, green: green, blue: blue)
            blueSlider.updateColorView(red: red, green: green, blue: blue)
        }
        return slider
    }()
    
    lazy var greenSlider: ColorSelectSlider = {
        let slider = ColorSelectSlider()
        slider.selectType = .green
        slider.colorChange = { [self] in
            green = $0
            let text = Int(red * 255).toHexString(length: 2) + Int(green * 255).toHexString(length: 2) + Int(blue * 255).toHexString(length: 2)
            hexTextField.text = text.uppercased()
            showColorView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: selectAlpha)
            redSlider.updateColorView(red: red, green: green, blue: blue)
            blueSlider.updateColorView(red: red, green: green, blue: blue)
        }
        return slider
    }()
    
    lazy var blueSlider: ColorSelectSlider = {
        let slider = ColorSelectSlider()
        slider.selectType = .blue
        slider.colorChange = { [self] in
            blue = $0
            let text = Int(red * 255).toHexString(length: 2) + Int(green * 255).toHexString(length: 2) + Int(blue * 255).toHexString(length: 2)
            hexTextField.text = text.uppercased()
            showColorView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: selectAlpha)
            redSlider.updateColorView(red: red, green: green, blue: blue)
            greenSlider.updateColorView(red: red, green: green, blue: blue)
        }
        return slider
    }()
    
    lazy var alphaSlider: ColorSelectSlider = {
        let slider = ColorSelectSlider(frame: .zero)
        slider.selectType = .alpha
        slider.colorChange = { [self] in
            selectAlpha = $0
            showColorView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: selectAlpha)
        }
        return slider
    }()
    
    lazy var determineButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(determine), for: .touchUpInside)
        return button
    }()
    
    lazy var cancleButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(cancle), for: .touchUpInside)
        return button
    }()
    
    @objc func determine() {
        allResignFirstResponder()
        determineHandler?(UIColor(red: red, green: green, blue: blue, alpha: selectAlpha))
    }
    
    @objc func cancle() {
        allResignFirstResponder()
        cancleHandler?()
    }
    
    func allResignFirstResponder() {
        hexTextField.resignFirstResponder()
        redSlider.valueTextField.resignFirstResponder()
        greenSlider.valueTextField.resignFirstResponder()
        blueSlider.valueTextField.resignFirstResponder()
        alphaSlider.valueTextField.resignFirstResponder()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        var height = 0
        
        showColorView.frame = CGRect(x: 0, y: 0, width: Int(bounds.width), height: 150.fh)
        showColorView.backgroundColor = .black
        height += 150.fh
        
        showColorBgImageView.frame = CGRect(x: 0, y: 0, width: Int(bounds.width), height: 150.fh)
        showColorBgImageView.image = UIImage(named: "transparent.mesh.large")
        
        hexTextField.frame = CGRect(x: 20.fw, y: height + 10.fh, width: 100.fw, height: 15.fh)
        
        typeLabel.frame = CGRect(x: Int(bounds.width) - 120.fw, y: height + 10.fh, width: 100.fw, height: 15.fh)
        height += 25.fh
        
        redSlider.frame = CGRect(x: 20.fw, y: height + 20.fh, width: Int(bounds.width) - 40.fw, height: 18.fh)
        height += 38.fh
        
        greenSlider.frame = CGRect(x: 20.fw, y: height + 10.fh, width: Int(bounds.width) - 40.fw, height: 18.fh)
        height += 28.fh
        
        blueSlider.frame = CGRect(x: 20.fw, y: height + 10.fh, width: Int(bounds.width) - 40.fw, height: 18.fh)
        height += 28.fh
        
        alphaSlider.frame = CGRect(x: 20.fw, y: height + 10.fh, width: Int(bounds.width) - 40.fw, height: 18.fh)
        height += 28.fh
        
        determineButton.frame = CGRect(x: Int(bounds.width) - 38.fw, y: height + 30.fh, width: 18.fw, height: 18.fw)
        determineButton.setImage(UIImage(named: "selectcolor.determine"), for: .normal)
        
        cancleButton.frame = CGRect(x: 20.fw, y: height + 30.fh, width: 18.fw, height: 18.fw)
        cancleButton.setImage(UIImage(named: "selectcolor.cancle"), for: .normal)
        height += 30.fh + 18.fw
        
        addSubview(showColorBgImageView)
        addSubview(showColorView)
        addSubview(hexTextField)
        addSubview(typeLabel)
        addSubview(redSlider)
        addSubview(greenSlider)
        addSubview(blueSlider)
        addSubview(alphaSlider)
        addSubview(cancleButton)
        addSubview(determineButton)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, ("#" + text).isHexString() else { return true }
        let (r, g, b) = ("#" + text).getRGB()
        red = r / 255.0
        green = g / 255.0
        blue = b / 255.0
        redSlider.updateFromHex(red: red, green: green, blue: blue)
        greenSlider.updateFromHex(red: red, green: green, blue: blue)
        blueSlider.updateFromHex(red: red, green: green, blue: blue)
        showColorView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        textField.resignFirstResponder()
        return true
    }

}

class ColorSelectSlider: UIView, UITextFieldDelegate {
    enum SelectType {
        case red
        case green
        case blue
        case alpha
    }

    var value: Int = 0
    var selectType: SelectType = .red
    var beganPoint: CGPoint = .zero
    var colorChange: ((CGFloat) -> Void)?
    var colorLayer: ColorLayer?

    lazy var valueTextField: UITextField = {
        let tf = UITextField()
        tf.text = selectType == .alpha ? "100" : "0"
        tf.textColor = .gray
        tf.textAlignment = .right
        tf.font = .systemFont(ofSize: CGFloat(12.fw))
        tf.delegate = self
        return tf
    }()

    lazy var colorView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        return view
    }()

    lazy var thumbnailView: UIView = {
        let view = UIView()
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panThumbnail)))
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        valueTextField.frame = CGRect(x: Int(frame.width) - 40.fw, y: 0, width: 40.fw, height: Int(frame.height))
        colorView.frame = CGRect(x: 0, y: 0, width: frame.width - CGFloat(30.fw), height: frame.height)
        if selectType == .alpha {
            thumbnailView.frame = CGRect(x: colorView.bounds.width - bounds.height, y: 0, width: frame.height, height: frame.height)
        } else {
            thumbnailView.frame = CGRect(x: 0, y: 0, width: frame.height, height: frame.height)
        }
        thumbnailView.layer.cornerRadius = frame.height / 2
        
        var color: UIColor
        switch selectType {
        case .red:
            color = .red
        case .green:
            color = .green
        case .blue:
            color = .blue
        case .alpha:
            color = .clear
        }
        var colors: [CGColor]
        if selectType == .alpha {
            colors = [
                UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor,
                UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
            ]
        } else {
            colors = [
                UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor,
                color.cgColor
            ]
        }
        if selectType == .alpha {
            let imageView = UIImageView(frame: colorView.bounds)
            imageView.image = UIImage(named: "transparent.mesh")
            colorView.addSubview(imageView)
        }
        colorLayer = ColorLayer(CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5), colors: colors, locations: [0, 1])
        colorLayer!.frame = colorView.bounds
        colorView.layer.addSublayer(colorLayer!)
        colorView.layer.cornerRadius = frame.height / 2
        
        thumbnailView.backgroundColor = .clear
        thumbnailView.layer.borderWidth = 2
        thumbnailView.layer.borderColor = UIColor.white.cgColor

        addSubview(valueTextField)
        addSubview(colorView)
        colorView.addSubview(thumbnailView)
    }
    
    @objc func panThumbnail(gesture: UIPanGestureRecognizer) {
        let point = gesture.location(in: colorView)
        thumbnailView.center = CGPoint(x: max(bounds.height / 2, min(point.x, colorView.bounds.width - (bounds.height / 2))), y: bounds.height / 2)
        value = Int((thumbnailView.center.x - (bounds.height / 2)) / (colorView.bounds.width - bounds.height) * 255)
        if selectType == .alpha { value = Int(CGFloat(value) / 255.0 * 100) }
        valueTextField.text = "\(value)"
        if selectType == .alpha {
            colorChange?(CGFloat(value) / 100.0)
        } else {
            colorChange?(CGFloat(value) / 255.0)
        }
    }
    
    func updateColorView(red: CGFloat, green: CGFloat, blue: CGFloat) {
        colorLayer?.removeFromSuperlayer()
        var color1: UIColor
        var color2: UIColor
        switch selectType {
        case .red:
            color1 = UIColor(red: 0, green: green, blue: blue, alpha: 1)
            color2 = UIColor(red: 1, green: green, blue: blue, alpha: 1)
        case .green:
            color1 = UIColor(red: red, green: 0, blue: blue, alpha: 1)
            color2 = UIColor(red: red, green: 1, blue: blue, alpha: 1)
        case .blue:
            color1 = UIColor(red: red, green: green, blue: 0, alpha: 1)
            color2 = UIColor(red: red, green: green, blue: 1, alpha: 1)
        case .alpha:
            color1 = UIColor(red: red, green: green, blue: blue, alpha: 0)
            color2 = UIColor(red: red, green: green, blue: blue, alpha: 1)
        }
        colorLayer = ColorLayer(CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5), colors: [
            color1.cgColor,
            color2.cgColor
        ], locations: [0, 1])
        colorLayer!.frame = colorView.bounds
        colorView.layer.insertSublayer(colorLayer!, below: thumbnailView.layer)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, let value = Int(text), value >= 0 && value <= 255 else { return true }
        thumbnailView.center = CGPoint(x: CGFloat(value) / 255.0 * (colorView.bounds.width - bounds.height) + (bounds.height / 2), y: bounds.height / 2)
        colorChange?(CGFloat(value) / 255.0)
        textField.resignFirstResponder()
        return true
    }
    
    func updateFromHex(red: CGFloat, green: CGFloat, blue: CGFloat) {
        updateColorView(red: red, green: green, blue: blue)
        var value: CGFloat
        switch selectType {
        case .red:
            value = red
        case .green:
            value = green
        case .blue:
            value = blue
        case .alpha:
            value = 0
        }
        thumbnailView.center = CGPoint(x: value * (colorView.bounds.width - bounds.height) + (bounds.height / 2), y: bounds.height / 2)
        valueTextField.text = "\(Int(value * 255))"
    }
    
}
