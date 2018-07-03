//
//  ViewController.swift
//  ImagePickerDemoApp
//
//  Created by Vaibhav Singla on 7/2/18.
//  Copyright © 2018 finoit. All rights reserved.
//

import UIKit
import ImagePicker
import FirebaseStorage
import FirebaseDatabase

class ViewController: UIViewController {
    @IBOutlet weak var selectedImageImageVIew: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showImagesButtonTapped(_ sender: Any) {
        print("Show Images Tapped")
        var config = Configuration()
        config.allowMultiplePhotoSelection = false
        config.allowVideoSelection = false
        config.doneButtonTitle = "Finish"
        config.recordLocation = false
        
        config.noImagesTitle = "There are no images in gallary please click some image to proceed"
        let imagePickerVC = ImagePickerController(configuration: config)
        imagePickerVC.delegate = self
        imagePickerVC.imageLimit = 1
        imagePickerVC.preferredImageSize = CGSize.init(width: 200, height: 200)
        self.present(imagePickerVC, animated: true, completion: nil)
    }
    
    @IBAction func uploadButtonTapped(_ sender: UIButton) {
        let storageRef = Storage.storage().reference().child("\(Date().toMillis()).png")
        
        guard let selectedImage = selectedImageImageVIew.image else{ return }
        if let uploadData = UIImagePNGRepresentation(selectedImage){
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil{
                    print("error \(error!)")
                    return
                }
                print(metadata as Any)
                storageRef.downloadURL(completion: { (url, error) in
                    let ref = Database.database().reference()
                    ref.child("ImagesURL").childByAutoId().setValue(["imageUrl" : url?.absoluteString ?? ""])
                })
            }
        }else{
            print("cannot convert it to data")
        }
    
    }
    
}
extension ViewController: ImagePickerDelegate{
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        print("wrapper tapped")
    }
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.dismiss(animated: true, completion: nil)
        if !images.isEmpty{
            selectedImageImageVIew.image = images.first
        }
    }
}
extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}

