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
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        ConfigUI()
    }
    lazy var leftButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "back"), for: .normal)
            button.frame = CGRect(x: 20.fw, y: 50.fh, width: 30.fw, height: 30.fh)
            button.addTarget(self, action: #selector(clickLeftBackButton), for: .allEvents)
            
            return button
        }()
        
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
        self.view.addSubview(tableView)
        self.view.addSubview(leftButton)
        
//        navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(image: <#T##UIImage?#>, style: .done, target: self, action: <#T##Selector?#>)
        
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(50.fh)
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
            return 0
        case 1:
            return 1
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
            cell.titleLabel.text = "我的收货地址"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: SetCellID, for: indexPath) as! SetTableViewCell
            let information = ["清除缓存", "手机号码"]
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
        return CGFloat(50.fh)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vi = UIView()
        vi.backgroundColor = .clear
        return vi
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 4 {
            return CGFloat(15.fh)
        }
        else {
            return CGFloat(180.fh)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 && indexPath.row == 0 {
            removeUserDefaults()
            let alterController = UIAlertController(title: "提示", message: "清除缓存成功", preferredStyle: .alert)
            present(alterController, animated: true, completion: { [self] in
                dismiss(animated: true, completion: nil)
            })
        }
    }
    
}

