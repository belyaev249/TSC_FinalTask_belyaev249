import UIKit

private struct Theme {
    static let buttonBackgroundcolor = UIColor.dynamic(lightColor: .systemGray6,
                                                       darkColor: .systemGray5)
    static let buttonTextcolor = UIColor.dynamic(lightColor: .systemBlue,
                                                       darkColor: .systemBlue)
}

final class MegaViewButton: UICollectionViewCell, ConfigurableCell {
    
    static var reuseId: String = "MegaViewButton"
    
    typealias ConfigurableModel = MegaItemModel
    
    // MARK: - ui
    
    private lazy var container: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var button: UIButton = {
        var view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.buttonBackgroundcolor
        view.setTitleColor(Theme.buttonTextcolor, for: .normal)
        return view
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        contentView.addSubview(container)
        setupContainer()
        
        container.addSubview(button)
        setupButton()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func configure(with model: MegaItemModel) {
        button.setTitleColor(model.description.title?.color, for: .normal)
        button.setTitleColor(model.description.title?.color.withAlphaComponent(0.5), for: .highlighted)
        button.setTitle(model.description.title?.text, for: .normal)
        button.titleLabel?.font = model.description.title?.font
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.layer.cornerRadius = 12.0
    }
    
}

private extension MegaViewButton {
    
    func setupContainer() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(container.topAnchor.constraint(equalTo: contentView.topAnchor))
        constraints.append(container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))
        constraints.append(container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
        constraints.append(container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupButton() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(button.topAnchor.constraint(equalTo: container.topAnchor))
        constraints.append(button.leadingAnchor.constraint(equalTo: container.leadingAnchor))
        constraints.append(button.trailingAnchor.constraint(equalTo: container.trailingAnchor))
        constraints.append(button.bottomAnchor.constraint(equalTo: container.bottomAnchor))
        NSLayoutConstraint.activate(constraints)
    }
    
}
