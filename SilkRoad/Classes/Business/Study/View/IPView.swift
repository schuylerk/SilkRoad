//
//  IPView.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/8/21.
//

import UIKit

class IPView: UIView {
    enum TextPosition {
        case left
        case right
    }
    
    var textPosition: TextPosition = .left
    
    var animateImageView: UIImageView!
    
    var textLabel: UILabel!
    
    var contentView: UIView!
    
    var text: String!
    
    func display() {
        let positionIsLeft = (textPosition == .left)
        let imgvWidth = 60.fw
        animateImageView = UIImageView(
            frame: CGRect(
                x: Int(positionIsLeft ? bounds.width-CGFloat(imgvWidth) : 0),
                y: (Int(bounds.height)-imgvWidth)/2,
                width: imgvWidth,
                height: imgvWidth
            )
        )
        var names: [String] = []
        for i in 0..<93 {
            names.append("ip动画_0" + (i >= 10 ? "\(i)" : "0\(i)"))
        }
        animateImageView.animationImages = names.map { name -> UIImage in
            return UIImage(named: name)!
        }
        animateImageView.animationDuration = 2
        animateImageView.contentMode = .scaleAspectFit
        animateImageView.startAnimating()
        addSubview(animateImageView)
        contentView = UIView(
            frame: CGRect(
                x: positionIsLeft ? 0 : imgvWidth + 10,
                y: (Int(bounds.height)-60.fh)/2,
                width: Int(bounds.width)-imgvWidth,
                height: 60.fh
            )
        )
        contentView.backgroundColor = UIColor(hex: "#FEDDBD")
        contentView.layer.cornerRadius = 5
        textLabel = UILabel(frame: CGRect(x: 10.fw, y: 5.fh, width: Int(contentView.frame.width)-20.fw, height: Int(contentView.frame.height)-10.fh))
        textLabel.text = text
        textLabel.textColor = .black
        contentView.addSubview(textLabel)
        addSubview(contentView)
    }

}
