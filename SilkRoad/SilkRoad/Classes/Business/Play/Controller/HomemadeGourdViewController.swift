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
    
    var colors: [UIColor] = [.white, .blue, .green, .red, .orange, .yellow]
    let colorCellReuseID = "color"
    var penColor: UIColor = .blue
    var upBrushes: [Brush] = []
    var downBrushes: [Brush] = []

    lazy var upCanvas: Canvas = {
        let canvas = Canvas(frame: CGRect(x: 0, y: 0, width: 200.fw, height: 200.fw))
        canvas.data.addObserver(self)
        canvas.layer.cornerRadius = CGFloat(100.fw)
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
        let canvas = Canvas(frame: CGRect(x: 0, y: 0, width: 300.fw, height: 300.fw))
        canvas.data.addObserver(self)
        canvas.layer.cornerRadius = CGFloat(150.fw)
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
        let vi = UIView(frame: CGRect(x: Int(screenWidth) / 2 - 100.fw, y: 120.fh, width: 200.fw, height: 200.fw))
        vi.backgroundColor = .white
        vi.layer.cornerRadius = CGFloat(100.fw)
        vi.layer.borderColor = UIColor.systemGray3.cgColor
        vi.layer.borderWidth = 1
        vi.addSubview(upCanvas)
        return vi
    }()
    
    lazy var downView: UIView = {
        let vi = UIView(frame: CGRect(x: Int(screenWidth) / 2 - 150.fw, y: 120.fh+200.fw, width: 300.fw, height: 300.fw))
        vi.backgroundColor = .white
        vi.layer.cornerRadius = CGFloat(150.fw)
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
        let vi = UIView(frame: CGRect(x: 0, y: Int(screenHeight) - 200.fh, width: Int(screenWidth), height: 200.fh))
        vi.backgroundColor = .white
        vi.addSubview(bottomTopContainerView)
        vi.addSubview(colorCollctionView)
        return vi
    }()
    
    lazy var bottomTopContainerView: UIView = {
        let vi = UIView(frame: CGRect(x: Int(screenWidth) / 2 - 150.fw, y: 20.fh, width: 300.fw, height: 70.fh))
        vi.backgroundColor = .white
        vi.layer.borderColor = UIColor.systemGray3.cgColor
        vi.layer.borderWidth = 1
        vi.layer.cornerRadius = CGFloat(10.fw)
        vi.addSubview(penButton)
        vi.addSubview(eraserButton)
        return vi
    }()
    
    lazy var penButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "pen"), for: .normal)
        button.frame.size = CGSize(width: 60.fw, height: 60.fw)
        button.center = CGPoint(x: 75.fw, y: 35.fh)
        button.addTarget(self, action: #selector(pen), for: .touchUpInside)
        return button
    }()
    
    lazy var eraserButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "eraser"), for: .normal)
        button.frame.size = CGSize(width: 60.fw, height: 60.fw)
        button.center = CGPoint(x: 225.fw, y: 35.fh)
        button.addTarget(self, action: #selector(eraser), for: .touchUpInside)
//        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressEraser))
//        button.addGestureRecognizer(gesture)
        return button
    }()
    
    @objc func pen() {
        upCanvas.defaultBrush.use()
        downCanvas.defaultBrush.use()
    }
    
    @objc func eraser() {
        let upEraser = upCanvas.findBrushBy(name: "Eraser") as! Eraser
        let downEraser = downCanvas.findBrushBy(name: "Eraser") as! Eraser
        upEraser.pointSize = 15
        downEraser.pointSize = 15
        upEraser.use()
        downEraser.use()
    }
    
    @objc func longPressEraser() {
        print("long long")
        controlEraserSizeView.isHidden = false
    }
    
    lazy var controlEraserSizeView: UIView = {
        let vi = UIView(frame: CGRect(x: screenWidth/2, y: screenHeight-CGFloat(280.fh), width: CGFloat(200.fw), height: CGFloat(50.fh)))
        let slider = UISlider(frame: vi.bounds)
        slider.minimumValue = 1
        slider.maximumValue = 30
        vi.backgroundColor = .systemGray6
        vi.layer.cornerRadius = 3
        vi.isHidden = true
        vi.addSubview(slider)
        return vi
    }()
    
    lazy var colorCollctionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 40.fw, height: 40.fw)
        let clv = UICollectionView(frame: CGRect(x: 30.fw, y: 100.fh, width: Int(screenWidth) - 60.fw, height: 80.fh), collectionViewLayout: layout)
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
        view.addSubview(controlEraserSizeView)
    }
    
    func setNav() {
        title = "自制葫芦"
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

extension HomemadeGourdViewController: DataObserver {
    
    
}

extension HomemadeGourdViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: colorCellReuseID, for: indexPath)
        cell.layer.cornerRadius = CGFloat(20.fw)
        cell.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let color = colors[indexPath.row]
        upCanvas.defaultBrush.color = color
        downCanvas.defaultBrush.color = color
    }
    
}
