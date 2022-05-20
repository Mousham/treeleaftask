//
//  ViewController.swift
//  MVVVMApiCall
//
//  Created by Midas on 18/05/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    lazy var viewModel = {
        EmployeesViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initView()
        initViewModel()
    }
    func initView() {
        tableView.delegate = self
        tableView.dataSource = self
       
        tableView.separatorColor = .white
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false

        tableView.register(EmployeeCell.nib, forCellReuseIdentifier: EmployeeCell.identifier)
    }
    func initViewModel() {
        // Get employees data
        viewModel.getEmployees()
        
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }


}
// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        UIView.animate(withDuration: 0.8, animations: {
//               cell.contentView.alpha = 1
//           })
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.8, animations: {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        })
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return viewModel.employeeCellModels.count
        return viewModel.employeeCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeCell.identifier, for: indexPath) as? EmployeeCell else { fatalError("xib does not exists") }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        cell.backView.layer.masksToBounds = false
        cell.backView.layer.cornerRadius = 12
        cell.backView.clipsToBounds = true
        cell.layoutSubviews()
        cell.layoutIfNeeded()
        cell.backView.applyGradient(isVertical: true, colorArray: [UIColor(hexString: "8BABCA"),UIColor(hexString: "EAD7E5")])

       //cell.contentView.alpha = 0
        return cell
    }
}



