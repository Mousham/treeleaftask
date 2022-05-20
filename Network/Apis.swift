//
//  Apis.swift
//  MVVVMApiCall
//
//  Created by Midas on 18/05/2022.
//

import Foundation
class AppURL: NSObject {
    //http://202.51.74.69:8085
 
  static let baseURL = "https://api.jokes.one/"
 

  
  static var getJokes: String = {
    let url = "https://raw.githubusercontent.com/johncodeos-blog/MVVMiOSExample/main/demo.json"
    return url
  }()
}

