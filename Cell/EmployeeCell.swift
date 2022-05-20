//
//  EmployeeCell.swift
//  MVVMExample
//
//  Created by John Codeos on 06/19/20.
//

import UIKit

class EmployeeCell: UITableViewCell {
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var salaryLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet var ageLabel: UILabel!

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    var cellViewModel: EmployeeCellViewModel? {
        didSet {
            idLabel.text = cellViewModel?.id
            nameLabel.text = cellViewModel?.name
            salaryLabel.text = cellViewModel?.salary
            print(cellViewModel?.age)
            ageLabel.text = cellViewModel?.age
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    override func layoutSubviews() {
            super.layoutSubviews()
            // do your thing
        backView.addShadow(view: backView, width: 0, height: 0, shadowRadius: 3, shadowOpacity: 0.5)
        backView.layer.cornerRadius = 8
        backView.clipsToBounds = true
        backView.layer.masksToBounds = false
//        backView.applyGradient(isVertical: true, colorArray: [UIColor(hexString: "8BABCA"),UIColor(hexString: "EAD7E5")])

        }

    func initView() {
        // Cell view customization
        backgroundColor = .clear
        backView.addShadow(view: backView, width: 0, height: 0, shadowRadius: 3, shadowOpacity: 0.5)
        backView.layer.cornerRadius = 8
        backView.clipsToBounds = true
        backView.layer.masksToBounds = false
        // Line separator full width
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        idLabel.text = nil
        nameLabel.text = nil
        salaryLabel.text = nil
        ageLabel.text = nil
    }
}
