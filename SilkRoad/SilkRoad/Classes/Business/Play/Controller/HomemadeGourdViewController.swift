//
//  HomemadeGourdViewController.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/5/8.
//

import UIKit
import MaLiang
import SnapKit

class HomemadeGourdViewController: UIViewController {
    
    var colors: [UIColor] = [.white, .blue, .green, .red, .orange]
    let colorCellReuseID = "color"
    var penColor: UIColor = .blue
    var upBrushes: [Brush] = []
    var downBrushes: [Brush] = []

    lazy var upCanvas: Canvas = {
        let canvas = Canvas(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        canvas.data.addObserver(self)
        canvas.layer.cornerRadius = 100
        canvas.layer.masksToBounds = true
        let eraser = try! canvas.registerBrush(name: "Eraser") as Eraser
        upBrushes.append(eraser)
        let pen = canvas.defaultBrush!
        pen.color = penColor
        pen.use()
        upBrushes.append(pen)
        return canvas
    }()
    
    lazy var downCanvas: Canvas = {
        let canvas = Canvas(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        canvas.data.addObserver(self)
        canvas.layer.cornerRadius = 150
        canvas.layer.masksToBounds = true
        let eraser = try! canvas.registerBrush(name: "Eraser") as Eraser
        let pen = canvas.defaultBrush!
        pen.color = penColor
        pen.use()
        downBrushes.append(eraser)
        downBrushes.append(pen)
        return canvas
    }()
    
    lazy var upView: UIView = {
        let vi = UIView(frame: CGRect(x: screenWidth / 2 - 100, y: 150, width: 200, height: 200))
        vi.backgroundColor = .white
        vi.layer.cornerRadius = 100
        vi.layer.borderColor = UIColor.systemGray3.cgColor
        vi.layer.borderWidth = 1
        vi.addSubview(upCanvas)
        return vi
    }()
    
    lazy var downView: UIView = {
        let vi = UIView(frame: CGRect(x: screenWidth / 2 - 150, y: 350, width: 300, height: 300))
        vi.backgroundColor = .white
        vi.layer.cornerRadius = 150
        vi.layer.borderColor = UIColor.systemGray3.cgColor
        vi.layer.borderWidth = 1
        vi.addSubview(downCanvas)
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
    
    lazy var bottomContainerView: UIView = {
        let vi = UIView(frame: CGRect(x: 0, y: screenHeight - 230, width: screenWidth, height: 200))
        vi.backgroundColor = .white
        vi.addSubview(bottomTopContainerView)
        vi.addSubview(colorCollctionView)
        return vi
    }()
    
    lazy var bottomTopContainerView: UIView = {
        let vi = UIView(frame: CGRect(x: screenWidth / 2 - 150, y: 20, width: 300, height: 70))
        vi.backgroundColor = .white
        vi.layer.borderColor = UIColor.systemGray3.cgColor
        vi.layer.borderWidth = 1
        vi.layer.cornerRadius = 10
        vi.addSubview(penButton)
        vi.addSubview(eraserButton)
        return vi
    }()
    
    lazy var penButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "pen"), for: .normal)
        button.frame.size = CGSize(width: 60, height: 60)
        button.center = CGPoint(x: 75, y: 35)
        button.addTarget(self, action: #selector(pen), for: .touchUpInside)
        return button
    }()
    
    lazy var eraserButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "eraser"), for: .normal)
        button.frame.size = CGSize(width: 60, height: 60)
        button.center = CGPoint(x: 225, y: 35)
        button.addTarget(self, action: #selector(eraser), for: .touchUpInside)
        return button
    }()
    
    @objc func pen() {
        upCanvas.defaultBrush.use()
        downCanvas.defaultBrush.use()
    }
    
    @objc func eraser() {
        (upCanvas.findBrushBy(name: "Eraser") as! Eraser).use()
        (downCanvas.findBrushBy(name: "Eraser") as! Eraser).use()
    }
    
    lazy var colorCollctionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 80)
        let clv = UICollectionView(frame: CGRect(x: 30, y: 100, width: screenWidth - 60, height: 80), collectionViewLayout: layout)
        clv.delegate = self
        clv.dataSource = self
        clv.backgroundColor = .clear
        clv.showsHorizontalScrollIndicator = false
        clv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: colorCellReuseID)
        return clv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
    }
    
    func setUI() {
        view.layer.addSublayer(colorLayer)
        view.addSubview(upView)
        view.addSubview(downView)
        view.addSubview(bottomContainerView)
    }
    
    func setNav() {
        title = "自制葫芦"
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNav()
        tabBarController?.tabBar.isHidden = true
    }

}

extension HomemadeGourdViewController: DataObserver {
    
    
}

extension HomemadeGourdViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: colorCellReuseID, for: indexPath)
        cell.layer.cornerRadius = 40
        cell.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let color = colors[indexPath.row]
        upCanvas.defaultBrush.color = color
        downCanvas.defaultBrush.color = color
    }
    
}
