//
//  PlayViewController.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/5/1.
//

import UIKit
import SnapKit

class PlayViewController: UIViewController {
    
    var data: [Game] = [
        Game(name: "自制葫芦", intro: "来了解丝绸之路上的果实所蕴含的吉祥寓意，并在葫芦上绘画出自己喜欢的“佳果”吧!", imageName: "tumo"),
        Game(name: "刮画", intro: "赤土色为丝绸之路上交易的陶器的颜色，快来刮画创造出属于自己的那件陶器吧!", imageName: "guaguaqia")
    ]
    let gameCellReuseID = "game"
    
    lazy var colorLayer: ColorLayer = {
        let layer = ColorLayer(
            CGPoint(x: 0.5, y: 0),
            endPoint: CGPoint(x: 0.5, y: 1.0),
            colors: [UIColor(hex: "#FFCCA3").cgColor, UIColor(hex: "#F8F8F8").cgColor],
            locations: [0, 0.5])
        layer.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        return layer
    }()
    
    lazy var playListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: Int(screenWidth) - 80.fw, height: 300.fh)
        layout.minimumLineSpacing = CGFloat(50.fh)
        let clv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        clv.delegate = self
        clv.dataSource = self
        clv.register(GameCell.self, forCellWithReuseIdentifier: gameCellReuseID)
        clv.backgroundColor = .clear
        return clv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
        view.layer.addSublayer(colorLayer)
        view.addSubview(playListCollectionView)
        playListCollectionView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(40.fw)
            maker.right.equalToSuperview().offset(-40.fw)
            maker.top.equalToSuperview().offset(50.fh)
            maker.bottom.equalToSuperview().offset(-50.fh)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNav()
        tabBarController?.tabBar.isHidden = false
    }
    
    func setNav() {
        //self.title = "寓教于乐"
        navigationController?.navigationBar.isHidden = false
    }

}

extension PlayViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCellReuseID, for: indexPath) as! GameCell
        cell.imageView.image = UIImage(named: data[indexPath.row].imageName)
        cell.nameLabel.text = data[indexPath.row].name
        cell.introLabel.text = data[indexPath.row].intro
        cell.backgroundColor = .white
        cell.layer.cornerRadius = CGFloat(20.fh)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("aa")
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(HomemadeGourdViewController(), animated: true)
        case 1:
            navigationController?.pushViewController(ScrapingViewController(), animated: true)
        default:
            break
        }
    }
    
}
