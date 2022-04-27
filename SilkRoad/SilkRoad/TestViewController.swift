//
//  TestViewController.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/4/22.
//

import UIKit

class TestViewController: UIViewController {
    
    lazy var vi: DateView = {
        let vi = DateView(frame: CGRect(x: 50, y: 50, width: screenWidth - 100, height: 200))
        return vi
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(vi)
    }

}
