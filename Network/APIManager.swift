//
//  APIManager.swift
//  ServiceIdol
//
//  Created by Prashant Ghimire on 3/27/19.
//  Copyright © 2018 prashantghimire@gmail.com. All rights reserved.
//
import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import SVProgressHUD

public class APIManager {
  var request: DataRequest!
  public init (urlString: String, parameters: [String: Any]? = nil, headers: [String: String]? = nil, method: Alamofire.HTTPMethod = .post, encoding: ParameterEncoding = URLEncoding.default) {
    var headers = headers, parameters = parameters
   
   
      headers = ["Content-Type": "application/json"]
    
   
  
  debugPrint(headers, parameters, urlString, method)
    self.request = Alamofire.SessionManager.default.request(urlString, method: method, parameters: parameters ?? nil, encoding: encoding, headers: headers ?? nil)
  }
  func handleResponse<T: DefaultResponse>(showProgressHud: Bool = true, showBanner: Bool = false, completionHandler: @escaping (T) -> Void, failureBlock: @escaping (() -> Void)) {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    guard NetworkReachabilityManager()!.isReachable else {
      failureBlock()
      let alertController = UIAlertController (title: "No Internet Connection", message: "Please enable data / wifi from settting", preferredStyle: .alert)
      let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alertController.addAction(cancelAction)
      appDelegate?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
      failureBlock()
      return
    }
    if showProgressHud && SVProgressHUD.isVisible() == false {
      ProgressHud.showProgressHUD()
    }
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 900 // seconds
    configuration.timeoutIntervalForResource = 900
    _ = Alamofire.SessionManager(configuration: configuration)
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    self.request.responseObject {(response: DataResponse<T>) in
      ProgressHud.hideProgressHUD()
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      switch response.result {
      case .success(let dataX):
        if showBanner {
//          appDelegate?.window?.rootViewController?.showBanner(title: dataX.message ?? "", isError: response.response?.statusCode == 200 ? false:true)
        }
        if response.response?.statusCode == 200 || response.response?.statusCode == 201 || response.response?.statusCode == 202 {
          completionHandler(dataX)
        } else {
        appDelegate?.window?.rootViewController?.showNormalAlert(for: dataX.message)
          failureBlock()
        }
      case .failure(let error):
        appDelegate?.window?.rootViewController?.showNormalAlert(for: "Api Failur status code \(response.response?.statusCode.description ?? "No Status Code") \(response.error.debugDescription)")
        print(error)
        failureBlock()
      }
    }
    //delete
    self.request.responseJSON {(response) in
      print(response.result.value ?? "No Value")
      print(response.result )
      print(response.error ?? "")
      print(response.response ?? "")
      print(response.request ?? "No request")
      switch response.result {
      case .failure(let error):
        print(error)
      case .success(let val):
        print(val)
      }
    }
  }
  func handleArrayResponse<T: DefaultResponse>(showProgressHud: Bool = true, completionHandler: @escaping ([T]) -> Void, failureBlock: @escaping (() -> Void)) {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    guard NetworkReachabilityManager()!.isReachable else {
      failureBlock()
      let alertController = UIAlertController (title: "No Internet Connection", message: "Please enable data / wifi from settting", preferredStyle: .alert)
      let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alertController.addAction(cancelAction)
      appDelegate?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
      failureBlock()
      return
    }
    if showProgressHud && SVProgressHUD.isVisible() == false {
      ProgressHud.showProgressHUD()
    }
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 900 // seconds
    configuration.timeoutIntervalForResource = 900
    _ = Alamofire.SessionManager(configuration: configuration)
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    self.request.responseArray {(response: DataResponse<[T]>) in
      if showProgressHud == true {
        ProgressHud.hideProgressHUD()
      }
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      switch response.result {
      case .success(let dataX):
        guard let statusCode = response.response?.statusCode else {
          failureBlock()
          return
        }
        if 200...299 ~= statusCode  {
          completionHandler(dataX)
        } else {
          failureBlock()
        }
      case .failure(let error):
        failureBlock()
        appDelegate?.window?.rootViewController?.showNormalAlert(for: "Api Failur status code \(response.response?.statusCode.description ?? "No Status Code") \(response.error.debugDescription)")
         
      }
    }
    //delete
    self.request.responseJSON {(response) in
      print(response.result.value ?? "No Value")
      print(response.result )
      print(response.error ?? "")
      print(response.response ?? "")
      print(response.request ?? "No request")
      switch response.result {
      case .failure(let error):
        print(error)
      case .success(let val):
        print(val)
      }
    }
  }
}
class ProgressHud: NSObject {
  class func showProgressHUD() {
    SVProgressHUD.show()
    SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
    SVProgressHUD.setForegroundColor (UIColor.white)
    SVProgressHUD.setBackgroundColor (UIColor.clear)
    SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
    SVProgressHUD.setRingNoTextRadius(20)
    SVProgressHUD.setRingThickness(3)
    SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
  }
  class func hideProgressHUD() {
    SVProgressHUD.dismiss()
  }
  class func showSuccessWithMessage(message: String?) {
    SVProgressHUD.showSuccess(withStatus: message)
    SVProgressHUD.setBackgroundColor(UIColor.blue)
    SVProgressHUD.setMinimumDismissTimeInterval(2)
  }
}
