//
//  ResponseModel.swift
//  MVVVMApiCall
//
//  Created by Midas on 18/05/2022.
//

import Foundation
import ObjectMapper
import Alamofire
//typealias Employees = [Employee]
class JokesResponseModel: DefaultResponse {
  var notificatoin: Employees?
  override func mapping(map: Map) {
    super.mapping(map: map)
    notificatoin <- map["content"]
  }
  class func requestForJokes(showHud: Bool = true, completionHandel: @escaping (Employees?) -> Void) {
      APIManager(urlString: AppURL.getJokes, method: .get, encoding: JSONEncoding.default).handleArrayResponse(showProgressHud: showHud, completionHandler: { (response: Employees) in
          print(response)
      completionHandel(response)
    }, failureBlock: {
      completionHandel(nil)
    })
  }
}
//class Employee: Mappable {
//    required init?(map: Map) {
//
//    }
//
//  internal let kBaseClassTitleKey: String = "id"
//  internal let kBaseClassDateTimeKey: String = "employee_name"
//  internal let kBaseClassInternalIdentifierKey: String = "employee_salary"
//  internal let kBaseClassMessageKey: String = "employee_age"
//
//
//  // MARK: Properties
//  public var id: String?
//  public var employeeName: String?
//  public var employeeSalary: Int?
//  public var employeeAge: String?
//
//
//  func mapping(map: Map) {
//    id <- map[kBaseClassTitleKey]
//      employeeName <- map[kBaseClassDateTimeKey]
//      employeeSalary <- map[kBaseClassInternalIdentifierKey]
//      employeeAge <- map[kBaseClassMessageKey]
//
//  }
//}
