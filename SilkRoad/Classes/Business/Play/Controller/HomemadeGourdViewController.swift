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
    enum SelectType {
        case pen
        case eraser
    }
    
    let selectSizeCellReuseID = "size"
    var penColor: UIColor = .blue
    var selectType: SelectType = .pen
    var upEraser: Eraser?
    var downEraser: Eraser?

    lazy var upCanvas: Canvas = {
        let canvas = Canvas(frame: CGRect(x: 0, y: 0, width: 240.fw, height: 240.fw))
        canvas.data.addObserver(self)
        canvas.layer.cornerRadius = CGFloat(120.fw)
        canvas.layer.masksToBounds = true
        let eraser = try! canvas.registerBrush(name: "Eraser") as Eraser
        eraser.pointSize = 2
        upEraser = eraser
        canvas.defaultBrush.pointSize = 2
        return canvas
    }()
    
    lazy var downCanvas: Canvas = {
        let canvas = Canvas(frame: CGRect(x: 0, y: 0, width: 340.fw, height: 340.fw))
        canvas.data.addObserver(self)
        canvas.layer.cornerRadius = CGFloat(170.fw)
        canvas.layer.masksToBounds = true
        let eraser = try! canvas.registerBrush(name: "Eraser") as Eraser
        eraser.pointSize = 2
        downEraser = eraser
        canvas.defaultBrush.pointSize = 2
        return canvas
    }()
    
    lazy var upView: UIView = {
        let vi = UIView(frame: CGRect(x: Int(screenWidth) / 2 - 120.fw, y: 150.fh, width: 240.fw, height: 240.fw))
        vi.backgroundColor = .white
        vi.layer.cornerRadius = CGFloat(120.fw)
        vi.layer.borderColor = UIColor.systemGray3.cgColor
        vi.layer.borderWidth = 1
        vi.addSubview(upCanvas)
        return vi
    }()
    
    lazy var downView: UIView = {
        let vi = UIView(frame: CGRect(x: Int(screenWidth) / 2 - 170.fw, y: 150.fh+240.fw, width: 340.fw, height: 340.fw))
        vi.backgroundColor = .white
        vi.layer.cornerRadius = CGFloat(170.fw)
        vi.layer.borderColor = UIColor.systemGray3.cgColor
        vi.layer.borderWidth = 1
        vi.addSubview(downCanvas)
        return vi
    }()
    
    lazy var blackView: UIButton = {
        let vi = UIButton(frame: view.bounds)
        vi.backgroundColor = .black
        vi.alpha = 0.5
        vi.isHidden = true
        vi.addTarget(self, action: #selector(tapBlackView), for: .touchUpInside)
        return vi
    }()
    
    lazy var colorSelectView: ColorSelectView = {
        let vi = ColorSelectView(frame: CGRect(x: Int(screenWidth) / 2 - 150.fw, y: Int(screenHeight) / 2 - 200.fh, width: 300.fw, height: 360.fh))
        vi.backgroundColor = .systemGray6
        vi.layer.cornerRadius = CGFloat(10.fw)
        vi.isHidden = true
        vi.layer.masksToBounds = true
        vi.cancleHandler = { [self] in
            colorSelectView.isHidden = true
            blackView.isHidden = true
        }
        vi.determineHandler = { [self] color in
            upCanvas.defaultBrush.color = color
            downCanvas.defaultBrush.color = color
            colorSelectView.isHidden = true
            blackView.isHidden = true
        }
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
    
    lazy var penButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: Int(screenWidth) / 2 - 35.fw, y: Int(screenHeight) - 60.fh, width: 30.fw, height: 30.fw)
        button.setImage(UIImage(named: "pen.select"), for: .normal)
        button.addTarget(self, action: #selector(pen), for: .touchUpInside)
        return button
    }()
    
    lazy var eraserButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: Int(screenWidth) / 2 + 5.fw, y: Int(screenHeight) - 60.fh, width: 30.fw, height: 30.fw)
        button.setImage(UIImage(named: "eraser.deselect"), for: .normal)
        button.addTarget(self, action: #selector(eraser), for: .touchUpInside)
        return button
    }()
    
    @objc func pen() {
        selectType = .pen
        navigationItem.rightBarButtonItem?.customView?.isHidden = false
        penButton.setImage(.init(named: "pen.select"), for: .normal)
        eraserButton.setImage(.init(named: "eraser.deselect"), for: .normal)
        upCanvas.defaultBrush.use()
        downCanvas.defaultBrush.use()
        setSelectSizeCLVContainerAnimate()
    }
    
    @objc func eraser() {
        selectType = .eraser
        navigationItem.rightBarButtonItem?.customView?.isHidden = true
        penButton.setImage(.init(named: "pen.deselect"), for: .normal)
        eraserButton.setImage(.init(named: "eraser.select"), for: .normal)
        upEraser!.use()
        downEraser!.use()
        setSelectSizeCLVContainerAnimate()
    }
    
    @objc func tapBlackView() {}
    
    func setSelectSizeCLVContainerAnimate() {
        let selectSizeCLVContainerHeight = 30.fw
        let selectSizeCollctionViewHeight = 25.fw
        selectSizeCLVContainer.frame = CGRect(x: Int(screenWidth) / 2, y: Int(screenHeight) - 60.fh, width: 0, height: selectSizeCLVContainerHeight)
        selectSizeCollctionView.frame = CGRect(x: CGFloat(10.fw), y: CGFloat(selectSizeCLVContainerHeight - selectSizeCollctionViewHeight) / 2, width: 0, height: CGFloat(selectSizeCollctionViewHeight))
        UIView.animate(withDuration: 0.2, animations: { [self] in
            selectSizeCLVContainer.frame = CGRect(x: Int(screenWidth) / 2 - 80.fw, y: Int(screenHeight) - 60.fh, width: 160.fw, height: selectSizeCLVContainerHeight)
            selectSizeCollctionView.frame = CGRect(x: CGFloat(10.fw), y: CGFloat(selectSizeCLVContainerHeight - selectSizeCollctionViewHeight) / 2, width: CGFloat(140.fw), height: CGFloat(selectSizeCollctionViewHeight))
            penButton.transform = CGAffineTransform(translationX: -CGFloat(85.fw), y: 0)
            eraserButton.transform = CGAffineTransform(translationX: CGFloat(85.fw), y: 0)
        })
        selectSizeCollctionView.reloadData()
    }
    
    lazy var selectSizeCLVContainer: UIView = {
        let vi = UIView(frame: .zero)
        vi.backgroundColor = .black
        vi.alpha = 0.5
        vi.layer.cornerRadius = CGFloat(15.fw)
        vi.addSubview(selectSizeCollctionView)
        return vi
    }()
    
    lazy var selectSizeCollctionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let clv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        clv.delegate = self
        clv.dataSource = self
        clv.backgroundColor = .clear
        clv.isScrollEnabled = false
        clv.layer.cornerRadius = CGFloat(25.fw) / 2
        clv.showsHorizontalScrollIndicator = false
        clv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: selectSizeCellReuseID)
        return clv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let rect = notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect else { return }
        let keyboardMinY = rect.minY
        UIView.animate(withDuration: 0.2, animations: { [self] in
            colorSelectView.frame = CGRect(x: Int(screenWidth) / 2 - 150.fw, y: Int(keyboardMinY) - 380.fh , width: 300.fw, height: 360.fh)
        })
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: { [self] in
            colorSelectView.frame = CGRect(x: Int(screenWidth) / 2 - 150.fw, y: Int(screenHeight) / 2 - 200.fh, width: 300.fw, height: 360.fh)
        })
    }
    
    func setUI() {
        view.layer.addSublayer(colorLayer)
        view.addSubview(upView)
        view.addSubview(downView)
        view.addSubview(penButton)
        view.addSubview(eraserButton)
        view.addSubview(selectSizeCLVContainer)
        view.addSubview(blackView)
        view.addSubview(colorSelectView)
    }
    
    func setNav() {
        title = "自制葫芦"
        navigationController?.navigationBar.isHidden = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem()
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 30.fw, height: 30.fw))
        let backImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30.fw, height: 30.fw))
        backImageView.image = UIImage(named: "back")
        backImageView.isUserInteractionEnabled = true
        backImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(back)))
        customView.addSubview(backImageView)
        navigationItem.leftBarButtonItem?.customView = customView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem()
        let rightCustomView = UIView(frame: CGRect(x: 0, y: 0, width: 25.fw, height: 25.fw))
        let colorSelectImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25.fw, height: 25.fw))
        colorSelectImageView.image = UIImage(named: "colorselect")
        colorSelectImageView.isUserInteractionEnabled = true
        colorSelectImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(colorSelect)))
        rightCustomView.addSubview(colorSelectImageView)
        navigationItem.rightBarButtonItem?.customView = rightCustomView
        navigationItem.rightBarButtonItem?.customView?.isHidden = true
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func colorSelect() {
        blackView.isHidden = false
        colorSelectView.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNav()
        tabBarController?.tabBar.isHidden = true
    }

}

extension HomemadeGourdViewController: DataObserver {
    
    
}

extension HomemadeGourdViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: selectSizeCellReuseID, for: indexPath)
        cell.layer.cornerRadius = CGFloat(25.fw - 4 * indexPath.row) / 2
        let pointSize = selectType == .pen ? upCanvas.defaultBrush.pointSize : upEraser!.pointSize
        if Int(pointSize) == 10 - 2 * indexPath.row {
            cell.backgroundColor = UIColor(hex: "#E18D36")
        } else {
            cell.backgroundColor = .white
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectType == .pen {
            upCanvas.defaultBrush.pointSize = CGFloat(10 - 2 * indexPath.row)
            downCanvas.defaultBrush.pointSize = CGFloat(10 - 2 * indexPath.row)
        } else {
            upEraser!.pointSize = CGFloat(10 - 2 * indexPath.row)
            downEraser!.pointSize = CGFloat(10 - 2 * indexPath.row)
        }
        selectSizeCollctionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 25.fw - 4 * indexPath.row, height: 25.fw - 4 * indexPath.row)
    }
    
}
