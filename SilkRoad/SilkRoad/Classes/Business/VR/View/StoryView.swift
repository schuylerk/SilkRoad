//
//  StoryView.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/8/20.
//

import UIKit

class StoryView: UIView {

    var titleLabel: UILabel!
    
    var imageView: UIImageView!
    
    var textLabels: [UILabel] = []
    
    lazy var colorLayer: ColorLayer = {
        let layer = ColorLayer(
            CGPoint(x: 0.5, y: 0),
            endPoint: CGPoint(x: 0.5, y: 1.0),
            colors: [UIColor(hex: "#FFCCA3").cgColor, UIColor(hex: "#F8F8F8").cgColor],
            locations: [0, 0.5])
        layer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        return layer
    }()
    
    lazy var scrollView: UIScrollView = {
        let scv = UIScrollView(frame: bounds)
        return scv
    }()
    
    func config(content: String) {
        layer.addSublayer(colorLayer)
        let titlePattern = "#+.*"
        var totleHeight = 0
        if let titleResult = getStringWithPattern(pattern: titlePattern, in: content) {
            let title = String(titleResult.split(separator: " ")[1].split(separator: "*")[0])
            titleLabel = UILabel(frame: CGRect(x: 20.fw, y: 30.fh, width: Int(bounds.width)-40.fw, height: 30.fh))
            titleLabel.text = title
            titleLabel.font = .systemFont(ofSize: CGFloat(25.fw))
            scrollView.addSubview(titleLabel)
            totleHeight = Int(titleLabel.frame.minY + titleLabel.frame.height)
        }
        let imgNamePattern = "\\!\\[.*\\]"
        if let imgNameResult = getStringWithPattern(pattern: imgNamePattern, in: content) {
            let imgName = String(imgNameResult.split(separator: "[")[1].split(separator: "]")[0])
            let image = UIImage(named: imgName)
            imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            if let size = image?.size {
                let ratio = size.height/size.width
                let maxWidth = Int(screenWidth)-40.fw
                imageView.frame = CGRect(x: 20.fw, y: 80.fh, width:maxWidth, height: Int(CGFloat(maxWidth)*ratio))
                scrollView.addSubview(imageView)
                totleHeight = Int(imageView.frame.minY + imageView.frame.height)
            }
        }
        let allContent = content.split(separator: "\n").map { substr in
            return String(substr)
        }
        for i in 2..<allContent.count {
            let label = UILabel()
            label.text = allContent[i]
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            let rect = label.textRect(forBounds: CGRect(x: 0, y: 0, width: screenWidth-CGFloat(40.fw), height: CGFloat.greatestFiniteMagnitude), limitedToNumberOfLines: 0)
            label.frame = CGRect(x: CGFloat(20.fw), y: CGFloat(totleHeight+20.fw), width: rect.width, height: rect.height)
            scrollView.addSubview(label)
            textLabels.append(label)
            totleHeight = Int(label.frame.minY + label.frame.height)
        }
        scrollView.contentSize = CGSize(width: Int(bounds.width), height: totleHeight)
        addSubview(scrollView)
    }
    
    func getStringWithPattern(pattern: String, in content: String) -> String? {
        do {
            let regularExpr = try NSRegularExpression(pattern: pattern, options: [])
            let result = regularExpr.firstMatch(in: content, options: [], range: NSRange(location: 0, length: content.count))
            if let range = result?.range {
                var resultString = ""
                for i in range.lowerBound...range.upperBound {
                    resultString += String(content[content.index(content.startIndex, offsetBy: i)])
                }
                return resultString
            }
        } catch {
            print(error)
            return nil
        }
        return nil
    }
    
    func clear() {
        colorLayer.removeFromSuperlayer()
        if titleLabel != nil {
            titleLabel.removeFromSuperview()
            titleLabel = nil
        }
        if imageView != nil {
            imageView.removeFromSuperview()
            imageView = nil
        }
        textLabels.forEach { label in
            label.removeFromSuperview()
        }
        textLabels = []
    }

}
