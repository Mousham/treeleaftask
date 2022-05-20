//
//  Employee.swift
//  MVVMExample
//
//  Created by John Codeos on 06/19/20.
//

import Foundation
import ObjectMapper
typealias Employees = [Employee]

// MARK: - Employee
class Employee: DefaultResponse {
    var id: String?
    var employeeName: String?
    var employeeSalary: String?
    var employeeAge: String?


  override func mapping(map: Map) {
   super.mapping(map: map)
    id <- map["id"]
    employeeSalary <- map["employee_salary"]
    employeeName <- map["employee_name"]
    employeeAge <- map["employee_age"]
    
  }
}
