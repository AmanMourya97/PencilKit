//
//  ImageVC.swift
//  pencilKit
//
//  Created by user on 13/06/23.
//

import UIKit

class ImageVC: UIViewController {
    
    var image = UIImage()

    @IBOutlet weak var imagCapture: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagCapture.image = image

    }
}
