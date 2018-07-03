//
//  ShowImagesViewController.swift
//  ImagePickerDemoApp
//
//  Created by Vaibhav Singla on 7/3/18.
//  Copyright © 2018 finoit. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SVProgressHUD

class ShowImagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var imagesURLArray = [URL]()
    @IBOutlet weak var imagesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesTableView.delegate = self
        imagesTableView.dataSource = self
        imagesTableView.estimatedRowHeight = 200
        imagesTableView.tableFooterView = UIView()
        imagesTableView.rowHeight = 200
        
        imagesTableView.register(ImageTableViewCell.cellNib, forCellReuseIdentifier: ImageTableViewCell.cellIdentifier)
        self.getImages()
        print(imagesURLArray)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getImages(){
        let ref = Database.database().reference()
        SVProgressHUD.show()
        ref.child("ImagesURL").observeSingleEvent(of: .value) { (snapshot) in
            
            if let imagesPathDictionary = snapshot.value as? [String: Any?]{
                for imagesDictionary in imagesPathDictionary.enumerated()
                {
                    if let imagePathDictionary = imagesDictionary.element.value as? [String : String]{
                        if let imagePath = imagePathDictionary["imageUrl"]{
                            if let url = URL.init(string: imagePath){
                                self.imagesURLArray.append(url)
                            }
                        }
                    }
                }
            }
            SVProgressHUD.dismiss()
            self.imagesTableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
// Mark: - table view datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesURLArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.cellIdentifier, for: indexPath) as! ImageTableViewCell
        cell.configCell(url: imagesURLArray[indexPath.row])
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
