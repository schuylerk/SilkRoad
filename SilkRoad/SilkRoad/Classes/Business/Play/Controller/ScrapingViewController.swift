//
//  ScrapingViewController.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/5/8.
//

import UIKit
import MaLiang

class ScrapingViewController: UIViewController {

    lazy var canvas: Canvas = {
        let canvas = Canvas(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
        let pen = canvas.defaultBrush
        pen!.color = .white
        pen!.use()
        return canvas
    }()
    
    lazy var backView: UIView = {
        let vi = UIView(frame: CGRect(x: screenWidth / 2 - 150, y: screenHeight / 2 - 200, width: 300, height: 400))
        vi.addSubview(canvas)
        vi.backgroundColor = .systemGray
        vi.layer.cornerRadius = 20
        return vi
    }()
    
    lazy var colorLayer: ColorLayer = {
        let layer = ColorLayer(
            CGPoint(x: 0.5, y: 0),
            endPoint: CGPoint(x: 0.5, y: 1.0),
            colors: [UIColor(hex: "#FFCCA3").cgColor, UIColor(hex: "#F8F8F8").cgColor],
            locations: [0, 0.5])
        layer.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        return layer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
    }
    
    func setUI() {
        view.layer.addSublayer(colorLayer)
        view.addSubview(backView)
    }
    
    func setNav() {
        title = "刮画"
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNav()
        tabBarController?.tabBar.isHidden = true
    }

}
