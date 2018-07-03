//
//  SecondeViewController.swift
//  ImagePickerDemoApp
//
//  Created by Vaibhav Singla on 7/2/18.
//  Copyright © 2018 finoit. All rights reserved.
//

import UIKit
import Gallery

class SecondeViewController: UIViewController {

    @IBOutlet weak var selectedImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func openGallaryTapped(_ sender: UIButton) {
        
        let gallaryController = GalleryController()
        gallaryController.delegate = self
        self.present(gallaryController, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SecondeViewController: GalleryControllerDelegate{
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        print("Video selected")
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        print("Images Selected")
        Image.resolve(images: images) { (selectedImageArray) in
            
            if let selectedImage = selectedImageArray.first{
                
                self.selectedImageView.image = selectedImage
            }
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        print("lightbox Images Selected")
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        controller.dismiss(animated: true, completion: nil)
    }
}












