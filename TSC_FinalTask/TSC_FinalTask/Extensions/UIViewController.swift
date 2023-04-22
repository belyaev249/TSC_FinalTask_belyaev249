import UIKit

extension UIViewController {
    func configureNavigationBar(_ model: NavigationBarModel) -> NavigationBar {
        navigationController?.isNavigationBarHidden = false
        let navItem = NavigationBarImpl(model)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navItem.leftItem)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: navItem.rightItem)
        navigationItem.titleView = navItem.titleItem
                
        let appearence = UINavigationBarAppearance()
        if model.appearance.color == .clear {
            appearence.configureWithOpaqueBackground()
        }
        appearence.backgroundColor = model.appearance.color
        appearence.shadowColor = UIColor.dynamic(lightColor: .clear, darkColor: .clear)
        
        navigationItem.standardAppearance = appearence
        navigationItem.compactAppearance = appearence
        navigationItem.scrollEdgeAppearance = appearence
        
        if model.appearance.style == .large {
            navigationItem.prompt = String()
        }
        
        if model.subtitle != nil, let navigationController = navigationController as? NavigationController {
            navItem.subtitle.alpha = 0.0
            navigationController.navigationBar.addSubview(navItem.subtitle)
        }
        
        return navItem
    }
}
