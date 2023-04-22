import UIKit

struct NavigationBarModel {
    struct NavigationBarAppearance {
        enum NavigationBarStyle {
            case large
            case inline
        }
        let style: NavigationBarStyle
        let color: UIColor
    }
    let appearance: NavigationBarAppearance
    
    let titleItem: NavigationBarItem?
    let leftItem: NavigationBarItem?
    let rightItem: NavigationBarItem?
    let subtitle: String?
    
    init(appearence: NavigationBarAppearance = NavigationBarAppearance(
        style: .inline, color: UIColor.dynamic(lightColor: .white, darkColor: .black)),
         titleItem: NavigationBarItem? = nil,
         leftItem: NavigationBarItem? = nil,
         rightItem: NavigationBarItem? = nil,
         subtitle: String? = nil) {
        self.appearance = appearence
        self.titleItem = titleItem
        self.leftItem = leftItem
        self.rightItem = rightItem
        self.subtitle = subtitle
    }
}

protocol NavigationBar {
    var titleItem: NavigationBarButton { get }
    var rightItem: NavigationBarButton { get }
    var leftItem: NavigationBarButton { get }
    var subtitle: UILabel { get }
}

private extension NavigationBar {
    func makeMenu(_ items: [NavigationBarItem.NavigationBarItemMenu]) -> UIMenu {
        var menuElements: [UIMenuElement] = []
        for item in items {
            menuElements.append(UIAction(title: item.title, handler: item.didTap))
        }
        return UIMenu(children: menuElements)
    }
}

final class NavigationBarImpl: NavigationBar {
        
    // MARK: - initialization
    
    init(_ model: NavigationBarModel) {
        if let titleItemModel = model.titleItem {
            settitleItem(titleItemModel)
        }
        if let leftItemModel = model.leftItem {
            setleftItem(leftItemModel)
        }
        if let rightItemModel = model.rightItem {
            setrightItem(rightItemModel)
        }
        if let subtitle = model.subtitle {
            self.subtitle.text = subtitle
        }
    }
    
    // MARK: - create UI
    
    private(set)var titleItem: NavigationBarButton = {
        var view = NavigationBarButtonImpl()
        view.imageView?.clipsToBounds = true
        view.imageView?.contentMode = .scaleAspectFit
        view.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        view.setTitleColor(UIColor.dynamic(lightColor: .black, darkColor: .white), for: .normal)
        view.isEnabled = false
        return view
    }()
    
    private(set)var leftItem: NavigationBarButton = {
        var view = NavigationBarButtonImpl()
        view.frame.size.width = 100
        view.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        view.setTitleColor(UIColor.dynamic(lightColor: .systemBlue, darkColor: .systemBlue), for: .normal)
        view.setTitleColor(UIColor.dynamic(lightColor: .systemBlue, darkColor: .systemBlue).withAlphaComponent(0.5), for: .highlighted)
        return view
    }()
    
    private(set)var rightItem: NavigationBarButton = {
        var view = NavigationBarButtonImpl()
        view.frame.size.width = 100
        view.imageView?.clipsToBounds = true
        view.imageView?.contentMode = .scaleAspectFill
        view.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        view.setTitleColor(UIColor.dynamic(lightColor: .systemBlue, darkColor: .systemBlue), for: .normal)
        view.setTitleColor(UIColor.dynamic(lightColor: .systemBlue, darkColor: .systemBlue).withAlphaComponent(0.5), for: .highlighted)
        return view
    }()
    
    private(set) var subtitle: UILabel = {
        var view = UILabel()
        view.textAlignment = .center
        view.textColor = UIColor.dynamic(lightColor: .black, darkColor: .white)
        view.font = UIFont.systemFont(ofSize: 13)
        return view
    }()
    
    // MARK: - configure UI
    
    private func settitleItem(_ item: NavigationBarItem) {
        
        titleItem.itemState = item.itemState
        
        if let didTap = item.didTap {
            self.titleItem.addAction(UIAction(handler: didTap), for: .touchUpInside)
        }
        if let menuItems = item.menu {
            self.titleItem.menu = makeMenu(menuItems)
        }
    }

    private func setleftItem(_ item: NavigationBarItem) {
        
        leftItem.itemState = item.itemState
        
        if let didTap = item.didTap {
            self.leftItem.addAction(UIAction(handler: didTap), for: .touchUpInside)
        }
        if let menuItems = item.menu {
            self.leftItem.menu = makeMenu(menuItems)
        }
    }

    private func setrightItem(_ item: NavigationBarItem) {
        
        rightItem.itemState = item.itemState
        
        if let didTap = item.didTap {
            self.rightItem.addAction(UIAction(handler: didTap), for: .touchUpInside)
        }
        if let menuItems = item.menu {
            self.rightItem.menu = makeMenu(menuItems)
        }
    }
        
}
