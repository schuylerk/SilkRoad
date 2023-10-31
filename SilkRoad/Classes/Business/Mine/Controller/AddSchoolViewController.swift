//
//  AddSchoolViewController.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/9/7.
//

import UIKit

class AddSchoolViewController: UIViewController {
    
    let schoolReusedCellID = "school"
    var schools: [String] = []
    var displaySchools: [String] = []
    var selectSchoolBack: ((String) -> Void)?
    
    lazy var searchTextField: UISearchTextField = {
        let tf = UISearchTextField(frame: CGRect(x: 30.fw, y: 100.fh, width: Int(screenWidth)-110.fw, height: 40.fh))
        tf.delegate = self
        return tf
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(frame: CGRect(x: Int(screenWidth) - 70.fw, y: 100.fh, width: 70.fw, height: 36.fh))
        button.setTitle("搜索", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(search), for: .touchUpInside)
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tbv = UITableView(frame: CGRect(x: 0, y: 150.fh, width: Int(screenWidth), height: Int(screenHeight) - 150.fh))
        tbv.delegate = self
        tbv.dataSource = self
        tbv.register(UITableViewCell.self, forCellReuseIdentifier: schoolReusedCellID)
        return tbv
    }()
    
    @objc func search() {
        blackButton.isHidden = true
        searchTextField.resignFirstResponder()
        let text = searchTextField.text ?? ""
        if text.count == 0 {
            displaySchools = schools
            tableView.reloadData()
            return
        }
        var actualSchools = [String]()
        schools.forEach { school in
            var index = 0
            for i in 0 ..< school.count {
                if school[school.index(school.startIndex, offsetBy: i)] == text[text.index(text.startIndex, offsetBy: index)] { index += 1 }
                if index == text.count {
                    actualSchools.append(school)
                    break
                }
            }
        }
        displaySchools = actualSchools
        tableView.reloadData()
    }
    
    lazy var blackButton: UIButton = {
        let button = UIButton(frame: view.bounds)
        button.backgroundColor = .clear
        button.isHidden = true
        button.addTarget(self, action: #selector(tapBlackButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tapBlackButton() {
        blackButton.isHidden = true
        searchTextField.resignFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        schools = (UserDefaults.standard.value(forKey: "schools") as? [String]) ?? []
        displaySchools = schools
        setUI()
        setNav()
    }
    
    func setUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(blackButton)
        view.addSubview(searchButton)
        view.addSubview(searchTextField)
    }
    
    func setNav() {
        title = "添加学校"
        navigationItem.leftBarButtonItem = UIBarButtonItem()
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 30.fw, height: 30.fw))
        let backImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30.fw, height: 30.fw))
        backImageView.image = UIImage(named: "back")
        backImageView.isUserInteractionEnabled = true
        backImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickLeftBackButton)))
        customView.addSubview(backImageView)
        navigationItem.leftBarButtonItem?.customView = customView
    }
    
    @objc func clickLeftBackButton(){
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

}

extension AddSchoolViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displaySchools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: schoolReusedCellID, for: indexPath)
        if #available(iOS 14.0, *) {
            var configuration = cell.defaultContentConfiguration()
            configuration.text = displaySchools[indexPath.row]
            configuration.textProperties.color = .black
            cell.contentConfiguration = configuration
        } else {
            // Fallback on earlier versions
            cell.textLabel?.text = displaySchools[indexPath.row]
            cell.textLabel?.textColor = .black
        }
        return cell
    }
    
}

extension AddSchoolViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectSchoolBack?(displaySchools[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
    
}

extension AddSchoolViewController: UISearchTextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        blackButton.isHidden = false
    }
    
}
