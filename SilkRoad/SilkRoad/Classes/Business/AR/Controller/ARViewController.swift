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
        arscnView.scene.rootNode.addChildNode(cultrueRelicNode)
        return arscnView
    }()
    
    lazy var cultrueRelicNode: SCNNode = {
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "10", ofType: "usdz")!)
        let scene = try! SCNScene(url: url, options: [.checkConsistency: true])
        let node = scene.rootNode.childNodes.first!
        node.position = SCNVector3(x: 0, y: 0, z: 0)
        return node
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .white
        view.addSubview(arscnView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        arscnView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        arscnView.session.pause()
    }

}
