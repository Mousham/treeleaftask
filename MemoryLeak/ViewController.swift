//
//  ViewController.swift
//  MemoryLeak
//
//  Created by Midas on 17/05/2022.
//

import UIKit
import Photos
class Person {
    var name: String
    var age: Int
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
     var apartment: School?
}


class School {
    let roll: String
    init(roll: String) {
        self.roll = roll
    }
     var tenant: Person?
}
class ViewController: UIViewController {

    @IBOutlet weak var leakLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        memoryLeak()
        showAnimation()
      
    }
    func memoryLeak() {
        self.view.backgroundColor = .red
        let person = Person(name: "No Name", age: 30)
        let unit4A = School(roll: "10")
        person.apartment = unit4A
        unit4A.tenant = person
    }
    func showAnimation() {      
       
            UIView.transition(with: leakLbl, duration: 1.5,
                              options: .transitionCrossDissolve,
                              animations: {
                self.leakLbl.alpha = 0
                          })
            UIView.transition(with: leakLbl, duration: 1.5,
                              options: .transitionCrossDissolve,
                              animations: {
                self.leakLbl.alpha = 1
                          })
        
       
    }
   


}

