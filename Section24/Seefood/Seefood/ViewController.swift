//
//  ViewController.swift
//  Seefood
//
//  Created by Nelson on 22/7/19.
//  Copyright © 2019 Nelson. All rights reserved.
//

import UIKit
import VisualRecognitionV3
import SVProgressHUD
import Social

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    
    let imagePicker = UIImagePickerController()
    
    let apiKey = "tR184XphImL4ZDf4ZxHsBir4XiuJT30R6IZJ3ul_K7I3"
    let version = "2019-07-22"
    
    var classes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        shareButton.isHidden = true
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
        
        
        let imageData = image.jpegData(compressionQuality: 0.01)
        guard let lowImage = UIImage(data: imageData!) else{
            
            fatalError("compresse image fail")
        }
        
        shareButton.isHidden = true
        cameraButton.isEnabled = false
        SVProgressHUD.show()
        
        imageView.image = lowImage
        
        let model = VisualRecognition(version: version, apiKey: apiKey)
        model.classify(image: lowImage) { (response, error) in
            
            if let _ = error {
                fatalError("an error occured")
            }
            
            let allClasses = response!.result!.images.first!.classifiers.first!.classes
            
            self.classes.removeAll()
            
            for i in 0..<allClasses.count{
                self.classes.append(allClasses[i].className)
            }
            
            //print(self.classes)
            DispatchQueue.main.async {
                self.cameraButton.isEnabled = true
                self.shareButton.isHidden = false
                SVProgressHUD.dismiss()
            }
            
            if self.classes.contains("hotdog"){
                DispatchQueue.main.async {
                    
                    self.navigationItem.title = "Hotdog"
                    self.navigationController?.navigationBar.barTintColor = UIColor.green
                    self.topImageView.image = UIImage(named: "hotdog")
                }
            }
            else{
                DispatchQueue.main.async {
                    
                    self.navigationItem.title = "Not hotdog"
                    self.navigationController?.navigationBar.barTintColor = UIColor.red
                    self.topImageView.image = UIImage(named: "not-hotdog")
                }
            }
            
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func share(_ sender: UIButton) {
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
            
            let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            vc?.setInitialText(self.navigationItem.title)
            vc?.add(UIImage(named: "hotdogBackground"))
            present(vc!, animated: true, completion: nil)
        }
    }
}

