//
//  TestViewController.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/4/19.
//

import UIKit
import SnapKit

class TestViewController: UIViewController {
    
    lazy var dialogueView: CultureRelicDialogueView = {
        let vi = CultureRelicDialogueView()
        vi.actionImage = UIImage(named: "continue")
        vi.contents = "内容内容内容内容内容内容内容内容内容内容"
        vi.faceImage = UIImage(named: "cr_1")
        vi.backgroundViewColor = .white
        vi.backgroundView.layer.cornerRadius = 10
        vi.alpha = 0.5
        return vi
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(dialogueView)
        dialogueView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(15)
            maker.right.equalToSuperview().offset(-15)
            maker.bottom.equalToSuperview().offset(-40)
            maker.height.equalTo(150)
        }
    }

}
