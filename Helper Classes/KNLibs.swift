//
//  KNLibs.swift
//  HYTORC
//
//  Created by Pratibha Gupta on 29/01/18.
//  Copyright © 2018 Pratibha Gupta. All rights reserved.
//

import UIKit
import MessageUI
typealias JSONData = [String: AnyObject]
import SystemConfiguration
import CoreLocation
import MapKit

struct KNLibs {
    
    // MARK: - Screen size
    static func screenSize() -> CGSize {
        return UIScreen.main.bounds.size
    }
    
    static func screenWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    static func screenHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    static var isZoomed: Bool {
        return UIScreen.main.scale < UIScreen.main.nativeScale
    }
    
    
    // MARK: - Device information
    static func getUUIDString() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    
    // MARK: - Font families
    static func getFontNames() {
        for family: String in UIFont.familyNames
        {
            debugPrint("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                debugPrint("== \(names)")
            }
        }
    }
    
    
    static func getFontSizeForDevice(fontsize:CGFloat) -> CGFloat{
        var scaledFontSize:CGFloat = 0.0;
        let screenRect = UIScreen.main.bounds;
        //Checking if it is 5,5s,4s
        let height = screenRect.size.height;
        switch (height) {
        case 480,568://Checking if it is 5,5s,4s
            scaledFontSize = fontsize * 0.91;
            break;
        case 667://Checking for 6s
            scaledFontSize = fontsize * 1;
            break;
        case 736://Checking for 7+
            scaledFontSize = fontsize * 1;
            break;
        case 1024,1112:
            scaledFontSize = fontsize * 1.3;
            break;
        default:
            scaledFontSize = fontsize;
            break;
        }
        return scaledFontSize;
    }
    
    // MARK: - LoadingIndicatorView
    static var currentOverlay : UIView?
    
    
    // MARK: - AppleMapsRedirect
    static func openAppleMaps(with latitude: CLLocationDegrees, longitude: CLLocationDegrees, name: String?, phone: String?) {
        //CLLocationCoordinate2D
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        // MKPlacemark
        var placemark: MKPlacemark?
        if #available(iOS 10.0, *) {
            placemark = MKPlacemark(coordinate: coordinate)
        } else {
            // Fallback on earlier versions
            placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        }
        
