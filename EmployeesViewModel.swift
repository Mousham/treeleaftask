//
//  EmployeesViewModel.swift
//  MVVMExample
//
//  Created by John Codeos on 06/19/20.
//

import Foundation
import ObjectMapper

class EmployeesViewModel: NSObject {
    private var employeeService: EmployeesServiceProtocol
    
    var reloadTableView: (() -> Void)?
    
    var employees = Employees(_immutableCocoaArray: Map(mappingType: .fromJSON, JSON: ["" : ""]))
    
    var employeeCellViewModels = [EmployeeCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }

    init(employeeService: EmployeesServiceProtocol = EmployeesService()) {
        self.employeeService = employeeService
    }
    
    func getEmployees() {
        
//        JokesResponseModel.requestForJokes(showHud: true) { [weak self] (response) in
//            guard let stronSelf = self else { return }
//            stronSelf.fetchData(employees: (response?.notificatoin!)!)
//        }
        employeeService.getEmployees { success, model, error in
            if success, let employees = model {
                self.fetchData(employees: employees)
            } else {
                print(error!)
            }
        }
    }
    
    func fetchData(employees: Employees) {
        self.employees = employees // Cache
        var vms = [EmployeeCellViewModel]()
        for employee in employees {
            vms.append(createCellModel(employee: employee))
        }
        employeeCellViewModels = vms
    }
    
    func createCellModel(employee: Employee) -> EmployeeCellViewModel {
        let id = employee.id ?? ""
        let name = employee.employeeName
      let salary = "$ " + (employee.employeeSalary ?? "")
        let age = employee.employeeAge
        
        return EmployeeCellViewModel(id: id, name: name ?? "", salary: salary ?? "", age: age ?? "")
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> EmployeeCellViewModel {
        return employeeCellViewModels[indexPath.row]
    }
}
struct EmployeeCellViewModel {
    var id: String
    var name: String
    var salary: String
    var age: String
}
