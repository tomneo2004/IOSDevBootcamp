//
//  ViewController.swift
//  SeePets
//
//  Created by Nelson on 2/8/19.
//  Copyright © 2019 Nelson. All rights reserved.
//

import UIKit
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
        
        let alertController = UIAlertController(title: "Pick one", message: "", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (alertAction) in
            self.imagePicker.sourceType = .camera
            self.navigationController?.present(self.imagePicker, animated: true, completion: nil)
        }
        let libraryAction = UIAlertAction(title: "Photo Library", style: .default) { (alertAction) in
            self.imagePicker.sourceType = .photoLibrary
            self.navigationController?.present(self.imagePicker, animated: true, completion: nil)
        }
        let albumAction = UIAlertAction(title: "Album", style: .default) { (alertAction) in
            self.imagePicker.sourceType = .savedPhotosAlbum
            self.navigationController?.present(self.imagePicker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alertAction) in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(cameraAction)
        alertController.addAction(libraryAction)
        alertController.addAction(albumAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else{
            fatalError("No image")
        }
        
        imageView.image = image
        
        detect(CIImage(image: image)!)
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func detect(_ ciimage:CIImage){
        
        let classifier = ImageClassifier()
        guard let model = try? VNCoreMLModel(for: classifier.model) else{
            
            fatalError("can not create model")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            
            if let err = error{
                print(err)
            }
            else{
                
                let result = request.results!.first as! VNClassificationObservation
                
                self.navigationItem.title = "\(result.identifier) \(result.confidence)"
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: ciimage)
        
        do{
            try handler.perform([request])
        }
        catch{
            print(error)
        }
    }

}

