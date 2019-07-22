//
//  ViewController.swift
//  Seafood
//
//  Created by Nelson on 22/7/19.
//  Copyright © 2019 Nelson. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func cameraPress(_ sender: UIBarButtonItem) {
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.originalImage] as? UIImage{
            
            imageView.image = pickedImage
            
            guard let image = CIImage(image: pickedImage) else{
                fatalError("not able to convert image into CIImage")
            }
            
            detect(image: image)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detect(image:CIImage){
        
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else{
            fatalError("can not load model")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            
            guard let result = request.results as? [VNClassificationObservation] else{
                fatalError("model fail to prcess image")
            }
            
            if (result.first?.identifier.contains("hot dog"))!{
                self.title = "Hot dog"
            }
            else{
                self.title = "Not Hotdog"
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do{
            try handler.perform([request])
        }
        catch{
            print(error)
        }
    }
}

