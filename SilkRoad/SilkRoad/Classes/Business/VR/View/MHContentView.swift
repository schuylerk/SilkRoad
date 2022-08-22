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
    
    var storyView: StoryView!
    
    var arscnView: ARSCNView!
    
    var crNameLabel: UILabel!
    
    var num: Int = 0
    
    var preRotation: Rotation!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        layer.cornerRadius = 10
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
        storyView = StoryView(frame: bounds)
        storyView.config(content: string)
        addSubview(storyView)
//        let content = NHMarkdown().markdownToHTML(string)
//        markView = NHMarkdownView()
//        markView.frame = bounds
//        markView.openOnSafari = true
//        markView.onRendered = { height in
//            print(height ?? 0)
//        }
//        addSubview(markView)
//        markView.load(markdown: content, options: .default) { [self] wkView, wkNav in
//            markView.setFontSize(percent: 128)
//        }
    }
    
    func configCultureRelic(cultureRelic: CultureRelic, preRotation: Rotation) {
        self.num = cultureRelic.num
        self.preRotation = preRotation
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
        let gesture2 = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureHandle))
        arscnView.addGestureRecognizer(gesture2)
        let spotLight = SCNNode()
        spotLight.light = SCNLight()
        spotLight.light?.type = .directional
        arscnView.scene.rootNode.addChildNode(spotLight)
        let node = arscnView.scene.rootNode.childNodes[0]
        node.position = SCNVector3Make(0, 0, -1)
        node.scale = SCNVector3Make(0.5, 0.5, 0.5)
        let r1 = SCNMatrix4Rotate(SCNMatrix4Identity, preRotation.x, 1, 0, 0)
        let r2 = SCNMatrix4Rotate(r1, preRotation.y, 0, 1, 0)
        node.pivot = SCNMatrix4Rotate(r2, preRotation.z, 0, 0, 1)
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
    
    func clear() {
        if storyView != nil {
            storyView.clear()
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
    
    func removeCrNameLabel() {
        if crNameLabel != nil {
            crNameLabel.removeFromSuperview()
            crNameLabel = nil
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
            let r1 = SCNMatrix4Rotate(SCNMatrix4Identity, preRotation.x, 1, 0, 0)
            let r2 = SCNMatrix4Rotate(r1, preRotation.y, 0, 1, 0)
            let r3 = SCNMatrix4Rotate(r2, preRotation.z, 0, 0, 1)
            let r4 = SCNMatrix4Rotate(r3, currentAngleX+totleAngleX, 0, 1, 0)
            arscnView.scene.rootNode.childNodes[0].pivot = SCNMatrix4Rotate(r4, currentAngleY + totleAngleY, 1, 0, 0)
        }
    }
    
    var scale: Float = 0.5
    
    @objc func pinchGestureHandle(gesture: UIPinchGestureRecognizer) {
        let sc = (scale + Float(gesture.scale-1)) >= 0 ? (scale + Float(gesture.scale-1)) : 0
        if let node = arscnView.scene.rootNode.childNodes.first {
            node.scale = SCNVector3Make(sc, sc, sc)
        }
        if gesture.state == .ended {
            scale = sc
        }
    }
    
    func connectReality() {
        removeScnView()
        removeCrNameLabel()
        arscnView = ARSCNView(frame: bounds)
        arscnView.scene = SCNScene()
        arscnView.delegate = self
//        arscnView.debugOptions = [.showWorldOrigin, .showFeaturePoints]
        addSubview(arscnView)
        addSubview(addButton)
        addSubview(helpButton)
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(realPanGestureHandle))
        arscnView.addGestureRecognizer(gesture)
        let gesture2 = UIPinchGestureRecognizer(target: self, action: #selector(realPinchGestureHandle))
        arscnView.addGestureRecognizer(gesture2)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        arscnView.session.run(configuration)
    }
    
    func disconnectReality() {
        arscnView.session.pause()
        arscnView.removeFromSuperview()
        addButton.removeFromSuperview()
//        helpButton.removeFromSuperview()
        arscnView = nil
        canAdd = false
        openHelp = true
        planes = [:]
        nodes = []
        ids = []
        currentPlaneIndex = 0
    }
    
    var realCanRotate: Bool = false
    var realRotateNode: SCNNode!
    var realRotateBeginX: Float = 0
    var realRotateTx: Float = 0
    var realRotateTotleX: Float = 0
    
    @objc func realPanGestureHandle(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: arscnView)
        if gesture.state == .began {
            let results = arscnView.hitTest(location, options: nil)
            results.forEach { res in
                let node = res.node
                guard (node.geometry as? SCNPlane) == nil else { return}
                realCanRotate = true
                realRotateNode = node
                realRotateBeginX = Float(location.x)
            }
        } else if gesture.state == .ended {
            realCanRotate = false
            realRotateNode = nil
            realRotateTx = 0
            realRotateBeginX = 0
        } else {
            if realCanRotate {
                realRotateTx = Float(location.x) - realRotateBeginX
                realRotateTotleX += realRotateTx
                let angle = -realRotateTotleX/Float(5.fw)*Float.pi/180.0
                print(preRotation)
//                let r1 = SCNMatrix4MakeRotation(preRotation.x, 1, 0, 0)
//                let r2 = SCNMatrix4Rotate(r1, preRotation.y, 0, 1, 0)
//                let r3 = SCNMatrix4Rotate(r2, preRotation.z, 0, 0, 1)
                if num == 5 || num == 3 {
                    realRotateNode.pivot = SCNMatrix4Rotate(SCNMatrix4Identity, angle, 0, 1, 0)
                } else if num == 8 || num == 10 || num == 9 {
                    realRotateNode.pivot = SCNMatrix4Rotate(SCNMatrix4Identity, angle, 1, 0, 0)
                } else {
                    realRotateNode.pivot = SCNMatrix4Rotate(SCNMatrix4Identity, angle, 0, 0, 1)
                }
                print(realRotateTx)
            }
        }
    }
    
    var realCanScale: Bool = false
    var realScale: Float = 0.3
    var realPreScale: Float = 0.0
    var realScaleNode: SCNNode!
    
    @objc func realPinchGestureHandle(gesture: UIPinchGestureRecognizer) {
        let location = gesture.location(in: arscnView)
        if gesture.state == .began {
            let results = arscnView.hitTest(location, options: nil)
            results.forEach { res in
                let node = res.node
                guard (node.geometry as? SCNPlane) == nil else { return}
                realCanScale = true
                realScaleNode = node
            }
        } else if gesture.state == .ended {
            realCanScale = false
            realScale = realPreScale
            realScaleNode = nil
        } else {
            if realCanScale {
                realPreScale = (realScale + Float(gesture.scale-1)) >= 0.2 ? (realScale + Float(gesture.scale-1)) : 0.2
                realScaleNode.scale = SCNVector3Make(realPreScale, realPreScale, realPreScale)
            }
        }
    }
    
    var planes: [UUID: SCNNode] = [:]
    var nodes: [SCNNode] = []
    var ids: [UUID] = []
    var currentPlaneIndex: Int = 0
    
    @objc func addCultureRelic() {
        guard currentPlaneIndex < nodes.count else { return }
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "\(num)", ofType: "usdz")!)
        let nod = self.createCultureRelicNode(url: url)
        let node = nodes[currentPlaneIndex]
        guard let plane = planes[ids[currentPlaneIndex]] else { return }
        nod.position = SCNVector3Make(
            node.position.x + plane.position.x,
            node.position.y + plane.position.y,
            node.position.z + plane.position.z
        )
        nod.scale = SCNVector3Make(0.3, 0.3, 0.3)
        let r1 = SCNMatrix4Rotate(SCNMatrix4Identity, preRotation.x, 1, 0, 0)
        let r2 = SCNMatrix4Rotate(r1, preRotation.y, 0, 1, 0)
        nod.pivot = SCNMatrix4Rotate(r2, preRotation.z, 0, 0, 1)
        arscnView.scene.rootNode.addChildNode(nod)
        currentPlaneIndex += 1
        if currentPlaneIndex < nodes.count {
            addButton.setTitle("添加到平面\(currentPlaneIndex+1)", for:  .normal)
        } else {
            addButton.setTitle("平面检测中...", for: .normal)
        }
    }
    
    var canAdd: Bool = false {
        didSet {
            DispatchQueue.main.async { [self] in
                addButton.backgroundColor = canAdd ? .orange : .gray
                addButton.isEnabled = canAdd
                addButton.setTitle(canAdd ? "添加到平面1" : "检测平面中...", for: .normal)
            }
        }
    }
    
    lazy var addButton: UIButton = {
        let button = UIButton(frame: CGRect(x: Int(screenWidth)/2-100.fw, y: Int(screenHeight)-80.fh, width: 200.fw, height: 40.fh))
        button.setTitle(canAdd ? "添加到平面1" : "检测平面中...", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: CGFloat(12.fw))
        button.backgroundColor = canAdd ? .orange : .gray
        button.layer.cornerRadius = CGFloat(20.fh)
        button.isEnabled = canAdd
        button.addTarget(self, action: #selector(addCultureRelic), for: .touchUpInside)
        return button
    }()
    
    var openHelp: Bool = true {
        didSet {
            helpButton.setTitle(openHelp ? "关闭平面辅助" : "开启平面辅助", for: .normal)
        }
    }
    
    lazy var helpButton: UIButton = {
        let button = UIButton(frame: CGRect(x: Int(screenWidth)-95.fw, y: 50.fh, width: 80.fw, height: 20.fh))
        button.setTitle(openHelp ? "关闭平面辅助" : "开启平面辅助", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: CGFloat(12.fw))
        button.addTarget(self, action: #selector(openPlaneHelp), for: .touchUpInside)
        return button
    }()
    
    @objc func openPlaneHelp() {
        openHelp = !openHelp
        planes.forEach { _, node in
            node.isHidden = !openHelp
        }
    }
    
    var hadAddedPlanes: [UUID] = []
    
}

extension MHContentView: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else {
            return
        }
        let geomatry = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        geomatry.firstMaterial?.diffuse.contents = UIImage(named: "tron")
        let planeNode = SCNNode(geometry: geomatry)
        planeNode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z)
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1.0, 0, 0)
        node.addChildNode(planeNode)
        planes[anchor.identifier] = planeNode
        ids.append(anchor.identifier)
        nodes.append(node)
        DispatchQueue.main.async { [self] in
            if currentPlaneIndex < nodes.count {
                addButton.setTitle("添加到平面\(currentPlaneIndex+1)", for:  .normal)
            } else {
                addButton.setTitle("平面检测中...", for: .normal)
            }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let planeNode = planes[anchor.identifier] {
            if let planeAnchor = anchor as? ARPlaneAnchor {
                if let plane = planeNode.geometry as? SCNPlane {
                    if !canAdd { canAdd = true }
                    plane.width = CGFloat(planeAnchor.extent.x)
                    plane.height = CGFloat(planeAnchor.extent.z)
                    planeNode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z)
                }
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

