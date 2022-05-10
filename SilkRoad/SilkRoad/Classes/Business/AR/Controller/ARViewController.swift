//
//  ARViewController.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/4/27.
//

import UIKit
import ARKit

class ARViewController: UIViewController {
    
    lazy var arscnView: ARSCNView = {
        let arscnView = ARSCNView(frame: view.frame)
        arscnView.scene = SCNScene()
        arscnView.delegate = self
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapARScnView))
        arscnView.addGestureRecognizer(gesture)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panHandler))
        arscnView.addGestureRecognizer(panGesture)
        return arscnView
    }()
    
    @objc func tapARScnView(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: arscnView)
        let results = arscnView.hitTest(location, options: nil)
        guard let node = results.first?.node else { return }
        slider.value = node.transform.m11
        sliderCurrentNode = node
    }
    
    var beganPoint: CGPoint = CGPoint()
    var currentPoint: CGPoint = CGPoint()
    var currentAngle: Float = 0.0
    var totleAngle: Float = 0.0
    
    @objc func panHandler(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: arscnView) 
        if gesture.state == .began {
            beganPoint = location
        } else if gesture.state == .ended {
            totleAngle += currentAngle
        } else {
            currentPoint = location
            let tx = Float(currentPoint.x - beganPoint.x)
            currentAngle = tx / 50.0 * Float.pi / 2
            currentNode.pivot = SCNMatrix4Rotate(SCNMatrix4Identity, currentAngle + totleAngle, 0, 1, 0)
        }
    }
    
    var sliderCurrentNode: SCNNode!
    
    var sliderValue: Float = 0.5 {
        didSet {
            guard let node = sliderCurrentNode else { return }
            node.transform = SCNMatrix4MakeScale(sliderValue, sliderValue, sliderValue)
        }
    }
    
    lazy var slider: UISlider = {
        let sld = UISlider()
        sld.addTarget(self, action: #selector(changeSlider), for: .allEvents)
        sld.minimumValue = 0
        sld.maximumValue = 1
        sld.value = 0.5
        return sld
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add"), for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(add), for: .touchUpInside)
        return button
    }()
    
    @objc func add() {
        addButton.isHidden = true
        UIView.animate(withDuration: 1, animations: {
            self.bottomModelListView.frame.origin = CGPoint(x: 0, y: screenHeight-300)
        })
    }
    
    @objc func changeSlider() {
        sliderValue = slider.value
    }
    
    var anchor: ARPlaneAnchor!
    var currentNode: SCNNode!
    
    lazy var bottomModelListView: ARModelListView = {
        let vi = ARModelListView(frame: CGRect(x: 0, y: screenHeight, width: screenWidth, height: 300))
        let names = ["arm_1", "arm_2", "arm_3", "arm_4", "arm_5", "arm_6", "arm_7"]
        let models = [1, 2, 7, 5, 4, 3, 6]
        vi.models = names.map { UIImage(named: $0)! }
        vi.backgroundColor = .black
        vi.alpha = 0.8
        vi.tapSelectHandler = { indexPath in
            let url = URL(fileURLWithPath: Bundle.main.path(forResource: "\(models[indexPath.row])", ofType: "usdz")!)
            let node = self.createCultureRelicNode(url: url)
            node.position = SCNVector3Make(self.anchor.center.x, 0, self.anchor.center.z)
            self.currentNode.addChildNode(node)
            UIView.animate(withDuration: 1, animations: {
                self.bottomModelListView.frame.origin = CGPoint(x: 0, y: screenHeight)
            })
        }
        return vi
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .white
        view.addSubview(arscnView)
        view.addSubview(slider)
        view.addSubview(addButton)
        view.addSubview(bottomModelListView)
        slider.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(20)
            maker.right.equalToSuperview().offset(-20)
            maker.top.equalToSuperview().offset(100)
            maker.height.equalTo(5)
        }
        addButton.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-40)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        arscnView.session.run(configuration)
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        arscnView.session.pause()
    }

}

extension ARViewController: ARSCNViewDelegate {

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else {
            return
        }
        self.anchor = planeAnchor
        self.currentNode = node
        DispatchQueue.main.async {
            self.addButton.isHidden = false
        }
    }

}

extension ARViewController {
    
    func createCultureRelicNode(url: URL) -> SCNNode {
        let scene = try! SCNScene(url: url, options: [.checkConsistency: true])
        let node = scene.rootNode.childNodes.first!
        node.transform = SCNMatrix4MakeScale(sliderValue, sliderValue, sliderValue)
        return node
    }
    
}
