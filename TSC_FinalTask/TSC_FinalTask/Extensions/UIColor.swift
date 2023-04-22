import UIKit

extension UIColor {
    static func dynamic(lightColor: UIColor, darkColor: UIColor) -> UIColor {
        return UIColor {(traitCollection) in
            switch traitCollection.userInterfaceStyle {
            case .light:
                return lightColor
            case .unspecified:
                return lightColor
            case .dark:
                return darkColor
            @unknown default:
                return lightColor
            }
        }
    }
}
