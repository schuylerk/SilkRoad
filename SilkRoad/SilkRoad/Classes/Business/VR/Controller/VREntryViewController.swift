//
//  VREntryViewController.swift
//  SilkRoad
//
//  Created by student on 2022/4/1.
//

import UIKit
import SnapKit

class VREntryViewController: UIViewController {
    
    let roadMapHeight: CGFloat = screenHeight
    
    lazy var scrollView: UIScrollView = {
        let scv = UIScrollView()
        scv.frame.size = CGSize(width: screenWidth, height: roadMapHeight)
        scv.center = view.center
        scv.backgroundColor = .systemGray3
        scv.contentSize = CGSize(width: screenWidth*3, height: roadMapHeight)
        scv.addSubview(roadMapImageView)
        scv.showsVerticalScrollIndicator = false
        return scv
    }()
    
    lazy var roadMapImageView: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "vr_roadmap")
        imgV.frame.origin = CGPoint(x: 0, y: 0)
        imgV.contentMode = .scaleAspectFill
        imgV.frame.size = CGSize(width: screenWidth*3, height: roadMapHeight)
        imgV.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        imgV.addGestureRecognizer(gesture)
        return imgV
    }()
    
    @objc func tapHandler(gesture: UIGestureRecognizer) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setNav()
    }
    
    func setUI() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
    }
    
    func setNav() {
        navigationController?.navigationBar.isHidden = true
    }

}