        // Options
        let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.01, 0.02))
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: region.center),
                       MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: region.span)]
        
        // MKMapItem
        let mapItem = MKMapItem(placemark: placemark!)
        mapItem.name = name ?? ""
        mapItem.phoneNumber = phone ?? ""
        mapItem.openInMaps(launchOptions: options)
    }
    
    
    // MARK: - UIAlertController
    
    // Alert controler with block
    static func showAlertControler(message: String, successAction: @escaping (_ successAction: Bool) -> Void) {
        self.showAlertControler(message: message, viewController: UIApplication.topViewController()!, successAction: { (success) in
            successAction(success)
        })
    }
    
    static func showAlertControlerWithSingleButton(message: String, successAction: @escaping (_ successAction: Bool) -> Void) {
        let alertController = UIAlertController(title: _APP_NAME, message: message, preferredStyle: .alert)
        
        
        let secondAction = UIAlertAction(title: "OK", style: .default) { (alert: UIAlertAction!) -> Void in
            successAction(true)
        }
        
        alertController.addAction(secondAction)
        UIApplication.topViewController()!.present(alertController, animated: true, completion: nil)
    }
    
    static func showAlertControler(message: String, viewController: UIViewController, successAction: @escaping (_ successAction: Bool) -> Void) {
        let alertController = UIAlertController(title: _APP_NAME, message: message, preferredStyle: .alert)
        let firstAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert: UIAlertAction!) -> Void in
            successAction(false)
        }
        
        let secondAction = UIAlertAction(title: "OK", style: .default) { (alert: UIAlertAction!) -> Void in
            successAction(true)
        }
        
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    
    static func showAlertControler(message: String, cancelButton:String, successButton:String, successAction: @escaping (_ successAction: Bool) -> Void) {
        let alertController = UIAlertController(title: _APP_NAME, message: message, preferredStyle: .alert)
        let firstAction = UIAlertAction(title: cancelButton, style: .cancel) { (alert: UIAlertAction!) -> Void in
            successAction(false)
        }
        
        let secondAction = UIAlertAction(title: successButton, style: .default) { (alert: UIAlertAction!) -> Void in
            successAction(true)
        }
        
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        UIApplication.topViewController()!.present(alertController, animated: true, completion: nil)
    }
    // Action sheet with single action
    static func showActionSheet(sender:AnyObject, message: String?, titleAction: String, successAction: @escaping (_ successAction: Bool) -> Void) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        let firstAction = UIAlertAction(title: titleAction, style: .destructive) { (alert: UIAlertAction!) -> Void in
            successAction(true)
        }
        
        let secondAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert: UIAlertAction!) -> Void in
            successAction(false)
        }
        
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = sender as? UIView
            popoverController.sourceRect = CGRect(x: sender.bounds.midX, y: sender.bounds.midY, width: 0, height: 0)
        }
        UIApplication.topViewController()!.present(alertController, animated: true, completion: nil)
    }
    
    // Action sheet with multiple action
    static func showActionSheet(sender:AnyObject, message: String?, titleAction: [String], successAction: @escaping (_ successAction: Int?) -> Void) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        
        for (index, value) in titleAction.enumerated() {
            let action = UIAlertAction(title: value, style: .default) { (alert: UIAlertAction!) -> Void in
                successAction(index)
            }
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert: UIAlertAction!) -> Void in
            successAction(nil)
        }
        
        alertController.addAction(cancelAction)
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = sender as? UIView
            popoverController.sourceRect = CGRect(x: sender.bounds.midX, y: sender.bounds.midY, width: 0, height: 0)
        }
        UIApplication.topViewController()!.present(alertController, animated: true, completion: nil)
    }

    
    // MARK: - UIImagePicker
    static func showImagePickerOnViewController(sender:AnyObject, viewController: UIViewController, delegate: Any) {
        
        let delegate = delegate as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        let alertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // camera action
        let camera: UIAlertAction = UIAlertAction(title: "Take Photo", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let picker:UIImagePickerController = UIImagePickerController()
                picker.allowsEditing = false
                picker.delegate = delegate
                picker.sourceType = .camera
                viewController.present(picker, animated: true) {
                    UIApplication.shared.statusBarStyle = .default
                    picker.delegate = delegate
                    
                }
                picker.delegate = delegate
                
            }
        }
        // library action
        let library: UIAlertAction = UIAlertAction(title: "Choose From Library", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let picker:UIImagePickerController = UIImagePickerController()
                picker.allowsEditing = false
                picker.delegate = delegate
                picker.sourceType = .photoLibrary
                viewController.present(picker, animated: true) {
                    UIApplication.shared.statusBarStyle = .default
                    picker.delegate = delegate
                    
                }
                picker.delegate = delegate
                
            }
        }
        // cancel action
        let cancel:UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(camera)
        alertController.addAction(library)
        alertController.addAction(cancel)
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = sender as? UIView
            popoverController.sourceRect = CGRect(x: sender.bounds.midX, y: sender.bounds.midY, width: 0, height: 0)
        }
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    
    //MARK: Email
    static func sendEmail(message:String, viewController: UIViewController, delegate: Any,recipient: String) {
        if MFMailComposeViewController.canSendMail() {
            // let delegate = delegate as! MFMailComposeViewControllerDelegate
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = delegate as? MFMailComposeViewControllerDelegate
            mail.setToRecipients([recipient])
            viewController.present(mail, animated: true)
            
        } else {
            // show failure alert
        }
    }
    
    
    // MARK: - UserDefaults
    static let userDefaults: UserDefaults = UserDefaults.standard
    static var userDefaultsDictionary: [String: Any]?
    
    // SET
    static func userDefaultsSet(value: Any?, key: String) {
        
        if userDefaultsDictionary == nil {
            userDefaultsDictionary = userDefaults.object(forKey: "userDefaultsDictionary") as? [String : Any]
            if userDefaultsDictionary == nil {
                userDefaultsDictionary = [:]
            }
        }
        
        if value != nil {
            userDefaultsDictionary!.updateValue(value!, forKey: key)
        } else {
            userDefaultsDictionary!.removeValue(forKey: key)
        }
        
        userDefaults.set(userDefaultsDictionary, forKey: "userDefaultsDictionary")
        userDefaults.synchronize()
        
        // print("\n^UserDefaults: saved with key \(key)")
    }
    
    // GET
    static func userDefaultsGet(key: String) -> Any? {
        if userDefaultsDictionary == nil {
            userDefaultsDictionary = userDefaults.object(forKey: "userDefaultsDictionary") as? [String : Any]
            if userDefaultsDictionary == nil {
                userDefaultsDictionary = [:]
            }
        }
        if (userDefaultsDictionary![key] != nil) {
            print("\n^UserDefaults: loaded with key \(key)")
            return userDefaultsDictionary![key]
        }
        return nil
    }
    
    
    static func getSaveFileUrl(fileName: String) -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let nameUrl = URL(string: fileName)
        let fileURL = documentsURL.appendingPathComponent((nameUrl?.lastPathComponent)!)
        NSLog(fileURL.absoluteString)
        return fileURL;
    }
    
    // MARK: - Internet availability check
    
    static func isInternetAvailable(showAlert: Bool = true) -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var isInternet = false
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return isInternet
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        isInternet = (isReachable && !needsConnection)
        if !isInternet && showAlert{
            
            KNLibs.showAlertControler(message: kAlertMessage_INTERNET_CONNECTION_NOT_AVAILABLE, successAction: { (bool) in
                // work if success
            })
            
        }
        
        return isInternet
    }
    
    // MARK: - Youtube
    static func extractYoutubeVideoId(from url: String) -> String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        guard let range = url.range(of: pattern, options: .regularExpression) else { return nil }
        return String(url[range])
    }
    static func extractYoutubeVideoIdArray(urlArray: [String])-> [String]{
        var videoIDArray = [String]()
        for url in urlArray{
            if let videoId = KNLibs.extractYoutubeVideoId(from: url){
                videoIDArray.append(videoId)
            }
        }
        return videoIDArray
    }
    // MARK: - PList
    
    static func writeDataToPlist(name: String, dict: [String: Any]){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0]
        let path = documentDirectory.appending(name)
        (dict as NSDictionary).write(toFile: path, atomically: true)
    }
    
    static func readDataFromPlist(name: String) -> [String : Any]{
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0]
        let path = documentDirectory.appending(name)
        let dict = NSDictionary(contentsOfFile: path)
        return ((dict ?? [:]) as! Dictionary)
    }
    
    // MARK: - Get Empty Objects For Array Dictionary etc
    static func getnullfiedDictionary(dict: Any?)-> Dictionary<String, Any>{
        
        print(dict)
        guard let tempDict = dict else {
            return [:]
        }
        
        if let newDict = tempDict as? Dictionary<String, Any> , !newDict.isEmpty{
            return newDict
        }
        return [:]
    }
    
    static func getnullfiedStringArray(arr: Any?) -> [String]{
        
        guard let tempArray = arr else{
            return []
        }
        
        if let newArray = tempArray as? Array<String> , !(newArray.isEmpty){
            return newArray
        }
        return []
    }
    static func getnullfiedAnyArray(arr: Any?) -> [Any]{
        
        guard let tempArray = arr else{
            return []
        }
        
        if let newArray = tempArray as? Array<Any> , !(newArray.isEmpty){
            return newArray
        }
        return []
    }
    static func getnullifiedStringDictionaryArray(array: Any?)-> [[String:String]]{
        
        guard let tempArray = array else {
            return []
        }
        if let newArray = tempArray as? Array<[String:String]>, !newArray.isEmpty{
            return newArray
        }
        return []
    }
    // MARK: - formatted number
    static func getFormattedMobileNumber(contactNumber: String) -> String{
        var formattedNumber = ""
        for char in contactNumber.unicodeScalars{
            if ((char.value >= 48 && char.value <= 57) || (char == "+")){
                formattedNumber.append(String(char))
            }
            // for multiple numbers
            if (char == ","){
                break
            }
        }
        return formattedNumber
    }
}


