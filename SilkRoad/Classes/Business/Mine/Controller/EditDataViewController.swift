//
//  EditDataViewController.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/30.
//

import UIKit
import SnapKit

class EditDataViewController: UIViewController {

    let EditCellID = "EidtCell"
    let avatarCellID = "avatar"
    
    var didBack: (() -> Void)?
    
    var imagePickerController: UIImagePickerController!
    
    var indexPath: IndexPath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "编辑资料"
        navigationItem.leftBarButtonItem = UIBarButtonItem()
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 30.fw, height: 30.fw))
        let backImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30.fw, height: 30.fw))
        backImageView.image = UIImage(named: "back")
        backImageView.isUserInteractionEnabled = true
        backImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickLeftBackButton)))
        customView.addSubview(backImageView)
        navigationItem.leftBarButtonItem?.customView = customView
        configUI()
    }
        
    @objc func clickLeftBackButton(){
        navigationController?.popViewController(animated: true)
        tabBarController?.tabBar.isHidden = false
    }
    
    lazy var blackButton: UIButton = {
        let button = UIButton(frame: view.bounds)
        button.backgroundColor = .black
        button.alpha = 0.5
        button.isHidden = true
        button.addTarget(self, action: #selector(tapBlackButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tapBlackButton() {
        
    }
    
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(EditTableViewCell.self, forCellReuseIdentifier: EditCellID)
        tableview.register(EditAvatarTableViewCell.self, forCellReuseIdentifier: avatarCellID)
//        tableview.separatorStyle = .none
        tableview.backgroundColor = .clear
        tableview.showsVerticalScrollIndicator = false
        tableview.isScrollEnabled = false
        return tableview
    }()
    
    func configUI() {
        view.backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.953, alpha: 1)
        view.addSubview(tableView)
        view.addSubview(blackButton)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        didBack?()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let avatarCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? EditAvatarTableViewCell {
            avatarCell.setAvataImage()
        }
        if let usernameCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? EditTableViewCell {
            usernameCell.setAnswerLabelText(type: .username)
        }
        if let schoolCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? EditTableViewCell {
            schoolCell.setAnswerLabelText(type: .school)
        }
    }
    
}

extension EditDataViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 4
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: avatarCellID, for: indexPath) as! EditAvatarTableViewCell
                cell.titleLabel.text = "头像"
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: EditCellID, for: indexPath) as! EditTableViewCell
                cell.titleLabel.text = "昵称"
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: EditCellID, for: indexPath) as! EditTableViewCell
                cell.titleLabel.text = "学校"
                return cell
            default:
                return UITableViewCell()
            }
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
        return CGFloat(60.fh)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(1.fh)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self
                self.indexPath = indexPath
                present(imagePickerController, animated: true, completion: nil)
            case 1:
                let alterController = UIAlertController(title: "修改昵称", message: nil, preferredStyle: .alert)
                alterController.addTextField { tf in
                    tf.backgroundColor = .white
                    tf.textColor = .black
                }
                let cancleAction = UIAlertAction(title: "取消", style: .default) { [self] _ in
                    dismiss(animated: true, completion: nil)
                }
                let changeAction = UIAlertAction(title: "确认修改", style: .default) { _ in
                    if let tf = alterController.textFields?.first {
                        guard let text = tf.text, text != "" else {
                            return
                        }
                        UserDefaults.standard.set(text, forKey: "username")
                        if let usernameCell = tableView.cellForRow(at: indexPath) as? EditTableViewCell {
                            usernameCell.setAnswerLabelText(type: .username)
                        }
                    }
                }
                alterController.addAction(cancleAction)
                alterController.addAction(changeAction)
                present(alterController, animated: true, completion: nil)
            case 2:
                let addSchoolVC = AddSchoolViewController()
                addSchoolVC.selectSchoolBack = { school in
                    UserDefaults.standard.set(school, forKey: "user_school")
                    if let schoolCell = tableView.cellForRow(at: indexPath) as? EditTableViewCell {
                        schoolCell.setAnswerLabelText(type: .school)
                    }
                }
                navigationController?.pushViewController(addSchoolVC, animated: true)
            default: break
            }
        default: break
        }
    }
    
}

extension EditDataViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            if let cell = tableView.cellForRow(at: indexPath) as? EditAvatarTableViewCell {
                cell.updateImage(with: image)
                dismiss(animated: true, completion: nil)
                UserDefaults.standard.set(image.pngData()!, forKey: "avatar")
            }
        }
    }
    
}
