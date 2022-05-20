//
//  DefaultResponse.swift
//  ServiceIdol
//
//  Created by Prashant Ghimire on 3/27/19.
//  Copyright © 2018 prashantghimire@gmail.com. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
class DefaultResponse: NSObject, NSCoding, Mappable {
  var message: String?
 
  required init?(coder aDecoder: NSCoder) {
  }
  override init() {
    super.init()
  }
  func encode(with aCoder: NSCoder) {
  }
  required init?(map: Map) {
  }
  func mapping(map: Map) {
    message <- map["message"]
   
    
  
  }
  
}
class DefaultModel: DefaultResponse {
  var name: String?
  var id: Int?
  //var allImage: [ImageModel]?
  var imageURL: String?
  

  override func mapping(map: Map) {
    super.mapping(map: map)
    name <- map["name"]
    imageURL <- map["image"]
    //allImage <- map["images"]
    id <- map["id"]
   
   
    if name == nil {
      name <- map["fullName"]
    }
  }
}

//class DefaultRealmModel: Object, StaticMappable {
//  var message: String?
//  var tempToken: String?
//  public class func objectForMapping(map: Map) -> BaseMappable? {
//    return self.init()
//  }
//  public func mapping(map: Map) {
//    message <- map["message"]
//    tempToken <- map["csrfToken"]
//    if let temp = tempToken {
//      UserDefaultsHandler().setToUD(key: UDkey.tempToken.rawValue, value: temp as AnyObject)
//    }
//  }
//}
