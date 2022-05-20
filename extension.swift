//
//  extension.swift
//  MVVVMApiCall
//
//  Created by Midas on 18/05/2022.
//

import Foundation
import UIKit
extension UIViewController {
func showNormalAlert(for alert: String? = "", completionHandler: (() -> Void)? = nil) {
  let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
  let alertAction = UIAlertAction(title: "OK", style: .cancel) { (alert) in
    completionHandler?()
  }
  alertController.addAction(alertAction)
  present(alertController, animated: true, completion: nil)
}
}
extension UIView {
func addShadow(view: UIView,width: Int, height: Int,shadowRadius: CGFloat, shadowOpacity: Float) {
    view.layer.shadowOffset = CGSize(width: width,
                                      height: height)
    view.layer.shadowRadius = shadowRadius
    view.layer.shadowOpacity = shadowOpacity
    view.layer.shadowColor = UIColor.lightGray.cgColor
}
}
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
extension UIView {

    func applyGradient(isVertical: Bool, colorArray: [UIColor]) {
        layer.sublayers?.filter({ $0 is CAGradientLayer }).forEach({ $0.removeFromSuperlayer() })
         
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colorArray.map({ $0.cgColor })
        if isVertical {
            //top to bottom
            gradientLayer.locations = [0.0, 1.0]
        } else {
            //left to right
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1)
        }
        
        backgroundColor = .clear
        gradientLayer.frame = bounds
        layer.cornerRadius = 12
        clipsToBounds = true
        layer.insertSublayer(gradientLayer, at: 0)
    }

}
