//
//  ShowVRViewController.swift
//  SceneKit实现
//
//  Created by 康思为 on 2022/3/21.
//

import UIKit
import SceneKit
import SnapKit
import CoreMotion

class ShowVRViewController: UIViewController {
    
    var cityName: String = ""
    var cityNameCN: String = ""
    
    var overlays: [Overlay] = []
    
    var collectedIndexes: [Int] = []
    
    private var overlayNodes: [SCNNode] = []
    
    lazy var scnView: SCNView = {
        let scnView = SCNView(frame: view.frame)
        scnView.scene = SCNScene()
        scnView.scene?.rootNode.addChildNode(sphereNode)
        scnView.scene?.rootNode.addChildNode(cameraNode)
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panHandler))
        scnView.addGestureRecognizer(gesture)
        return scnView
    }()
    
    var pointX: CGFloat = 0
    var pointY: CGFloat = 0
    var angleX: Float = 0
    var angleY: Float = 0
    
    @objc func panHandler(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            let point = gesture.location(in: scnView)
            pointX = point.x
            pointY = point.y
        } else {
            let point = gesture.location(in: scnView)
            let tx = (point.x - pointX) / 1000
            let ty = (point.y - pointY) / 1000
            if abs(tx) >= abs(ty) {
                angleX += Float(tx)
                
                //水平旋转时垂直方向回正
                angleY = 0
                
                let matrix4 = SCNMatrix4Rotate(SCNMatrix4Identity, Float(angleX), 0, 1, 0)
                cameraNode.pivot = SCNMatrix4Rotate(matrix4, Float(-angleY), 1, 0, 0)
            } else {
                angleY += Float(ty)
                if angleY > Float.pi / 2 { angleY = Float.pi / 2 }
                if angleY < -Float.pi / 2 { angleY = -Float.pi / 2 }
                let matrix4 = SCNMatrix4Rotate(SCNMatrix4Identity, Float(-angleY), 1, 0, 0)
                cameraNode.pivot = SCNMatrix4Rotate(matrix4, Float(angleX), 0, 1, 0)
            }
        }
    }
    
    var manager: CMMotionManager = CMMotionManager()
    
    lazy var sphereNode: SCNNode = {
        let node = SCNNode()
        node.position = SCNVector3(x: 0, y: 0, z: 0)
        
        let sphere = SCNSphere(radius: 10)
        sphere.firstMaterial?.cullMode = .front
        sphere.firstMaterial?.isDoubleSided = false
        sphere.firstMaterial?.diffuse.contents = UIImage(named: cityName)
        sphere.firstMaterial?.diffuse.contentsTransform = SCNMatrix4MakeScale(-1, 1, 1)
        sphere.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(sphere.firstMaterial!.diffuse.contentsTransform, 1, 0, 0)
        node.geometry = sphere
        
        return node
    }()
    
    lazy var cameraNode: SCNNode = {
        let node = SCNNode()
        node.pivot = SCNMatrix4Rotate(SCNMatrix4Identity, 0, 0, 1, 0)
        
        let camera = SCNCamera()
        camera.automaticallyAdjustsZRange = true
        camera.fieldOfView = 60
        camera.focalLength = 8
        camera.fStop = 0
        node.camera = camera
        
        return node
    }()
    
    lazy var blackView: UIView = {
        let vi = UIView(frame: view.frame)
        vi.backgroundColor = .black
        vi.alpha = 0.2
        vi.isHidden = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissIntro))
        vi.addGestureRecognizer(gesture)
        return vi
    }()
    
    @objc func dismissIntro() {
        self.blackView.isHidden = true
        UIView.animate(withDuration: 0.5, animations: {
            self.introductionVC.view.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: screenHeight - 250)
        }, completion: { _ in
            self.introductionVC.view.removeFromSuperview()
        })
    }
    
    func moveIntro(_ value: CGFloat) {
        let frame = introductionVC.view.frame
        if frame.minY + value <= 250 { return }
        introductionVC.view.frame = CGRect(x: frame.minX, y: frame.minY + value, width: frame.width, height: frame.height)
    }
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "vr_back"), for: .normal)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    lazy var collectionRecordView: CollectionRecordView = {
        let crv = CollectionRecordView()
        crv.collectTotalNumLabel.text = "\(overlays.count)"
        crv.collectedNumLabel.text = "0"
        crv.titleLabel.text = "已收集文物"
        crv.layer.cornerRadius = 15
        crv.layer.masksToBounds = true
        return crv
    }()
    
    lazy var dialogueView: CultureRelicDialogueView = {
        let dlv = CultureRelicDialogueView()
        dlv.faceImage = UIImage(named: "cr_1")
        dlv.actionImage = UIImage(named: "continue")
        dlv.layer.cornerRadius = 10
        dlv.layer.masksToBounds = true
        dlv.isHidden = true
        dlv.backgroundViewColor = .white
        dlv.showDetailBack = {
            self.showDetailFor(index: self.currentCultureRelicIndex)
            self.dialogueView.isHidden = true
        }
        return dlv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        setUI()
        manager.gyroUpdateInterval = 0.2
        manager.startDeviceMotionUpdates(to: .main, withHandler: { motion, _ in
            let qp1 = GLKQuaternionMakeWithAngleAndAxis(GLKMathDegreesToRadians(-90), 1, 0, 0)
            guard let quaternion = motion?.attitude.quaternion else { return }
            let qp2 = GLKQuaternionMake(Float(quaternion.x), Float(quaternion.y), Float(quaternion.z), Float(quaternion.w))
            let qp = GLKQuaternionMultiply(qp1, qp2)
            self.cameraNode.orientation = SCNVector4Make(qp.x, qp.y, qp.z, qp.w)
        })
    }
    
    func setUI() {
        view.addSubview(scnView)
        view.addSubview(blackView)
        view.addSubview(backButton)
        view.addSubview(collectionRecordView)
        view.addSubview(dialogueView)
        backButton.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(15.fw)
            maker.top.equalToSuperview().offset(50.fh)
            maker.width.height.equalTo(30)
        }
        collectionRecordView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(20.fw)
            maker.right.equalToSuperview().offset(-20.fw)
            maker.top.equalTo(backButton.snp.bottom).offset(15.fh)
            maker.height.equalTo(100)
        }
        dialogueView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(15)
            maker.right.equalToSuperview().offset(-15)
            maker.bottom.equalToSuperview().offset(-40)
            maker.height.equalTo(100)
        }
        configOverlay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    var introductionVC: IntroductionCultureRelicViewController!
    private var currentCultureRelicIndex: Int = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard blackView.isHidden else { return }
        guard let point = touches.first?.location(in: scnView) else { return }
        let results = scnView.hitTest(point, options: nil)
        guard let node = results.first?.node else { return }
        let currentNode = overlayNodes.filter { overlayNode -> Bool in
            return overlayNode.position == node.position
        }.first
        guard let currentNode = currentNode else { return }
        guard let index = overlayNodes.firstIndex(of: currentNode) else { return }
        currentCultureRelicIndex = index
        dialogueView.isHidden = false
        dialogueView.contents = [overlays[index].cultureRelic.intro]
    }
    
    func showDetailFor(index: Int) {
        let cultureRelic = overlays[index].cultureRelic
        introductionVC = IntroductionCultureRelicViewController(cultureRelic,city: self.cityName)
        introductionVC.view.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: screenHeight - 250)
        introductionVC.view.layer.cornerRadius = 10
        introductionVC.view.layer.masksToBounds = true
        introductionVC.delegate = self
        view.addSubview(introductionVC.view)
        UIView.animate(withDuration: 0.5, animations: {
            self.introductionVC.view.frame = CGRect(x: 0, y: 250, width: screenWidth, height: screenHeight - 250)
        })
        blackView.isHidden = false
        introductionVC.collectionBack = {
            if let _ = self.collectedIndexes.firstIndex(of: index) { return }
            guard let collectedNum = Int(self.collectionRecordView.collectedNumLabel.text ?? "") else { return }
            self.collectionRecordView.collectedNumLabel.text = "\(collectedNum + 1)"
            self.collectedIndexes.append(index)
            saveCultureRelicFor(self.overlays[index].cultureRelic.name, city: self.cityName)
            if self.collectedIndexes.count == self.overlays.count {
                saveBadge(self.cityNameCN)
            }
        }
    }

}

