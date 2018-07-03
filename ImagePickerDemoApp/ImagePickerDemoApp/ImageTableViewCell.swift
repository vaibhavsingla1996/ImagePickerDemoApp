//
//  ImageTableViewCell.swift
//  ImagePickerDemoApp
//
//  Created by Vaibhav Singla on 7/3/18.
//  Copyright © 2018 finoit. All rights reserved.
//

import UIKit
import SDWebImage


class ImageTableViewCell: UITableViewCell {

    class var cellNib: UINib{
        return UINib.init(nibName: String.init(describing: ImageTableViewCell.self), bundle: nil)
    }
    class var cellIdentifier: String{
        return String.init(describing: ImageTableViewCell.self)
    }
    @IBOutlet weak var productImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(url: URL){
        productImageView.sd_setImage(with: url) { (image, error, cache, url) in
            if error != nil{
                print("error in downloading Image - \(error?.localizedDescription)")
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
