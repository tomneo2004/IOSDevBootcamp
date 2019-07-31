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
import SwiftyJSON
import Alamofire
import SDWebImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    let wikiURL = "https://en.wikipedia.org/w/api.php"
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
            
            self.getDescription(classification!.identifier)
        }
        
        let handler = VNImageRequestHandler(ciImage: ciimage)
        
        do{
            try handler.perform([request])
        }
        catch{
            print(error)
        }
    }
    
    func getDescription(_ flowerName : String){
        
        let parameters = [
            
            "format":"json",
            "action":"query",
            "prop":"extracts",
            "exintro":"",
            "explaintext":"",
            "titles":flowerName,
            "indexpageids":"",
            "redirects":"1",
            "pithumbsize":"500"
        ]
        
        Alamofire.request(wikiURL, parameters: parameters).responseData { (response) in
            
            if let err = response.error{
                print(err)
            }
            else{
                if let data = response.result.value{
                    
                    do {
                        let jsonData = try JSON(data: data)
                        let pageId = jsonData["query"]["pageids"][0].stringValue
                        let text = jsonData["query"]["pages"][pageId]["extract"].stringValue
                        let imageURL = jsonData["query"]["pages"][pageId]["thumbnail"]["source"].stringValue
                        
                        DispatchQueue.main.async {
                            if !imageURL.isEmpty{
                                self.imageView.sd_setImage(with: URL(string: imageURL), completed: nil)
                            }
                            
                            self.textView.text = text
                        }
                    }
                    catch{
                        print(error)
                    }
                    
                }
            }
        }
    }

    @IBAction func cameraPress(_ sender: UIBarButtonItem) {
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
}