//遮罩相关函数
extension ShowVRViewController {
    
    //创建遮罩节点
    func createOverlayNode(_ model: Overlay) -> SCNNode {
        let node = SCNNode()
        node.geometry = SCNPlane(width: model.width, height: model.height)
        node.geometry?.firstMaterial?.diffuse.contents = UIImage(named: model.cultureRelic.face)
        node.position = model.position
        
        if let rotation = model.rotation {
            node.rotation = rotation
        }
        
        node.geometry?.firstMaterial?.cullMode = model.cullMode
        return node
    }
    
    func configOverlay() {
        overlays.forEach { overlay in
            let overlayNode = createOverlayNode(overlay)
            self.overlayNodes.append(overlayNode)
        }
        displayOverlayNodes()
    }
    
    func displayOverlayNodes() {
        overlayNodes.forEach { overlayNode in
            scnView.scene?.rootNode.addChildNode(overlayNode)
        }
    }
    
}

//文物介绍协议
extension ShowVRViewController: IntroductionCultureRelicDelegate {
    
    func dismissVC() {
        self.dismissIntro()
    }
    
    func moveVC(_ value: CGFloat, dismiss: Bool) {
        print(introductionVC.view.frame.minY)
        if dismiss {
            dismissIntro()
        } else {
            moveIntro(value)
        }
    }
    
    func goAnswerTheQuestion() {
        let vc = AnswerViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
