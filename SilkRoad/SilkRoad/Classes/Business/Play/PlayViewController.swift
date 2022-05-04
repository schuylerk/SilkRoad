//
//  PlayViewController.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/5/1.
//

import UIKit

class PlayViewController: UIViewController {
    
    lazy var firstButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(goFirstPlay), for: .touchUpInside)
        return button
    }()
    
    @objc func goFirstPlay() {
        let vc = FirstPlayViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .white
        view.addSubview(firstButton)
        firstButton.snp.makeConstraints { maker in
            maker.width.height.equalTo(200)
            maker.center.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }

}
