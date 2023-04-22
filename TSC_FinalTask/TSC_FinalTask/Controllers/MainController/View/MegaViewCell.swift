import UIKit

final class MegaViewCell: UICollectionViewCell, ConfigurableCell {
    
    static var reuseId: String = "MegaViewCell"
    
    typealias ConfigurableModel = MegaItemModel
    
    // MARK: - ui
    
    private lazy var container: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var item: MegaItemView = {
        var view = MegaItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 12.0
                        
        contentView.addSubview(container)
        setupContainer()
        
        container.addSubview(item)
        setupItem()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - init
    
    func configure(with model: MegaItemModel) {
        item.configure(model)
        backgroundColor = model.color
    }
    
}

private extension MegaViewCell {
    
    func setupContainer() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10))
        constraints.append(container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10))
        constraints.append(container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10))
        constraints.append(container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10))
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupItem() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(item.topAnchor.constraint(equalTo: container.topAnchor))
        constraints.append(item.leadingAnchor.constraint(equalTo: container.leadingAnchor))
        constraints.append(item.trailingAnchor.constraint(equalTo: container.trailingAnchor))
        constraints.append(item.bottomAnchor.constraint(equalTo: container.bottomAnchor))
        NSLayoutConstraint.activate(constraints)
    }
    
}


