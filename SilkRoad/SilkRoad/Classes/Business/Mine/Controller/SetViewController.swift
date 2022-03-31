//
//  SetViewController.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/30.
//

import UIKit

class SetViewController: UIViewController {

    let SetCellID = "SetCell"
    let SetTwoCellID = "SetTwoCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        self.view.backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.953, alpha: 1)
        // Do any additional setup after loading the view.
        ConfigUI()
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
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(20)
            make.height.equalToSuperview().offset(300)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
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
            return 2
        case 2:
            return 2
        case 3:
            return 1
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: SetCellID, for: indexPath) as! SetTableViewCell
            cell.titleLabel.text = "我的收货地址"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: SetCellID, for: indexPath) as! SetTableViewCell
            let information = ["账号管理", "手机号码"]
            cell.titleLabel.text = information[indexPath.item]
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
       return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vi = UIView()
        vi.backgroundColor = .clear
        return vi
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 4 {
            return 15
        }
        else {
            return 180
        }
    }
    
}

