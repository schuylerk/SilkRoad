//
//  OtherViewController.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/4/29.
//

import UIKit

class OtherViewController: UIViewController {
    
    lazy var arImageView: UIImageView = {
        let imgv = UIImageView()
        imgv.backgroundColor = .systemGray6
        imgv.layer.cornerRadius = 25
        imgv.frame.size = CGSize(width: 50, height: 50)
        imgv.image = UIImage(named: "ar")
        imgv.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(goAR))
        imgv.addGestureRecognizer(gesture)
        return imgv
    }()
    
    @objc func goAR() {
        let vc = ARViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    lazy var playImageView: UIImageView = {
        let imgv = UIImageView()
        imgv.backgroundColor = .systemGray6
        imgv.layer.cornerRadius = 25
        imgv.frame.size = CGSize(width: 50, height: 50)
        imgv.image = UIImage(named: "play")
        return imgv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .white
        view.addSubview(arImageView)
        view.addSubview(playImageView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        arImageView.center = CGPoint(x: screenWidth / 2 , y: screenHeight - 70)
        playImageView.center = CGPoint(x: screenWidth / 2, y: screenHeight - 70)
        UIView.animate(withDuration: 1, animations: {
            self.arImageView.center = CGPoint(x: screenWidth / 2 - 40, y: screenHeight - 150)
            self.playImageView.center = CGPoint(x: screenWidth / 2 + 40, y: screenHeight - 150)
        })
        tabBarController?.tabBar.isHidden = false
    }
    
}
