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
import SwiftyJSON

class ShowVRViewController: UIViewController {
    
    var cityName: String = ""
    var cityNameCN: String = ""
    
    var overlays: [Overlay] = []
    
    var collectedIndexes: [Int] = [] {
        didSet {
            mhCollectionView.reloadData()
        }
    }
    
    var openedIndexes: [Int] = []
    
    private var overlayNodes: [SCNNode] = []
    
    let mhDisplayCellReusedID = "mhdisplay"
    
    private var mhContentIsFull: Bool = false
    
    lazy var mhContentView: MHContentView = {
        let vi = MHContentView()
        vi.frame = CGRect(x: screenWidth/2-150, y: screenHeight/2-200, width: 300, height: 400)
        vi.isHidden = true
        vi.layer.masksToBounds = true
        return vi
    }()
    
    lazy var unlockTextLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: screenWidth/2-150, y: screenHeight/2-250, width: 300, height: 40))
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.isHidden = true
        label.layer.shadowColor = UIColor(hex: "#FFCCA3").cgColor
        label.layer.shadowOpacity = 1
        return label
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton(frame: CGRect(x: screenWidth/2+150, y: screenHeight/2-215, width: 15, height: 15))
        button.setImage(UIImage(named: "mh_cha"), for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(tapDeleteButton), for: .touchUpInside)
        return button
    }()
    
    lazy var mhContentFullButton: UIButton = {
        let button = UIButton(frame: CGRect(x: screenWidth/2+130, y: screenHeight/2+180, width: 15, height: 15))
        button.setImage(UIImage(named: "mh_full"), for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(tapFullButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tapDeleteButton() {
        deleteButton.isHidden = true
        mhContentFullButton.isHidden = true
        mhContentView.isHidden = true
        unlockTextLabel.isHidden = true
        mhCollectionView.isHidden = false
        mhBlackButton.isUserInteractionEnabled = true
        mhContentView.removeMarkView()
        mhContentView.removeScnView()
    }
    
    @objc func tapFullButton() {
        deleteButton.isHidden = !mhContentIsFull
        unlockTextLabel.isHidden = !mhContentIsFull
        mhContentFullButton.isHidden = true
        UIView.animate(withDuration: 0.3, animations: { [self] in
            if !mhContentIsFull {
                mhContentView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
            } else {
                mhContentView.frame = CGRect(x: screenWidth/2-150, y: screenHeight/2-200, width: 300, height: 400)
            }
            mhContentView.updateMarkView()
            mhContentView.updateArscnView(type: !mhContentIsFull ? .enlarge : .narrow)
        }, completion: { [self] _ in
            mhContentFullButton.frame = !mhContentIsFull ?
            CGRect(x: screenWidth-40, y: screenHeight-40, width: 20, height: 20) :
            CGRect(x: screenWidth/2+130, y: screenHeight/2+180, width: 15, height: 15)
            mhContentIsFull = !mhContentIsFull
            mhContentFullButton.isHidden = false
        })
    }
    
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
        crv.collectedNumLabel.text = "\((getCollectedMHIndexesFor(cityName: cityNameCN) ?? []).count)"
        crv.titleLabel.text = "已收集盲盒"
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
    
    lazy var displayMHButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "displaymh"), for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 1
        button.addTarget(self, action: #selector(tapDisplayButton), for: .touchUpInside)
        return button
    }()
    
    lazy var mhBlackButton: UIButton = {
        let vi = UIButton(frame: view.frame)
        vi.backgroundColor = .black
        vi.isHidden = true
        vi.alpha = 0.9
        vi.addTarget(self, action: #selector(tapMHBlackButton), for: .touchUpInside)
        return vi
    }()
    
    lazy var mhCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 120)
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        let clv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        clv.delegate = self
        clv.dataSource = self
        clv.register(MHDisplayCell.self, forCellWithReuseIdentifier: mhDisplayCellReusedID)
        clv.isHidden = true
        clv.backgroundColor = .clear
        return clv
    }()
    
    lazy var animateView: UIImageView = {
        let imgv = UIImageView(frame: CGRect(x: screenWidth/2-200, y: screenHeight/2-200, width: 400, height: 400))
        var names: [String] = []
        for i in 0..<100 {
            names.append("盲盒动画_000" + (i >= 10 ? "\(i)" : "0\(i)"))
        }
        imgv.animationImages = names.map { name -> UIImage in
            return UIImage(named: name)!
        }
        imgv.animationDuration = 4
        imgv.contentMode = .scaleAspectFit
        imgv.isHidden = true
        return imgv
    }()
    
    @objc func tapDisplayButton() {
        mhBlackButton.isHidden = false
        mhCollectionView.isHidden = false
    }
    
    @objc func tapMHBlackButton() {
        mhCollectionView.isHidden = true
        mhBlackButton.isHidden = true
        displayMHButton.isUserInteractionEnabled = true
    }

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
        view.addSubview(displayMHButton)
        view.addSubview(mhBlackButton)
        view.addSubview(mhCollectionView)
        view.addSubview(animateView)
        view.addSubview(mhContentView)
        view.addSubview(deleteButton)
        view.addSubview(mhContentFullButton)
        view.addSubview(unlockTextLabel)
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
            maker.height.equalTo(200)
        }
        displayMHButton.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-50)
            maker.width.equalTo(150)
            maker.height.equalTo(120)
        }
        mhCollectionView.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
            maker.left.equalToSuperview().offset(30)
            maker.right.equalToSuperview().offset(-30)
            maker.height.equalTo(250)
        }
        configOverlay()
