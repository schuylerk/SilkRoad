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
    
    let roadMapHeight: CGFloat = 850
    
    var roadMapCityLocation: Dictionary<String, RoadMapCityLocation> = [:]
    
    lazy var scrollView: UIScrollView = {
        let scv = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: CGFloat(Int(roadMapHeight).fh)))
//        scv.frame.size = CGSize(width: screenWidth, height: roadMapHeight)
//        scv.center = view.center
        scv.backgroundColor = .white
        scv.contentSize = CGSize(width: screenWidth*2.5, height: CGFloat(Int(roadMapHeight).fh))
        scv.addSubview(roadMapImageView)
        scv.showsHorizontalScrollIndicator = false
        return scv
    }()
    
    lazy var roadMapImageView: UIImageView = {
        let imgV = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth*2.5, height: CGFloat(Int(roadMapHeight).fh)))
        imgV.image = UIImage(named: "vr_roadmap")
        imgV.contentMode = .scaleAspectFit
        imgV.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        imgV.addGestureRecognizer(gesture)
        return imgV
    }()
    
    @objc func tapHandler(gesture: UIGestureRecognizer) {
        let location = gesture.location(in: roadMapImageView)
        print(location.x, location.y)
        let citiesLocation = roadMapCityLocation.filter { _, value -> Bool in
            return Int(location.x) >= value.minX.fw &&
            Int(location.x) <= value.maxX.fw &&
            Int(location.y) >= value.minY.fh &&
            Int(location.y) <= value.maxY.fh
        }
        if citiesLocation.count > 0 {
            if let (cityName, _) = citiesLocation.first {
                //MARK: 入口
                let mh = getMHFor(cityName)
                var overlays = [Overlay]()
                if let mh = mh {
                    let x: [Float] = [0,0.4,0.8,1.2,1.6,2.0]
                    var index = -1
                    if let inxlist = UserDefaults.standard.value(forKey: cityName + "_indexlist") as? [Int] {
                        overlays = inxlist.map { inx -> Overlay in
                            index += 1
                            return mh[inx].type == 0 ?
                            Overlay(width: 0.6, height: 0.6, position: SCNVector3Make(x[index], -0.7, -4.5), rotation: nil, cullMode: .back, story: mh[inx].story, type: mh[inx].type) :
                            Overlay(width: 0.6, height: 0.6, position: SCNVector3Make(x[index], -0.7, -4.5), rotation: nil, cullMode: .back, cultureRelic: mh[inx].cultureRelic, type: mh[inx].type)
                        }
                    } else {
                        let count = mh.count
                        var isVisited: [Int] = Array(repeating: 0, count: count)
                        var indexList: [Int] = []
                        for _ in 0..<count {
                            var inx = Int(arc4random()) % count
                            while isVisited[inx] == 1 {
                                inx = Int(arc4random()) % count
                            }
                            isVisited[inx] = 1
                            indexList.append(inx)
                            index += 1
                            mh[inx].type == 0 ?
                            overlays.append(Overlay(width: 0.6, height: 0.6, position: SCNVector3Make(x[index], -0.7, -4.5), rotation: nil, cullMode: .back, story: mh[inx].story, type: mh[inx].type)) :
                            overlays.append(Overlay(width: 0.6, height: 0.6, position: SCNVector3Make(x[index], -0.7, -4.5), rotation: nil, cullMode: .back, cultureRelic: mh[inx].cultureRelic, type: mh[inx].type))
                        }//随机内容所在的盲盒.
                        UserDefaults.standard.set(indexList, forKey: cityName + "_indexlist")
                    }
                }
                let vc = ShowVRViewController()
                vc.overlays = overlays
                vc.cityNameCN = cityName
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
                    let ocvc = OtherCityViewController()
                    ocvc.cityName = cityName
                    self.navigationController?.pushViewController(ocvc, animated: true)
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
        getRoadMapCityLocation { [self] in
//            configColletedImageView()
        }
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
    
    func getMHFor(_ cityName: String) -> [MH]? {
        var res: [MH] = []
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "mh", ofType: "json")!))
            guard let jsonString = String(data: data, encoding: .utf8) else { return nil }
            let json = JSON(parseJSON: jsonString)
            guard let currentCityJson = json[cityName].array else { return nil }
            res = currentCityJson.map { json -> MH in
                return MH(type: json["type"].intValue, story: json["story"].stringValue, cultureRelic: CultureRelic(name: json["cultureRelic"]["name"].stringValue,num: json["cultureRelic"]["num"].intValue))
            }
            return res
        } catch {
            return nil
        }
    }
    
    func getRoadMapCityLocation(completion: @escaping ()->Void) {
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
            completion()
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
    
    func configColletedImageView() {
        let cities = ["西安", "兰州", "西宁", "敦煌", "乌鲁木齐"]
        cities.forEach { cityName in
            let location = roadMapCityLocation[cityName]!
            if let mh = getMHFor(cityName) {
                if let indexes = getOpenedMHIndexes(cityName: cityName) {
                    if let inxlist = UserDefaults.standard.value(forKey: cityName + "_indexlist") as? [Int] {
                        for i in 0..<indexes.count {
                            let (x, y, width, height) =
                            (
                                i < 3 ? location.minX-20 : location.maxX+5,
                                location.minY+20*(i%3),
                                15,
                                15
                            )
                            let imgV = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
                            imgV.image = UIImage(named: mh[inxlist[ indexes[i]]].type == 0 ? "mh_story" : "mh_culturerelic_2")
                            roadMapImageView.addSubview(imgV)
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configColletedImageView()
    }

}
