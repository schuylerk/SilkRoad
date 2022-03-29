//
//  VRViewController.swift
//  SilkRoad
//
//  Created by student on 2022/3/25.
//

import UIKit

class VRViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .white
        self.present(IntroductionCultureRelicViewController(CultureRelic(
            name: "敦煌大鼎",
            unearthedYear: 1987,
            unearthPlace: "敦煌",
            dynasty: "明朝",
            history: "我是文字我是文字我是文字我是文字我是文字我是文字我是文字我是文字我是文字我是文字",
            evaluationStatus: "我是文字我是文字我是文字我是文字我是文字我是文字我是文字我是文字")), animated: true, completion: nil)
    }

}
