////
//  ViewController.swift
//  pencilKit
//
//  Created by user on 12/06/23.
//

import UIKit
import PencilKit


class ViewController: UIViewController ,PKCanvasViewDelegate{
    
    @IBOutlet weak var canvasView: PKCanvasView!
    
    @IBOutlet weak var ImgView: UIImageView!
    
    let toolPicker = PKToolPicker.init()
    var savedDrawing = PKDrawing()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvasView.delegate = self
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setupCanvasView()
        
        
    }
    
    func setupCanvasView() {
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        toolPicker.isRulerActive = false
        canvasView.isOpaque = true
        canvasView.backgroundColor = .clear
        canvasView.becomeFirstResponder()
        
        
    }
    @IBAction func btnClearTapped(_ sender: Any) {
        canvasView.drawing = PKDrawing()
        
    }
    
    @IBAction func btnimageTapped(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageVC")as! ImageVC
        
        let img = UIGraphicsImageRenderer(bounds: canvasView.bounds).image{_ in
            view.drawHierarchy(in: canvasView.bounds, afterScreenUpdates: true)
        }
        vc.image = img
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
//    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
//        print("canvasViewDrawingDidChange")
//        //  savedDrawing = canvasView.drawing
//
//        // self.canvasView.drawing = savedDrawing
//
//    }
//        func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
//            //self.canvasView.drawing = savedDrawing
//            print("CanvasViewDidEndUsingTool")
//
//        }
//
//        func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
//
//
//        }
//
        
        
    
    
}
