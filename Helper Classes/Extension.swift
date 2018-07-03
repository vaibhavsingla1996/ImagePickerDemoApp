//
//  Extension.swift
//  HYTORC
//
//  Created by Pratibha Gupta on 29/01/18.
//  Copyright © 2018 Pratibha Gupta. All rights reserved.
//

import UIKit


let kValueKey = "Value"

// MARK: - UIViewController
extension UIViewController {
    func startLoading() {
        self.pleaseWait(isFullScreen: false)
        self.view.isUserInteractionEnabled = false
    }
    func startLoadingFullScreen() {
        self.pleaseWait(isFullScreen: true)
        self.view.isUserInteractionEnabled = false
    }
    
    func stopLoading() {
        self.clearAllNotice()
        self.view.isUserInteractionEnabled = true
    }
    
    func startLoadingWithoutUIDisabled() {
        self.pleaseWait(isFullScreen: false)
    }
    
    
    
}


// MARK: - UIView
extension UIView {
    func startLoading() {
        self.pleaseWait(isFullScreen: false)
        //self.isUserInteractionEnabled = false
    }
    
    func stopLoading() {
        self.clearAllNotice()
        // self.isUserInteractionEnabled = true
    }
    
    func round() {
        self.layer.cornerRadius = self.bounds.size.height / 2
        self.clipsToBounds = true
    }
    
    func corner() {
        self.corner(value: 5)
    }
    
    func corner(value: CGFloat) {
        self.layer.cornerRadius = value
        self.clipsToBounds = true
    }
    
    func shadow() {
        let shadowPath = UIBezierPath(rect: self.bounds)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowRadius = 5
        self.layer.masksToBounds = false
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    func shadowAll() {
        let shadowPath = UIBezierPath(rect: self.bounds)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5
        self.layer.masksToBounds = false
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    func shadowInnerTopBottom() {
        self.shadowInner(isTop: true)
        self.shadowInner(isTop: false)
    }
    
    func shadowInner(isTop: Bool) {
        let size = self.frame.size
        self.clipsToBounds = true
        
        let newLayer: CALayer = CALayer()
        newLayer.backgroundColor = UIColor.black.cgColor
        let yPosition = isTop ? -size.height / 2 : size.height+size.height / 2
        newLayer.position = CGPoint(x: size.width / 2, y: yPosition)
        newLayer.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        newLayer.shadowColor = UIColor.black.cgColor
        newLayer.shadowOffset = CGSize(width: 0, height: 0)
        newLayer.shadowOpacity = 0.1
        newLayer.shadowRadius = 5.0
        
        self.layer.addSublayer(newLayer)
    }
    
    func border() {
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
    }
    
    func border(color: UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 0.5
    }
    
    func border(width: CGFloat, color: UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    
    
}


// MARK: - UILabel
extension UILabel {
    
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // Line spacing attribute
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
}



// MARK: - UIImageView
var imagesCache = NSCache<AnyObject, UIImage>()

extension UIImageView {
    
    func drawHighlight(withRects rects: [CGRect]) {
        
        guard let image = self.image else { return }
        
        let imageSize = image.size
        let scale: CGFloat = 0
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, scale)
        
        self.image?.draw(at: CGPoint())
        
        let color = UIColor.init(hexString: _COLOR_MAIN).withAlphaComponent(0.2)
        color.setFill()
        
        for rect in rects {
            UIRectFillUsingBlendMode(rect, .normal)
        }
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        DispatchQueue.main.async {
            self.image = newImage
        }
    }
}

extension NSAttributedString {
    func rangeOf(string: String) -> NSRange? {
        let string1:NSString = self.string as NSString
        return  string1.range(of: string)
    }
    func rangeOfLastOccurance(string: String) -> NSRange? {
        let string1:NSString = self.string as NSString
        return  string1.range(of: string, options: .backwards)
    }
}
// MARK: - UIImage
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}
extension NSLocale {
    class func locales1(countryName1 : String) -> String {
        let locales : String = ""
        for localeCode in NSLocale.isoCountryCodes {
            let countryName = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: localeCode)
            if countryName1.lowercased() == countryName?.lowercased() {
                return localeCode
            }
        }
        return locales
    }
}
extension UIImage {
    func encodeToBase64String() -> String {
        let data = UIImageJPEGRepresentation(self, 0.01)
        let base64String = data?.base64EncodedString(options: .endLineWithLineFeed)
        return base64String!
    }
    
