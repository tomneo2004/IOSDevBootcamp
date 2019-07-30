//
//  ViewController.swift
//  WhatFlower
//
//  Created by Nelson on 30/7/19.
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as? UIImage
        
        imageView.image = image
        
        guard let ciimage = CIImage(image: image!) else{
            fatalError("Can not convert UIImage to CIImage")
        }
        
        detect(ciimage)
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func detect(_ ciimage : CIImage){
        
        guard let model = try? VNCoreMLModel(for: flowerClassifier().model) else{
            fatalError("Import model fail")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            
            let classification = request.results?.first as? VNClassificationObservation
            self.navigationItem.title = classification?.identifier
        }
        
        let handler = VNImageRequestHandler(ciImage: ciimage)
        
        do{
            try handler.perform([request])
        }
        catch{
            print(error)
        }
    }

    @IBAction func cameraPress(_ sender: UIBarButtonItem) {
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
}

