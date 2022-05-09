//
//  EditDataViewController.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/30.
//

import UIKit

class EditDataViewController: UIViewController {

    let EditCellID = "EidtCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "编辑资料"
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
        tableview.register(EditTableViewCell.self, forCellReuseIdentifier: EditCellID)
        tableview.separatorStyle = .none
        tableview.backgroundColor = .clear
        tableview.showsVerticalScrollIndicator = false
        tableview.isScrollEnabled = false
        return tableview
    }()
    
    func ConfigUI() {
        self.view.addSubview(tableView)
        view.addSubview(leftButton)
        
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(0.fw)
            make.right.equalToSuperview().offset(0.fw)
            make.top.equalToSuperview().offset(20.fh)
            make.height.equalToSuperview().offset(300.fh)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
}

extension EditDataViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 4
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: EditCellID, for: indexPath) as! EditTableViewCell
            cell.titleLabel.text = "昵称"
            cell.answerLabel.text = "小王子"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: EditCellID, for: indexPath) as! EditTableViewCell
            let information = ["性别", "年龄", "生日","所在地"]
            let information2 = ["女", "18岁","9月11日", "湖南-株洲-天元区"]
            cell.titleLabel.text = information[indexPath.item]
            cell.answerLabel.text = information2[indexPath.item]
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: EditCellID, for: indexPath) as! EditTableViewCell
            cell.titleLabel.text = "更多"
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
        return CGFloat(20.fh)
    }
    
    
}
