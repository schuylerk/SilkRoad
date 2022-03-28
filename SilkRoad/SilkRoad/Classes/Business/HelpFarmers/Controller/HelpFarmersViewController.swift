//
//  HelpFarmersViewController.swift
//  SilkRoad
//
//  Created by student on 2022/3/25.
//

import UIKit

class HelpFarmersViewController: UIViewController {
    
    lazy var colorLayer: ColorLayer = {
        let layer = ColorLayer(CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1.0), colors: [UIColor.orange.cgColor, UIColor.green.cgColor], locations: [0.2, 0.7])
        layer.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 200)
        return layer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setNav()
        setUI()
    }
    
    func setNav() {
        self.title = "助农平台"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.font: UIFont(name: "Arial", size: 25) as Any]
    }
    
    func setUI() {
        view.backgroundColor = .white
        view.layer.addSublayer(colorLayer)
    }

}
