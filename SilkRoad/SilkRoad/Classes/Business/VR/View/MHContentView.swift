//
//  MHContentView.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/8/14.
//

import UIKit
import WebKit
import QuickLook
import ARKit

class MHContentView: UIView {
    
    var contentType: ContentType = .story
    
    var markView: NHMarkdownView!
    
    var arscnView: ARSCNView!
    
    var crNameLabel: UILabel!
    
    var num: Int = 0
    
    lazy var colorLayer: ColorLayer = {
        let layer = ColorLayer(
            CGPoint(x: 0.5, y: 0),
            endPoint: CGPoint(x: 0.5, y: 1.0),
            colors: [UIColor(hex: "#FFCCA3").cgColor, UIColor(hex: "#F8F8F8").cgColor],
            locations: [0, 0.5])
        layer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        return layer
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        layer.cornerRadius = 10
//        layer.addSublayer(colorLayer)
        backgroundColor = .white
    }
    
    func configStory(name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "md") else {
            return
        }
        var string = ""
        do {
            string = try String(contentsOf: url, encoding: .utf8)
            print(string)
        } catch {
            print(error)
        }
        let content = NHMarkdown().markdownToHTML(string)
        markView = NHMarkdownView()
        markView.frame = bounds
        markView.openOnSafari = true
        markView.onRendered = { height in
            print(height ?? 0)
        }
        addSubview(markView)
        markView.load(markdown: content, options: .default) { [self] wkView, wkNav in
            markView.setFontSize(percent: 128)
        }
    }
    
    func configCultureRelic(cultureRelic: CultureRelic) {
        self.num = cultureRelic.num
        crNameLabel = UILabel(frame: CGRect(x: 0, y: 10, width: Int(bounds.width), height: 30.fh))
        crNameLabel.textColor = .black
        crNameLabel.textAlignment = .center
        crNameLabel.text = cultureRelic.name
        crNameLabel.layer.shadowColor = UIColor(hex: "#FFCCA3").cgColor
        crNameLabel.layer.shadowOpacity = 1
        arscnView = ARSCNView(frame: bounds)
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "\(num)", ofType: "usdz")!)
        arscnView.scene = try! SCNScene(url: url, options: [.checkConsistency: true])
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandle))
        arscnView.addGestureRecognizer(gesture)
        let spotLight = SCNNode()
        spotLight.light = SCNLight()
        spotLight.light?.type = .directional
        arscnView.scene.rootNode.addChildNode(spotLight)
        let node = arscnView.scene.rootNode.childNodes[0]
        node.scale = SCNVector3Make(0.5, 0.5, 0.5)
        switch num {
        case 4:
            break
//            node.rotation = SCNVector4Make(1, 0, 0, -Float.pi/3.5)
        default:
            break
        }
        addSubview(arscnView)
        addSubview(crNameLabel)
    }
    
    func removeMarkView() {
        if markView != nil {
            markView.removeFromSuperview()
            markView = nil
        }
    }
    
    func removeScnView() {
        if arscnView != nil {
            arscnView.removeFromSuperview()
            arscnView = nil
        }
        if crNameLabel != nil {
            crNameLabel.removeFromSuperview()
            crNameLabel = nil
        }
    }

    func updateMarkView() {
        if markView != nil {
            markView.frame = bounds
        }
    }
    
    func updateArscnView(type: FrameType) {
        if arscnView != nil {
            arscnView.frame = bounds
        }
        if crNameLabel != nil {
            crNameLabel.frame = CGRect(x: 0, y: type == .enlarge ? 50 : 10, width: Int(bounds.width), height: 30.fh)
        }
    }
    
    func createCultureRelicNode(url: URL) -> SCNNode {
        let scene = try! SCNScene(url: url, options: [.checkConsistency: true])
        let node = scene.rootNode.childNodes.first!
        return node
    }
    
    var beganPoint: CGPoint = CGPoint()
    var currentPoint: CGPoint = CGPoint()
    var currentAngleX: Float = 0.0
    var totleAngleX: Float = 0.0
    var currentAngleY: Float = 0.0
    var totleAngleY: Float = 0.0
    
    @objc func panGestureHandle(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: arscnView)
        if gesture.state == .began {
            beganPoint = location
        } else if gesture.state == .ended {
            totleAngleX += currentAngleX
            totleAngleY += currentAngleY
        } else {
            currentPoint = location
            let tx = Float(currentPoint.x - beganPoint.x)
            let ty = Float(currentPoint.y - beganPoint.y)
            currentAngleX = -tx / 50.0 * Float.pi / 2
            currentAngleY = -ty / 50.0 * Float.pi / 2
            switch num {
            case 4:
                arscnView.scene.rootNode.childNodes[0].pivot = SCNMatrix4Rotate(SCNMatrix4MakeRotation(currentAngleX+totleAngleX, 0, 1, 0), currentAngleY + totleAngleY, 1, 0, 0)
            default:
                arscnView.scene.rootNode.childNodes[0].pivot = SCNMatrix4Rotate(SCNMatrix4MakeRotation(currentAngleX+totleAngleX, 0, 1, 0), currentAngleY + totleAngleY, 1, 0, 0)
            }
        }
    }
    
}

extension MHContentView {
    
    enum ContentType {
        case story
        case cultureRelic
    }
    
    enum FrameType {
        case enlarge
        case narrow
    }
    
}
