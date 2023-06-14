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
    @IBOutlet weak var ScrollView: UIScrollView!
    
    
    let toolPicker = PKToolPicker.init()
    var savedDrawing = PKDrawing()
    let imagePicker = UIImagePickerController()
    var pickedImage:UIImage?
  //  var pin1ViewCenter : CGPoint = CGPointZero

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.ScrollView.minimumZoomScale = 1
//        self.ScrollView.maximumZoomScale = 2
//        self.ScrollView.delegate = self
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        canvasView.delegate = self
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
          view.addGestureRecognizer(pinchGesture)
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
    
    
    @IBAction func BtnAddImage(_ sender: Any) {
        
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        canvasView.drawing = PKDrawing()
        let alert:UIAlertController = UIAlertController(title:NSLocalizedString("Choose Image", comment: "") , message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title:NSLocalizedString("Camera", comment: "") , style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title:NSLocalizedString("Gallery", comment: "") , style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title:NSLocalizedString("Cancel", comment: "") , style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
        }
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        self.canvasView.isHidden = false
    }
    
    
    
    
    @IBAction func btnimageTapped(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageVC")as! ImageVC
        
        let img = UIGraphicsImageRenderer(bounds: canvasView.bounds).image{_ in
            view.drawHierarchy(in: canvasView.bounds, afterScreenUpdates: true)
        }
        vc.image = img
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
//MARK: -  Use for the gesture zoom in and zoom out :-
    
    
    @objc func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
        if gesture.state == .changed {
            let scale = gesture.scale
            
            // Apply the scale transformation to the first view
            ImgView.transform = ImgView.transform.scaledBy(x: scale, y: scale)
            
            // Apply the scale transformation to the second view
            canvasView.transform = canvasView.transform.scaledBy(x: scale, y: scale)
            
            
//            ImgView.transform = CGAffineTransform(scaleX: scale, y: scale)
//            canvasView.transform = CGAffineTransform(scaleX: scale, y: scale)
            
            gesture.scale = 1// Reset the gesture scale to 1 for incremental scaling

        }
        
//        if gesture.state == .ended {
//            ImgView.transform = .identity
//            canvasView.transform = .identity
//            }
    }
}


//MARK: - Extension view Controller :------

    extension ViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate{
     
        
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
        {
            if let image = info[.editedImage] as? UIImage {
                
                ImgView.image = image
                pickedImage = image
                
            }else if let image = info[.originalImage] as? UIImage {
                ImgView.image = image
                 pickedImage = image
            }

            self.dismiss(animated: true, completion: nil)
        }
        
        private func imagePickerControllerDidCancel(picker: UIImagePickerController)
        {
            dismiss(animated: true, completion: nil)
        }
      
        
        // Open camera
        func openCamera()
        {
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
            {
                
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                imagePicker.modalPresentationStyle = .fullScreen
                imagePicker.allowsEditing = true
                self .present(imagePicker, animated: true, completion: nil)
                
                
            } else {
                
            }
        }
        
        
        // Open Gallery
        func openGallery()
        {
            
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.modalPresentationStyle = .fullScreen
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        
// Use for the image zooming :-
        
        func viewForZooming( in scrollview:UIScrollView) -> UIView?{
            return canvasView
        }
    }
