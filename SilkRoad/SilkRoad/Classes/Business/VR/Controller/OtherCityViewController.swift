//
//  OtherCityViewController.swift
//  GA
//
//  Created by WSH on 2022/4/14.
//

import UIKit
import SwiftyJSON

class OtherCityViewController: UIViewController {

    var CityLabel: [String: OtherCity] = [:]
    
    var cityName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        handyJSON()
        ConfigUI()
        Animation()
    }
    
    func handyJSON(){
           do{
               let data = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "otherCity", ofType: "json")!))
               if let jsonData = String(data: data,encoding: .utf8){
                   let json = JSON(parseJSON: jsonData)
                   guard let jsonarray = json.array else{return}
                   let _ = jsonarray.map{ json -> Void in
                       CityLabel[json["cityName"].stringValue] = OtherCity(
                           cityName: json["cityName"].stringValue,
                           label1: json["label1"].stringValue,
                           label2: json["label2"].stringValue,
                           label3: json["label3"].stringValue
                       )
                   }
               }
               else {print("false")}
           }
           catch{
               print("false")
           }
       }
       
    lazy var backimage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "back2")
        return imageView
    }()
    
    lazy var name: UILabel = {
        let label = UILabel(frame: CGRect(x: 50, y: 40, width: screenWidth, height: 80))
        label.numberOfLines = 0
        label.font = UIFont(name: "Arial", size: 32)
        label.textColor = .black
        return label
    }()
    
    lazy var label1: UILabel = {
        let label = UILabel(frame: CGRect(x: -340, y: 120, width: 340, height: 150))
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
   
    lazy var label2: UILabel = {
        let label = UILabel(frame: CGRect(x: -340, y: 340, width: 340, height: 200))
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    lazy var label3: UILabel = {
        let label = UILabel(frame: CGRect(x: -340, y: 640, width: 340, height: 200))
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "vr_back"), for: .normal)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func ConfigUI() {
        view.addSubview(backimage)
        self.view.addSubview(label1)
        self.view.addSubview(label2)
        self.view.addSubview(label3)
        self.view.addSubview(backButton)
        self.view.addSubview(name)
        
        name.text = cityName
        label1.text = CityLabel[cityName]?.label1 //这里需要传值！！！！
        label2.text = CityLabel[cityName]?.label2
        label3.text = CityLabel[cityName]?.label3
        
        
        backButton.snp.makeConstraints { maker in  //等写完了把这个注销改回来就行！！！
            maker.left.equalToSuperview().offset(15.fw)
            maker.top.equalToSuperview().offset(50.fh)
            maker.width.height.equalTo(30)
        }
        
        backimage.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().offset(0)
        }
        
    }
    
    func Animation() {
        
        UIView.animate(withDuration: 3, delay: 1, animations: {
            self.label1.transform = CGAffineTransform(translationX: 360, y: 0)
        })
        
        UIView.animate(withDuration: 3, delay: 3, animations: {
            self.label2.transform = CGAffineTransform(translationX: 380, y: 0)
        })
        UIView.animate(withDuration: 3, delay: 6, animations: {
            self.label3.transform = CGAffineTransform(translationX: 380, y: 0)
        })
    }
    
}
