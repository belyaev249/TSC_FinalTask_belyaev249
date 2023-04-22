import UIKit

final class NavigationController: UINavigationController {
    
    private(set) var footer = CALayer()
        
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationBar.prefersLargeTitles = true
        self.interactivePopGestureRecognizer?.isEnabled = true
        
        self.footer.zPosition = -1
        self.footer.frame.origin = CGPoint()
        navigationBar.layer.insertSublayer(footer, at: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.footer.frame.size = CGSize(width: navigationBar.frame.width, height: navigationBar.frame.height)
    }
    
}
