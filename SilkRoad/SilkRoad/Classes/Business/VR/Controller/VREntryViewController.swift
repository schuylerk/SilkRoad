//
//  VREntryViewController.swift
//  SilkRoad
//
//  Created by student on 2022/4/1.
//

import UIKit
import SnapKit
import SceneKit
import SwiftyJSON

class VREntryViewController: UIViewController {
    
    let roadMapHeight: CGFloat = 750
    
    var roadMapCityLocation: Dictionary<String, RoadMapCityLocation> = [:]
    
    lazy var scrollView: UIScrollView = {
        let scv = UIScrollView()
        scv.frame.size = CGSize(width: screenWidth, height: roadMapHeight)
        scv.center = view.center
        scv.backgroundColor = .systemGray3
        scv.contentSize = CGSize(width: screenWidth*3, height: roadMapHeight)
        scv.addSubview(roadMapImageView)
        scv.showsHorizontalScrollIndicator = false
        return scv
    }()
    
    lazy var roadMapImageView: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "vr_roadmap")
        imgV.frame.origin = CGPoint(x: 0, y: 0)
        imgV.contentMode = .scaleAspectFill
        imgV.frame.size = CGSize(width: screenWidth*3, height: roadMapHeight)
        imgV.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        imgV.addGestureRecognizer(gesture)
        return imgV
    }()
    
    @objc func tapHandler(gesture: UIGestureRecognizer) {
        let location = gesture.location(in: roadMapImageView)
        let citiesLocation = roadMapCityLocation.filter { _, value -> Bool in
            return Int(location.x) >= value.minX &&
            Int(location.x) <= value.maxX &&
            Int(location.y) >= value.minY &&
            Int(location.y) <= value.maxY
        }
        if citiesLocation.count > 0 {
            if let (cityName, _) = citiesLocation.first {
                //MARK: 入口
                
                let cultureRelics = getCultureRelicFor(cityName)
                var overlays = [Overlay]()
                if let cultureRelics = cultureRelics {
                    overlays =  cultureRelics.map { cultureRelic -> Overlay in
                        
                        //暂时文物位置随机设置
                        let x = Float.random(in: -10.0...10.0)
                        let y = Float.zero
                        let z = -sqrtf(100 - x * x) + 1
                        
                        return Overlay(width: 1, height: 1, position: SCNVector3Make(x, y, z), rotation: nil, cullMode: .back, cultureRelic: cultureRelic)
                    }
                }
                let vc = ShowVRViewController()
                vc.overlays = overlays
                switch cityName {
                case "西安":
                    vc.cityName = "xian"
                case "兰州":
                    vc.cityName = "lanzhou"
                case "乌鲁木齐":
                    vc.cityName = "xinjiang"
                case "西宁":
                    vc.cityName = "xining"
                case "敦煌":
                    vc.cityName = "dunhuang"
                default:
                    self.navigationController?.pushViewController(OtherCityViewController(), animated: true)
                    return
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setNav()
        getRoadMapCityLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    func getCultureRelicFor(_ cityName: String) -> [CultureRelic]? {
        var res: [CultureRelic] = []
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "cultureRelic", ofType: "json")!))
            guard let jsonString = String(data: data, encoding: .utf8) else { return nil }
            let json = JSON(parseJSON: jsonString)
            guard let currentCityJson = json[cityName].array else { return nil }
            res = currentCityJson.map { json -> CultureRelic in
                return CultureRelic(
                    intro: json["intro"].stringValue, name: json["name"].stringValue,
                    unearthedYear: json["unearthedYear"].stringValue,
                    unearthPlace: json["unearthPlace"].stringValue,
                    dynasty: json["dynasty"].stringValue,
                    history: json["history"].stringValue,
                    evaluationStatus: json["evaluationStatus"].stringValue,
                    face: json["face"].stringValue)
            }
            return res
        } catch {
            return nil
        }
    }
    
    func getRoadMapCityLocation() {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "roadMapCityLocation", ofType: "json")!))
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                jsonObject.forEach { key, value in
                    if let value = value as? NSDictionary {
                        if let key = key as? String {
                            roadMapCityLocation[key] = RoadMapCityLocation(
                                minX: value["minX"] as! Int,
                                minY: value["minY"] as! Int,
                                maxX: value["maxX"] as! Int,
                                maxY: value["maxY"] as! Int)
                        }
                    }
                }
            }
        } catch {
            
        }
    }
    
    func setUI() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
    }
    
    func setNav() {
        navigationController?.navigationBar.isHidden = true
    }

}