//        configDialogueData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    var introductionVC: IntroductionCultureRelicViewController!
    private var currentCultureRelicIndex: Int = 0
    
    var dialogueData: [Dialogue] = []
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard blackView.isHidden else { return }
        guard let point = touches.first?.location(in: scnView) else { return }
        let results = scnView.hitTest(point, options: nil)
        guard let node = results.first?.node else { return }
        let currentNode = overlayNodes.filter { overlayNode -> Bool in
            return overlayNode.position == node.position
        }.first
        guard let currentNode = currentNode else { return }
        currentNode.removeFromParentNode()
        guard let point2 = touches.first?.location(in: view) else {
            return
        }
        guard let index = overlayNodes.firstIndex(of: currentNode) else { return }
        let imageView = UIImageView(frame: CGRect(x: point2.x - 50, y: point2.y-50, width: 100, height: 100))
        imageView.image = UIImage(named: "mh")
        view.addSubview(imageView)
        UIView.animate(withDuration: 1, animations: {
            imageView.frame = CGRect(x: screenWidth/2-25, y: screenHeight-135, width: 50,  height: 50)
        }, completion: { [self] _ in
            imageView.isHidden = true
            collect(index: index)
        })
//        currentCultureRelicIndex = index
//        dialogueView.isHidden = false
//        dialogueView.contents = dialogueData.filter { dia in
//            dia.name == overlays[index].cultureRelic.name
//        }.first?.contents ?? []
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
    
    func collect(index: Int) {
        if let _ = self.collectedIndexes.firstIndex(of: index) { return }
        guard let collectedNum = Int(self.collectionRecordView.collectedNumLabel.text ?? "") else { return }
        self.collectionRecordView.collectedNumLabel.text = "\(collectedNum + 1)"
        self.collectedIndexes.append(index)
        saveCollectedMHIndexes(cityName: cityNameCN, mindex: index)
//        saveCultureRelicFor(self.overlays[index].cultureRelic.name, city: self.cityName)
//        if self.collectedIndexes.count == self.overlays.count {
//            saveBadge(self.cityNameCN)
//        }
    }

}

//遮罩相关函数
extension ShowVRViewController {
    
