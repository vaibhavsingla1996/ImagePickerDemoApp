//
//  Constants.swift
//  HYTORC
//
//  Created by Pratibha Gupta on 29/01/18.
//  Copyright © 2018 Pratibha Gupta. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Api urls
let _SERVICE_URL = "https://portal.hytorc.com/"   // staging
let kAPIURL_Contact = "app/feeds/contacts/"
//let kAPIURL_HomeAbout = "app/feeds/home-about/"
let kAPIURL_HomeAbout = "app/feeds/home-about/home_about.json"
let kAPIURL_Products = "app/feeds/products/products.json"

let kBaseUrl_Documents = "https://hytorc.com/portal/app/docs/"

// MARK: App Font

let kAppFont_Regular = "SFUIText-Regular"
let kAppFont_Light = "SFUIText-Light"
let kAppFont_Medium = "SFUIText-Medium"
let kAppFont_Bold = "SFUIText-Bold"
let kAppFont_Heavy = "SFUIText-Heavy"



// MARK: - Color
let _COLOR_MAIN = "CA011D"
let _COLOR_GOOGLE = "DD4B39"
let _COLOR_FACEBOOK = "3B5999"
let _COLOR_BACKGROUND = "EEF2F2"
let _COLOR_TEXT_GRAY = "7B7F85"
let _COLOR_TEXT_GRAY_DARK = "4E4D4D"


// MARK: - Date format
let _DATE_FORMAT_MMM = "d MMM"

let _DATE_FORMAT_D_MMM_YYYY = "d MMM, yyyy"
let _DATE_FORMAT_12h_D_MMM_YYYY = "h:mm a - d/MM/yyyy"
let _TIME_FORMAT_12h = "h:mm a"
let _TIME_FORMAT_24h = "HH:mm"

let _DATE_FORMAT_MMM_D_YYYY_12h = "MMM, d yyyy h:mm a"
let _DATE_FORMAT_D_MMM_YYYY_12h = "MM/dd/yyyy h:mm a"
let _DATE_FORMAT_YYYY_MM_dd_24h = "yyyy-MM-dd HH:mm:ss"



// MARK: - Notification.Name
extension Notification.Name {
    static let loadCheckoutButton = Notification.Name("loadCheckoutButton")

}


// MARK: - Messages

let _APP_NAME = "HYTORC"
let kAlertMessage_INTERNET_CONNECTION_NOT_AVAILABLE = "Internet connection not available.\nPlease check it that you are connected to internet and try again."
let kAlertMessage_LocationEnable = "Your location services are not enabled. Please go to settings to allow access."
let kAlertMessage_PhoneNumberNotAvailable = "Phone Number is not available"
let kAlertMessage_PhoneNumberIsNotCorrect = "Phone number is not valid"
let kAlertMessage_EmailIdNotAvailable = "Email Id is not available"
let kAlertMessage_INTERNET_CONNECTION_NOT_AVAILABLE_For_Search = "No Internet Connection. Search not available."
let kAlertMessage_Video_Not_Found = "Error in playing this video please try again later"

// MARK: - Appdelegate Object
let kSharedAppDelegate        = UIApplication.shared.delegate as! AppDelegate


//MARK : Checkout error code
let kAPIErrorCode_ItemNotAvailable = "ITEM_NOT_AVAILABLE"
let kAPIErrorCode_PriceChanged = "PRICE_CHANGE"
let kAPIErrorCode_OptionNotAvailable = "OPTION_NOT_AVAILABLE"


//MARK: API KEYS

// NOTE: Some keys are same for multiple api's. so we will use old keys rather than making new keys

// contacts API keys
let kAPIKey_Id = "id"
let kAPIKey_Logo = "logo"
let kAPIKey_Name = "name"
let kAPIKey_LastName = "last_name"
let kAPIKey_UserName = "username"