    func resizeImage(newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    
}


// MARK: - UIColor
extension UIColor {
    convenience init(hexString:String) {
        let scanner  = Scanner(string: hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String.init(format: "#%06x", rgb)
    }
    
    static func skyBlue()-> UIColor{
        return UIColor.init(red: 75/255.0, green: 143/255.0, blue: 226/255.0, alpha: 1)
    }
    static func silver()-> UIColor{
        return UIColor.init(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
    }
}


// MARK: - UIApplication
extension UIApplication {
    class func topViewController(base: UIViewController? = kSharedAppDelegate.window?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}


// MARK: - String
extension String {
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func removeHTMLTags() -> String {
        let newString = self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        return newString.stringByTrimmingWhiteSpace()
    }
    
    func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.height
    }
    
    func widthWithConstrainedHeight(height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.width
    }
    
    
    func isValidUsername() -> Bool
    {
        do
        {
            let regex = try NSRegularExpression(pattern: "^[0-9a-zA-Z\\_\\.]{6,18}$", options: .caseInsensitive)
            if regex.matches(in: self, options: [], range: NSMakeRange(0, self.count)).count > 0 {return true}
        }
        catch {}
        return false
    }
    // To Check Whether Email is valid
    func isEmail() -> Bool
    {
        if self.isStringEmpty()
        {
            return false
        }
        let emailRegex = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}" as String
        let emailText = NSPredicate(format: "SELF MATCHES %@",emailRegex)
        let isValid  = emailText.evaluate(with: self) as Bool
        return isValid
    }
    
    // To Check Whether Email is valid
    func isValidString() -> Bool
    {
        if self == "<null>" || self == "(null)"
        {
            return false
        }
        return true
    }
    
    // To Check Whether Phone Number is valid
    func isPhoneNumber() -> Bool
    {
        if self.isStringEmpty()
        {
            return false
        }
        let phoneRegex = "^\\d{10}$"
        let phoneText = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let isValid = phoneText.evaluate(with: self) as Bool
        return isValid
    }
    
    // To Check Whether URL is valid
    func isURL() -> Bool
    {
        let urlRegex = "(?i)https?://(?:www\\.)?\\S+(?:/|\\b)"
        //"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+" as String
        let urlText = NSPredicate(format: "SELF MATCHES %@", urlRegex)
        let isValid = urlText.evaluate(with: self) as Bool
        
        return isValid
    }
    
    // To Check Whether Image URL is valid
    func isImageURL() -> Bool
    {
        if self.isURL()
        {
            if self.range(of: ".png") != nil || self.range(of: ".jpg") != nil || self.range(of: ".jpeg") != nil
            {
                return true
            }
            else
            {
                return false
            }
        }
        else
        {
            return false
        }
    }
    
    
    static func checkForValidNumericString(_ message: AnyObject?) -> Bool
    {
        guard let strMessage = message as? String else
        {
            return true
        }
        
        if strMessage == "" || strMessage == "0"
        {
            return true
        }
        
        return false
    }
    
    
    // To Check Whether String is empty
    func isStringEmpty() -> Bool
    {
        return self.stringByTrimmingWhiteSpace().count == 0 ? true : false
    }
    
    mutating func removeSubString(subString: String) -> String
    {
        if self.contains(subString)
        {
            guard let stringRange = self.range(of: subString) else { return self }
            return self.replacingCharacters(in: stringRange, with: "")
        }
        return self
    }
    
    
    // Get string by removing White Space & New Line
    func stringByTrimmingWhiteSpaceAndNewLine() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    // Get string by removing White Space
    func stringByTrimmingWhiteSpace() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    func getSubStringFrom(begin: NSInteger, to end: NSInteger) -> String
    {
        //var strRange = begin..<end
        //let str = self.substringWithRange(strRange)
        return ""
    }
    static func randomString(_ length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedStringKey.font: font], context: nil)
        return boundingBox.height
    }
    
    
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    func htmlAttributedString() -> NSAttributedString? {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil) else { return nil }
        html.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, html.length))
        return html
    }
    
    static func nulifiedEmptyString(_ string: Any?) -> String {
        
        guard let tempString = string else {
            return ""
        }
        
        if let newString = tempString as? String, newString != "<null>" {
            return newString
        } else {
            let newString = String(describing: tempString)
            guard newString != "<null>" else {
                return ""
            }
            return newString
        }
    }
    
    func toIntValue()-> Int{
    
        if let intVal = Int(self){
            return intVal
        }
        return 0
    }
    func floatValue() -> Float {
        var str = self
        str = str.stringByTrimmingWhiteSpace()
        if let floatval = Float(str.removeSubString(subString: ",")) {
            return floatval
        }
        return 0
    }
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {

            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}



