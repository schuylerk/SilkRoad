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
    
    var roadMapCityLocation: Dictionary<String, RoadMapCityLocation> = [:]
    
    let roadMapHeight: CGFloat = screenHeight-CGFloat(150.fh)
    let roadMapWidth: CGFloat = (screenHeight-CGFloat(150.fh))*1.34

    lazy var scrollView: UIScrollView = {
        let scv = UIScrollView(frame: CGRect(x: 0, y: CGFloat(50.fh), width: screenWidth, height: roadMapHeight))
        scv.backgroundColor = .white
        scv.contentSize = CGSize(width: roadMapHeight*1.34, height: roadMapHeight)
        scv.addSubview(roadMapImageView)
        scv.alwaysBounceHorizontal = true
        scv.showsHorizontalScrollIndicator = false
        scv.contentOffset = CGPoint(x: roadMapHeight*1.34-screenWidth, y: 0)
        return scv
    }()
    
    lazy var roadMapImageView: UIImageView = {
        let imgV = UIImageView(frame: CGRect(x: 0, y: 0, width: roadMapHeight*1.34, height: roadMapHeight))
        imgV.image = UIImage(named: "vr_roadmap")
        imgV.contentMode = .scaleAspectFit
        imgV.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        imgV.addGestureRecognizer(gesture)
        return imgV
    }()
    
    @objc func tapHandler(gesture: UIGestureRecognizer) {
        let location = gesture.location(in: roadMapImageView)
        let (x, y) = (location.x/(roadMapHeight*1.34), location.y/roadMapHeight)
        print((x,y))
        let citiesLocation = roadMapCityLocation.filter { _, value -> Bool in
            return Float(x) >= value.minX &&
            Float(x) <= value.maxX &&
            Float(y) >= value.minY &&
            Float(y) <= value.maxY
        }
        if citiesLocation.count > 0 {
            if let (cityName, _) = citiesLocation.first {
                //MARK: 入口
                let mh = getMHFor(cityName)
                var overlays = [Overlay]()
                if let mh = mh {
                    var index = -1
                    if let inxlist = UserDefaults.standard.value(forKey: cityName + "_indexlist") as? [Int] {
                        overlays = inxlist.map { inx -> Overlay in
                            let position = SCNVector3Make(
                                mh[inx].position.x,
                                mh[inx].position.y,
                                mh[inx].position.z
                            )
                            let r1 = SCNMatrix4Rotate(SCNMatrix4Identity, mh[inx].rotation.x, 1, 0, 0)
                            let r2 = SCNMatrix4Rotate(r1, mh[inx].rotation.y, 0, 1, 0)
                            let rotation = SCNMatrix4Rotate(r2, mh[inx].rotation.z, 0, 0, 1)
                            index += 1
                            return mh[inx].type == 0 ?
                            Overlay(
                                width: 0.6,
                                height: 0.6,
                                position: position,
                                rotation: rotation,
                                cullMode: .back,
                                story: mh[inx].story,
                                type: mh[inx].type
                            ) :
                            Overlay(
                                width: 0.6,
                                height: 0.6,
                                position: position,
                                rotation: rotation,
                                cullMode: .back,
                                cultureRelic: mh[inx].cultureRelic,
                                type: mh[inx].type,
                                preRotation: Rotation(
                                    x: mh[inx].preRotation.x,
                                    y: mh[inx].preRotation.y,
                                    z: mh[inx].preRotation.z
                                )
                            )
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
                            let position = SCNVector3Make(
                                mh[inx].position.x,
                                mh[inx].position.y,
                                mh[inx].position.z
                            )
                            let r1 = SCNMatrix4Rotate(SCNMatrix4Identity, mh[inx].rotation.x, 1, 0, 0)
                            let r2 = SCNMatrix4Rotate(r1, mh[inx].rotation.y, 0, 1, 0)
                            let rotation = SCNMatrix4Rotate(r2, mh[inx].rotation.z, 0, 0, 1)
                            mh[inx].type == 0 ?
                            overlays.append(
                                Overlay(
                                    width: 0.6,
                                    height: 0.6,
                                    position: position,
                                    rotation: rotation,
                                    cullMode: .back,
                                    story: mh[inx].story,
                                    type: mh[inx].type
                                )
                            ) :
                            overlays.append(
                                Overlay(
                                    width: 0.6,
                                    height: 0.6,
                                    position: position,
                                    rotation: rotation,
                                    cullMode: .back,
                                    cultureRelic: mh[inx].cultureRelic,
                                    type: mh[inx].type,
                                    preRotation: Rotation(
                                        x: mh[inx].preRotation.x,
                                        y: mh[inx].preRotation.y,
                                        z: mh[inx].preRotation.z
                                    )
                                )
                            )
                        }//随机内容所在的盲盒.
                        UserDefaults.standard.set(indexList, forKey: cityName + "_indexlist")
                    }
                }
                print(overlays)
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
//                    let ocvc = OtherCityViewController()
//                    ocvc.cityName = cityName
//                    self.navigationController?.pushViewController(ocvc, animated: true)
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
        getRoadMapCityLocation {
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
                return MH(
                    type: json["type"].intValue,
                    story: json["story"].stringValue,
                    cultureRelic: CultureRelic(
                        intro: json["cultureRelic"]["intro"].stringValue,
                        name: json["cultureRelic"]["name"].stringValue,
                        dynasty: json["cultureRelic"]["dynasty"].stringValue,
                        face: json["cultureRelic"]["face"].stringValue,
                        num: json["cultureRelic"]["num"].intValue
                    ),
                    position: Position(
                        x: json["position"]["x"].floatValue,
                        y: json["position"]["y"].floatValue,
                        z: json["position"]["z"].floatValue
                    ),
                    rotation: Rotation(
                        x: json["rotation"]["x"].floatValue,
                        y: json["rotation"]["y"].floatValue,
                        z: json["rotation"]["z"].floatValue
                    ),
                    preRotation: Rotation(
                        x: json["pre_rotation"]["x"].floatValue,
                        y: json["pre_rotation"]["y"].floatValue,
                        z: json["pre_rotation"]["z"].floatValue
                    )
                )
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
                                minX: Float(value["minX"] as! CGFloat),
                                minY: Float(value["minY"] as! CGFloat),
                                maxX: Float(value["maxX"] as! CGFloat),
                                maxY: Float(value["maxY"] as! CGFloat))
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
                            let x = (i < 3 ? CGFloat(location.minX)*roadMapWidth-15 : CGFloat(location.maxX)*roadMapWidth+8)
                            let y = CGFloat(location.minY)*roadMapHeight+CGFloat(20*(i%3))
                            let (width, height) =
                            (
                                CGFloat(15),
                                CGFloat(15)
                            )
                            let imgV = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
                            imgV.image = UIImage(named: mh[inxlist[ indexes[i]]].type == 0 ? "mh_story" : "mh_culturerelic_2")
                            roadMapImageView.addSubview(imgV)
                        }
                    }
                } else {
                    let subviews = roadMapImageView.subviews
                    subviews.forEach { subview in
                        if let imgv = subview as? UIImageView {
                            let frame = imgv.frame
                            if (frame.minX == CGFloat(location.minX)*roadMapWidth-15) || (frame.minX == CGFloat(location.maxX)*roadMapWidth+8) {
                                imgv.removeFromSuperview()
                            }
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
