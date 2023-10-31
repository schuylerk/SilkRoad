//
//  SetViewController.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/30.
//

import UIKit
import SnapKit

class SetViewController: UIViewController {

    let SetCellID = "SetCell"
    let SetTwoCellID = "SetTwoCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        self.view.backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.953, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem()
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 30.fw, height: 30.fw))
        let backImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30.fw, height: 30.fw))
        backImageView.image = UIImage(named: "back")
        backImageView.isUserInteractionEnabled = true
        backImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickLeftBackButton)))
        customView.addSubview(backImageView)
        navigationItem.leftBarButtonItem?.customView = customView
        ConfigUI()
    }
        
    @objc func clickLeftBackButton(){
        self.navigationController?.popViewController(animated: true)
        tabBarController?.tabBar.isHidden = false
    }
    
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(SetTableViewCell.self, forCellReuseIdentifier: SetCellID)
        tableview.register(SettwoTableViewCell.self, forCellReuseIdentifier: SetTwoCellID)
        tableview.separatorStyle = .none
        tableview.backgroundColor = .clear
        tableview.showsVerticalScrollIndicator = false
        tableview.isScrollEnabled = false
        return tableview
    }()
    
    func ConfigUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
    }
    

}

extension SetViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 0
        case 2:
            return 0
        case 3:
            return 0
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: SetCellID, for: indexPath) as! SetTableViewCell
            let information = ["清除缓存", "手机号码"]
            cell.titleLabel.text = information[indexPath.item]
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: SetCellID, for: indexPath) as! SetTableViewCell
            cell.titleLabel.text = "我的收货地址"
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: SetCellID, for: indexPath) as! SetTableViewCell
            let informations = ["通用", "辅助功能"]
            cell.titleLabel.text = informations[indexPath.item]
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: SetCellID, for: indexPath) as! SetTableViewCell
            cell.titleLabel.text = "隐私政策摘要"
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: SetTwoCellID, for: indexPath) as! SettwoTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50.fh)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 4 {
            return CGFloat(1.fh)
        }
        else {
            return CGFloat(180.fh)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 && indexPath.row == 0 {
            var alertController = UIAlertController(title: "提示", message: "清除缓存将会清除答题记录和盲盒收集数据，是否继续？", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "取消", style: .default, handler: { _ in
                self.dismiss(animated: true, completion: nil)
            }))
            alertController.addAction(UIAlertAction(title: "继续", style: .default, handler: { [self] _ in
                removeUserDefaults()
                alertController = UIAlertController(title: "提示", message: "清除缓存成功", preferredStyle: .alert)
                present(alertController, animated: true, completion: {
                    dismiss(animated: true, completion: nil)
                })
            }))
            present(alertController, animated: true, completion: nil)
        }
    }
    
}

