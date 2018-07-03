//
//  Enum.swift
//  HYTORC
//
//  Created by Pratibha Gupta on 29/01/18.
//  Copyright © 2018 Pratibha Gupta. All rights reserved.
//

import Foundation

enum ProductsListSections:Int{
    case images = 0
    case products = 1
    
}
enum ProductDetailSections:Int{
    case images = 0
    case description = 1
    case list = 2
    
}

enum ListDataType{
    case features
    case technicadata
    case videos
    case documentation
    
}

@objc enum AboutDocType:Int{
    case history = 1
    case companyBrochure = 2
    
}
enum ToolType:Int{
    case torqueTool = 1
    case otherTool = 2
    
}


enum CompareFieldType:String{
    case height = "height"
    case width = "width"
    case length = "length"
    case radius = "radius"
    case drive = "drive"
    case weight = "weight"
    case torqueRange = "torque_range"
    case stages = "stages"
    case boltingMethod = "boltingMethod"
    case function = "function"
    case power = "power"
    case reservoir = "reservoir"
    case datarecording = "data_recording"
    case maxOilFlowRate = "max_oil_flow_rate"

}