// MARK: - UIDevice
extension UIDevice {
    
    enum DeviceType {
        case iPhone35
        case iPhone40
        case iPhone47
        case iPhone55
        case iPad
        case TV
        
        var isPhone: Bool {
            return [ .iPhone35, .iPhone40, .iPhone47, .iPhone55 ].contains(self)
        }
    }
    
    var deviceType: DeviceType? {
        switch UIDevice.current.userInterfaceIdiom {
        case .tv:
            return .TV
            
        case .pad:
            return .iPad
            
        case .phone:
            let screenSize = UIScreen.main.bounds.size
            let height = max(screenSize.width, screenSize.height)
            
            switch height {
            case 480:
                return .iPhone35
            case 568:
                return .iPhone40
            case 667:
                return .iPhone47
            case 736:
                return .iPhone55
            default:
                return nil
            }
            
        case .unspecified:
            return nil
        default :
            return nil
        }
    }
    
    
    static var isSimulator: Bool {
        return ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil
    }
    
}

extension NSLayoutConstraint {
    /**
     Change multiplier constraint
     
     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
     */
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem!,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}

//MARK:- UITableView
extension UITableView {
    
    func setNoDataView(image: UIImage? = nil, message: String? = nil ) {
        self.removeNoDataView()
        self.separatorStyle  = .none
        
        let noDataLabel: UILabel = UILabel()
        if let msg = message {
            noDataLabel.text = msg
        }
        else {
            noDataLabel.text = "No Data Available"
        }
        
        noDataLabel.textColor     = UIColor.black
        noDataLabel.textAlignment = .center
        
        let detailImgV = UIImageView()
        if let img = image {
            detailImgV.image = img
        }
        else {
            detailImgV.image = UIImage(named: "ic-data")
        }
        
        detailImgV.contentMode = .scaleAspectFit
        detailImgV.widthAnchor.constraint(equalToConstant: 120).isActive = true
        detailImgV.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        let verticalSV = UIStackView()
        verticalSV.axis = .vertical
        verticalSV.spacing = 0
        verticalSV.alignment = .center
        verticalSV.distribution = .fill
        verticalSV.translatesAutoresizingMaskIntoConstraints = false
        verticalSV.addArrangedSubview(detailImgV)
        verticalSV.addArrangedSubview(noDataLabel)
        
        self.addSubview(verticalSV)
        verticalSV.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        verticalSV.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        verticalSV.widthAnchor.constraint(equalToConstant: KNLibs.screenSize().width).isActive = true
        verticalSV.heightAnchor.constraint(equalToConstant: 160).isActive = true
    }
    
    func removeNoDataView(_ seperator: UITableViewCellSeparatorStyle = .singleLine) {
        for view in self.subviews {
            if view is UIStackView {
                view.removeFromSuperview()
            }
        }
    }
    
    func scrollToLastRow(animated: Bool, atPosition scrollPosition: UITableViewScrollPosition? = .bottom) {
        if self.numberOfRows(inSection: 0) > 0 {
            self.scrollToRow(at: IndexPath(row: self.numberOfRows(inSection: 0) - 1, section: 0), at: scrollPosition ?? .bottom, animated: animated)
        }
    }
}

