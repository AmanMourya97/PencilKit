//
//  ImageVC.swift
//  pencilKit
//
//  Created by user on 13/06/23.
//

import UIKit
import Photos


class ImageVC: UIViewController ,UIImagePickerControllerDelegate{
    
    var image = UIImage()

    @IBOutlet weak var imagCapture: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagCapture.image = image

    }
    @IBAction func btnDownloadImgAction(_ sender: Any) {
     
                self.saveImageToGallery(image: self.image) { success, error in
                    if success {
                        // Image saved successfully
                        // You can perform any additional tasks here
                        print("Image saved to gallery.")
                        AppDelegate.Shared.showAlert(title: "Alert", message: "Image saved to gallery.", view: self)
                           
                    } else {
                        // Failed to save the image
                        if let error = error {
                            print("Error: \(error.localizedDescription)")
                            AppDelegate.Shared.showAlert(title: "Alert", message: "Error", view: self)
                        } else {
                            print("Failed to save the image.")
                            AppDelegate.Shared.showAlert(title: "Alert", message: "Failed to save the image.", view: self)
                          
                        }
                    }
              }
        }

//MARK: - Func for save image:----
    
    func saveImageToGallery(image: UIImage, completion: @escaping (Bool, Error?) -> Void) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        }) { success, error in
            DispatchQueue.main.async {
                if success {
                    // Image saved successfully
                    completion(true, nil)
                } else {
                    // Failed to save the image
                    completion(false, error)
                }
            }
        }
    }
}
