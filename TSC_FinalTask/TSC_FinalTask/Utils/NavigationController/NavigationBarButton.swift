import UIKit

struct NavigationBarItem {
    struct NavigationBarItemMenu {
        let title: String
        let didTap: ((UIAction) -> Void)
    }
    enum NavigationBarItemState {
        case content(NavigationBarItemAppearance)
        case activityIndicator
    }
    struct NavigationBarItemAppearance {
        let title: String?
        let image: UIImage?
        init(title: String?, image: UIImage?) {
            self.title = title
            self.image = image
        }
    }
    var itemState: NavigationBarItemState
    let didTap: ((UIAction) -> Void)?
    let menu: [NavigationBarItemMenu]?
    init(itemState: NavigationBarItemState, didTap: ((UIAction) -> Void)? = nil, menu: [NavigationBarItemMenu]? = nil) {
        self.itemState = itemState
        self.didTap = didTap
        self.menu = menu
    }
}

protocol NavigationBarButton: UIButton {
    var itemState: NavigationBarItem.NavigationBarItemState? { get set }
}

final class NavigationBarButtonImpl: UIButton, NavigationBarButton {
    
    var itemState: NavigationBarItem.NavigationBarItemState? {
        didSet {
            if let itemState {
                self.setItemState(itemState)
            }
        }
    }
    
    private func setItemState(_ state: NavigationBarItem.NavigationBarItemState) {
        switch state {
        case let .content(appearance):
            activityIndicator.stopAnimating()
            self.setTitle(appearance.title, for: .normal)
            self.setImage(appearance.image, for: .normal)
        case .activityIndicator:
            activityIndicator.startAnimating()
            self.setTitle(nil, for: .normal)
            self.setImage(nil, for: .normal)
        }
    }
    
    private lazy var activityIndicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(activityIndicator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let activityIndicatorSide = min(frame.width, frame.height)
        activityIndicator.frame.size = CGSize(width: activityIndicatorSide, height: activityIndicatorSide)
        
        let x: CGFloat
        switch contentHorizontalAlignment {
        case .leading:
            x = 0
        case .trailing:
            x = frame.width - activityIndicatorSide
        default:
            x = (frame.width - activityIndicatorSide) / 2.0
        }
        
        activityIndicator.frame.origin = CGPoint(x: x, y: 0)
        
    }
    
}
