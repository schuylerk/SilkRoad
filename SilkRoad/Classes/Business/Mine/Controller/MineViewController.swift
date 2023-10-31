//
//  MineViewController.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/25.
//

import UIKit

class MineViewController: UIViewController {

    let MineDataCell = "MineDataCell"
    let MedalCell = "MedalCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
        configUI()
    }
    
    lazy var setbutton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "set"), for: .normal)
        button.addTarget(self, action: #selector(setClick), for: .touchUpInside)
        return button
    }()
    
    @objc func setClick() {
       let vc = SetViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    lazy var mineCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MineDataCollectionViewCell.self, forCellWithReuseIdentifier: MineDataCell)
        collectionView.register(MedalCollectionViewCell.self, forCellWithReuseIdentifier: MedalCell)
        collectionView.contentInsetAdjustmentBehavior = .never
        
        return collectionView
    }()
    
    lazy var showMedalImageView: UIImageView = {
        let imgv = UIImageView(frame: view.bounds)
        imgv.backgroundColor = .black
        imgv.isUserInteractionEnabled = true
        imgv.isHidden = true
        imgv.contentMode = .scaleAspectFit
        imgv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapShowMedalIV)))
        return imgv
    }()
    
    @objc func tapShowMedalIV() {
        showMedalImageView.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    func configUI() {
        view.addSubview(mineCollectionView)
        view.addSubview(setbutton)
        view.addSubview(showMedalImageView)
        
        mineCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        setbutton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80.fh)
            make.width.equalTo(50.fw)
            make.right.equalToSuperview().offset(-25.fw)
            make.height.equalTo(50.fh)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let dataCell = mineCollectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? MineDataCollectionViewCell {
            dataCell.setPortraitImageView()
            dataCell.setIntroduceLabel()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
}


extension  MineViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MineDataCell, for: indexPath) as! MineDataCollectionViewCell
            cell.searchCallBack = { () in
                let vc = IntegralViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.editCallBack = {
                let vc = EditDataViewController()
                vc.didBack = {
                    cell.updateView()
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MedalCell, for: indexPath) as! MedalCollectionViewCell
//            cell.didSelectMedal = { [self] imageName in
//                showMedalImageView.image = UIImage(named: imageName)
//                tabBarController?.tabBar.isHidden = true
//                showMedalImageView.isHidden = false
//            }
            return cell
            
       }
        
    }
    
}

extension MineViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section{
        case 0:
            return CGSize(width: Int(UIScreen.main.bounds.width), height: 320.fh)
        default:
            return CGSize(width: Int(UIScreen.main.bounds.width), height: Int(screenHeight)-320.fh-100.fh)
        }
    }
  
}