let kAPIKey_LocationName = "locationName"
let kAPIKey_ContactName = "contactName"
let kAPIKey_AreaServed = "areaServed"
let kAPIKey_City = "city"
let kAPIKey_StateID = "stateID"
let kAPIKey_PostalCode = "postalCode"
let kAPIKey_CountryID = "countryID"
let kAPIKey_Phone = "phone"
let kAPIKey_Mobile = "mobile"
let kAPIKey_Email = "__email"
let kAPIKey_Latitude = "latitude"
let kAPIKey_Longitude = "longitude"
let kAPIKey_StatusID = "statusID"

// home and splash keys

let kAPIKey_PageTitle = "pageTitle"
let kAPIKey_Page = "__page"
let kAPIKey_BackgroundImage = "backgroundImage"
let kAPIKey_DescriptionText = "descText"
let kAPIKey_Document = "document"
//let kAPIKey_Video1 = "video_1"
//let kAPIKey_Video2 = "video_2"
//let kAPIKey_Video3 = "video_3"
//let kAPIKey_Video4 = "video_4"
//let kAPIKey_Videos = "videos"
//let kAPIKey_DocFile1 = "docFile_1"
//let kAPIKey_DocFile2 = "docFile_2"
//let kAPIKey_Doc1 = "doc_1"
//let kAPIKey_Doc2 = "doc_2"
//let kAPIKey_HeaderImage1 = "headerImage_1"
//let kAPIKey_HeaderImage2 = "headerImage_2"
//let kAPIKey_HeaderImage3 = "headerImage_3"
//let kAPIKey_HeaderImages = "headerImages"

// Products API Keys
let kAPIKey_Products = "products"
let kAPIKey_Data = "data"
let kAPIKey_Title = "title"
let kAPIKey_Description = "description"
let kAPIKey_Image = "image"
let kAPIKey_ProductList = "product_list"
let kAPIKey_ToolCategoryName = "tool_category_name"
let kAPIKey_Tools = "tools"
let kAPIKey_ThumbImage = "thumb_image"
let kAPIKey_ManualPDF = "manual"
let kAPIKey_CutSheetPDF = "cut_sheet"
let kAPIKey_Features = "features"
let kAPIKey_Feature = "feature"
let kAPIKey_HeaderImage = "header_Image"
let kAPIKey_TechnicalData = "technical_data"
let kAPIKey_Video = "video"
let kAPIKey_TorqueCharts = "torque_charts"
let kAPIKey_ToolName = "tool_name"
let kAPIKey_TechnicalImage = "technical_image"
let kAPIKey_Radius = "radius"
let kAPIKey_Drive = "drive"
let kAPIKey_TorqueRange = "torque_range"
let kAPIKey_Unit = "unit"
let kAPIKey_Value = "value"

let kAPIKey_PumpName = "pumpName"
let kAPIKey_BoltingMethod = "boltingMethod"
let kAPIKey_Height = "height"
let kAPIKey_Width = "width"
let kAPIKey_Weight = "weight"
let kAPIKey_Length = "length"
let kAPIKey_Power = "power"
let kAPIKey_Reservoir = "reservoir"
let kAPIKey_Max_Oil_Flow_Rate = "max_oil_flow_rate"
let kAPIKey_Power_Source = "power_source"
let kAPIKey_Data_Recording = "data_recording"


let kAPIKey_Function = "function"
let kAPIKey_Stages = "stages"
let kAPIKey_URL = "url"
let kAPIKey_VideoId = "videoID"

// PList Names
let kProductsPlistName = "/products.plist"
let kFavoritesPlistName = "/favorites.plist"



//MARK: UserDefaultKeys
let kUserDefault_FavouriteContact = "favouriteContact"
let kUserDefault_DefaultContact = "defaultContact"
let kUserDefault_Home = "home"
let kUserDefault_About = "about"
let kUserDefault_ProductMainScreenImages = "productMainScreenHeaderImages"

//MARK: PlaceHolder Image name
let kPlaceHolderImage_Name = "placeholderimage"


//MARK: Other Constants

let kNotAvailable = "N/A"

//MARK: Data empty constants
let kTorqueToolDataEmpty_String = "Data Not Available"
let kPumpsDataEmpty_String = "Data Not Available"
let kFavoriteDataEmpty_String = "Data not available"




