extension UICollectionView {
    
    func setNoDataView(textColor: UIColor = UIColor.white, message: String = "No data available") {
        let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: KNLibs.screenSize().width, height: self.bounds.size.height))
        noDataLabel.text          = message
        noDataLabel.textColor     = textColor
        noDataLabel.textAlignment = .center
        noDataLabel.tag = 999
        self.backgroundView  = noDataLabel
    }
    
    func setNoDataViewWithImage(image: UIImage? = nil, message: String? = nil ) {
        self.removeNoDataView()
        
        let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        if let msg = message {
            noDataLabel.text = msg
        }
        else {
            noDataLabel.text = "No Data Available"
        }
        
        noDataLabel.textColor     = UIColor.black
        noDataLabel.textAlignment = .center
        
        let detailImgV = UIImageView()
        if let img = image {
            detailImgV.image = img
        }
        else {
            detailImgV.image = UIImage(named: "ic-data")
        }
        
        detailImgV.contentMode = .scaleToFill
        detailImgV.widthAnchor.constraint(equalToConstant: 120).isActive = true
        detailImgV.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        let verticalSV = UIStackView()
        verticalSV.axis = .vertical
        verticalSV.spacing = 0
        verticalSV.alignment = .center
        verticalSV.distribution = .equalSpacing
        verticalSV.translatesAutoresizingMaskIntoConstraints = false
        verticalSV.addArrangedSubview(detailImgV)
        verticalSV.addArrangedSubview(noDataLabel)
        
        self.addSubview(verticalSV)
        //        verticalSV.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        verticalSV.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: -20.0).isActive = true
        verticalSV.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        verticalSV.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        verticalSV.heightAnchor.constraint(equalToConstant: 160).isActive = true
    }
    
    func removeNoDataView() {
        
        if self.backgroundView?.viewWithTag(999) != nil {
            self.backgroundView = nil
        }
    }
    
    func removeNoDataViewStackView() {
        for view in self.subviews {
            if view is UIStackView {
                view.removeFromSuperview()
            }
        }
    }
}

class DynamicFontLabel : UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        self.setDynamicFontSize()
    }
    
    func setDynamicFontSize()
    {
        self.font = self.getDynamicFontWithFont(font: self.font)
    }
    func getDynamicFontWithFont(font:UIFont)->UIFont
    {
        return UIFont(name: font.fontName, size: KNLibs.getFontSizeForDevice(fontsize: font.pointSize))!
    }
}
class DynamicFontButton : UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        self.setDynamicFontSize()
    }
    func setDynamicFontSize()
    {
        self.titleLabel?.font = self.getDynamicFontWithFont(font: (self.titleLabel?.font)!)
        //self.textl.font = self.getDynamicFontWithFont(font: self.font)
    }
    func getDynamicFontWithFont(font:UIFont)->UIFont
    {
        return UIFont(name: font.fontName, size: KNLibs.getFontSizeForDevice(fontsize: font.pointSize))!
    }
}
class DynamicFontTextField : UITextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        self.setDynamicFontSize()
    }
    
    func setDynamicFontSize()
    {
        self.font = self.getDynamicFontWithFont(font: self.font!)
    }
    func getDynamicFontWithFont(font:UIFont)->UIFont
    {
        return UIFont(name: font.fontName, size: KNLibs.getFontSizeForDevice(fontsize: font.pointSize))!
    }
}

extension UILabel {
    func setHTMLString(text: String, size: CGFloat) {
        self.setHTMLString(text: text, color: self.textColor, fontSize: size)
    }
    
    func setHTMLString(text: String, color: UIColor, fontSize: CGFloat) {
        // DispatchQueue.main.async {
        let modifiedFont = String(format: "<body style=\"font-size:\(fontSize); font-family:\(kAppFont_Regular); color:\(color.toHexString())\">\(text)</body>").trim()
        
        self.attributedText = modifiedFont.htmlAttributedString()
        
    }
}
extension NSAttributedString{
    func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        return boundingBox.height
    }
}