    //创建遮罩节点
    func createOverlayNode(_ model: Overlay) -> SCNNode {
        let node = SCNNode()
        node.geometry = SCNPlane(width: model.width, height: model.height)
        node.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "mh")
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
        if let indexes = getCollectedMHIndexesFor(cityName: cityNameCN) {
            collectedIndexes = indexes
        }
        if let opIndexes = getOpenedMHIndexes(cityName: cityNameCN) {
            openedIndexes = opIndexes
        }
//        overlayNodes.forEach { overlayNode in
//            scnView.scene?.rootNode.addChildNode(overlayNode)
//        }
        for i in 0..<overlayNodes.count {
            if collectedIndexes.firstIndex(where: {$0==i}) == nil {
                scnView.scene?.rootNode.addChildNode(overlayNodes[i])
            }
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

extension ShowVRViewController {
    
    func configDialogueData() {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "dialogue", ofType: "json")!))
            let jsonString = String(data: data, encoding: .utf8)!
            let json = JSON(parseJSON: jsonString)
            let _ = json.map { _, json -> Void in
                guard let json = json.array else { return }
                let _ = json.map { json -> Void in
                    dialogueData.append(Dialogue(name: json["name"].stringValue, contents: json["contents"].arrayValue.map { $0.stringValue }))
                }
            }
        } catch {
            
        }
    }
    
}

extension ShowVRViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6 //collectedIndexes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mhDisplayCellReusedID, for: indexPath) as! MHDisplayCell
        let isOpened = openedIndexes.firstIndex(where: {$0==indexPath.row}) != nil
        cell.imageView.image = isOpened ? (overlays[indexPath.row].type == 0 ? UIImage(named: "mh_story") : UIImage(named: "mh_culturerelic")) : UIImage(named: "mh_2")
        let isCollected = collectedIndexes.firstIndex(where: {$0==indexPath.row}) != nil
        if isOpened {
            cell.textLabel.text = "已解锁" + (overlays[indexPath.row].type==0 ? "(故事)" : "(文物)")
        } else {
            cell.textLabel.text = isCollected ? "已收集" : "未收集"
        }
        cell.textLabel.textColor = isCollected ? .white : .gray 
        return cell
    }
    
}

extension ShowVRViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let isCollected = collectedIndexes.firstIndex(where: {$0==indexPath.row}) != nil
        if isCollected {
            mhCollectionView.isHidden = true
            mhBlackButton.isUserInteractionEnabled = false
            displayMHButton.isUserInteractionEnabled = false
            if let _ = openedIndexes.firstIndex(where: {$0==indexPath.row}) {
                displayMHContent(index: indexPath.row)
            } else {
                openMH(index: indexPath.row)
                openedIndexes.append(indexPath.row)
                saveOpenedMHIndexes(cityName: cityNameCN, index: indexPath.row)
                mhCollectionView.reloadData()
            }
        }
    }
    
}

extension ShowVRViewController {
    
    func openMH(index: Int) {
        animateView.isHidden = false
        animateView.startAnimating()
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { [self] _ in
            animateView.stopAnimating()
            animateView.isHidden = true
            displayMHContent(index: index)
        }
    }
    
    func displayMHContent(index: Int) {
        mhContentView.isHidden = false
        mhContentView.frame = CGRect(x: screenWidth/2, y: screenHeight/2, width: 0, height: 0)
        let mhContentType: MHContentView.ContentType = overlays[index].type == 0 ? .story : .cultureRelic
        mhContentView.contentType = mhContentType
        UIView.animate(withDuration: 0.5, animations: { [self] in
            mhContentView.frame = CGRect(x: screenWidth/2-150, y: screenHeight/2-200, width: 300, height: 400)
        }, completion: { [self] _ in
            deleteButton.isHidden = false
            mhContentFullButton.isHidden = false
            unlockTextLabel.isHidden = false
            unlockTextLabel.text = mhContentType == .story ? "解锁一个故事" : "解锁一个文物"
            switch mhContentType {
            case .story:
                mhContentView.configStory(name: overlays[index].story)
            case .cultureRelic:
                mhContentView.configCultureRelic(cultureRelic: overlays[index].cultureRelic)
            }
        })
    }
    
}
