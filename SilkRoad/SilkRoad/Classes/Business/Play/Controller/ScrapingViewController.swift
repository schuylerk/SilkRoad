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
        let canvas = Canvas(frame: CGRect(x: 0, y: 0, width: 400.fw, height: 600.fh))
        let pen = canvas.defaultBrush
        pen!.color = .white
        pen!.use()
        return canvas
    }()
    
    lazy var backView: UIView = {
        let vi = UIView(frame: CGRect(x: Int(screenWidth) / 2 - 200.fw, y: Int(screenHeight) / 2 - 300.fh, width: 400.fw, height: 600.fh))
        vi.addSubview(canvas)
        vi.backgroundColor = .systemGray
        vi.layer.cornerRadius = CGFloat(20.fw)
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target: self, action: #selector(back))
        navigationController?.navigationBar.tintColor = .black
    }
    
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNav()
        tabBarController?.tabBar.isHidden = true
    }

}
