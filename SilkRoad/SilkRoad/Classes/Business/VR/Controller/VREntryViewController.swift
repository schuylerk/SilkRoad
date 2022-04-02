//
//  VREntryViewController.swift
//  SilkRoad
//
//  Created by student on 2022/4/1.
//

import UIKit
import SnapKit

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
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setNav()
        getRoadMapCityLocation()
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
