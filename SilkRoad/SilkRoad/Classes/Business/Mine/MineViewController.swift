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
        ConfigUI()
        //self.navigationController?.navigationBar.isHidden = true
        
        // Do any additional setup after loading the view.
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
    
    lazy var MinecollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        //collectionView.alwaysBounceVertical = true
        
        collectionView.register(MineDataCollectionViewCell.self, forCellWithReuseIdentifier: MineDataCell)
        collectionView.register(MedalCollectionViewCell.self, forCellWithReuseIdentifier: MedalCell)
        collectionView.contentInsetAdjustmentBehavior = .never
        
        return collectionView
    }()
    
    func ConfigUI() {
        self.view.addSubview(MinecollectionView)
        self.view.addSubview(setbutton)
        
        MinecollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalToSuperview().offset(900.fh)
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
            cell.editCallBack = { () in
                let vc = EditDataViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
//            cell.setCallBack = { () in
//                let vc = SetViewController()
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MedalCell, for: indexPath) as! MedalCollectionViewCell
            
            return cell
            
       }
        
    }
    
}

extension MineViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section{
        case 0:
            return CGSize(width: Int(UIScreen.main.bounds.width), height: 320)
        default:
            return CGSize(width: Int(UIScreen.main.bounds.width).fw, height: 400.fh)
        }
    }
  
}

