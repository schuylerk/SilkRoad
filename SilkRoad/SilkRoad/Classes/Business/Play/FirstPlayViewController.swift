//
//  FirstPlayViewController.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/5/1.
//

import UIKit
import PencilKit

class FirstPlayViewController: UIViewController {
//
//    lazy var canvasView: PKCanvasView = {
//        let cv = PKCanvasView(frame: view.frame)
//        cv.backgroundColor = .white
//        return cv
//    }()
//
//    var toolPicker: PKToolPicker!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//
//        setUI()
//        toolPicker = PKToolPicker()
//        toolPicker.setVisible(true, forFirstResponder: canvasView)
//        toolPicker.addObserver(canvasView)
////        self.canvasView.drawing = PKDrawing()
//        self.canvasView.becomeFirstResponder()
//        UIGraphicsImageRenderer(bounds: canvasView.bounds).image{_ in (
//            view.drawHierarchy(in: self.canvasView.bounds, afterScreenUpdates: true) )}
//    }
//
//    func setUI() {
//        view.addSubview(canvasView)
//    }

}

extension FirstPlayViewController: PKCanvasViewDelegate {
    
    func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
        print("using tool")
    }
    
}
