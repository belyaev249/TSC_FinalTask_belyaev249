import UIKit

private struct Constants {
    static let maximumImageHeight = 40.0
    static let horizontalInset = 16.0
    static let textVerticalInset = 8.0
}

final class MegaItemView: UIView {
    
    private lazy var lttConstraints = makeLeadingToTrailingConstraints()
    private lazy var ttlConstraints = makeTrailingToLeadingConstraints()
    private lazy var ttbConstraints = makeTopToBottomConstraints()
        
    // MARK: - ui
    
    private lazy var textContainer: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var title: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        return view
    }()
    
    private lazy var subtitle: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        return view
    }()
    
    private lazy var image: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    // MARK: - initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addSubview(image)
        setupImage()
        addSubview(textContainer)
        
        textContainer.addSubview(title)
        setupTitle()
        textContainer.addSubview(subtitle)
        setupSubitle()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ model: MegaItemModel) {
        
        title.text = model.description.title?.text
        title.textColor = model.description.title?.color
        title.font = model.description.title?.font
        
        subtitle.text = model.description.subtitle?.text
        subtitle.textColor = model.description.subtitle?.color
        subtitle.font = model.description.subtitle?.font
        
        image.image = model.description.image
        
        setupConstraints(model.appearance)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        image.layer.cornerRadius = min(image.frame.width, image.frame.height) / 2.0
    }
    
}

private extension MegaItemView {
    
    func setupConstraints(_ appearance: MegaItemModel.Appearance) {
        
        let constraints: [NSLayoutConstraint] = [lttConstraints, ttlConstraints, ttbConstraints].flatMap({$0})
        NSLayoutConstraint.deactivate(constraints)
        
        switch appearance {
        case .leadingToTrailing:
            NSLayoutConstraint.activate(lttConstraints)
        case .trailingToLeading:
            NSLayoutConstraint.activate(ttlConstraints)
        case .topToBottom:
            NSLayoutConstraint.activate(ttbConstraints)
        }
        
        setNeedsLayout()
        
    }
    
    func setupImage() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(image.heightAnchor.constraint(equalToConstant: Constants.maximumImageHeight))
        constraints.append(image.widthAnchor.constraint(equalTo: image.heightAnchor))
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupTitle() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(title.topAnchor.constraint(equalTo: textContainer.topAnchor))
        constraints.append(title.leadingAnchor.constraint(equalTo: textContainer.leadingAnchor))
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupSubitle() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Constants.textVerticalInset))
        constraints.append(subtitle.leadingAnchor.constraint(equalTo: textContainer.leadingAnchor))
        constraints.append(subtitle.bottomAnchor.constraint(equalTo: textContainer.bottomAnchor))
        NSLayoutConstraint.activate(constraints)
    }
    
}

private extension MegaItemView {
    
    func makeLeadingToTrailingConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        constraints.append(image.topAnchor.constraint(greaterThanOrEqualTo: topAnchor))
        constraints.append(image.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor))
        
        constraints.append(image.centerYAnchor.constraint(equalTo: centerYAnchor))
        constraints.append(image.trailingAnchor.constraint(equalTo: trailingAnchor))
        
        constraints.append(textContainer.topAnchor.constraint(greaterThanOrEqualTo: topAnchor))
        constraints.append(textContainer.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor))
        
        constraints.append(textContainer.centerYAnchor.constraint(equalTo: centerYAnchor))
        constraints.append(textContainer.trailingAnchor.constraint(equalTo: image.leadingAnchor))
        constraints.append(textContainer.leadingAnchor.constraint(equalTo: leadingAnchor))
        return constraints
    }
    
    func makeTrailingToLeadingConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        constraints.append(image.topAnchor.constraint(greaterThanOrEqualTo: topAnchor))
        constraints.append(image.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor))
        
        constraints.append(image.centerYAnchor.constraint(equalTo: centerYAnchor))
        constraints.append(image.leadingAnchor.constraint(equalTo: leadingAnchor))
        
        constraints.append(textContainer.topAnchor.constraint(greaterThanOrEqualTo: topAnchor))
        constraints.append(textContainer.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor))
        
        constraints.append(textContainer.centerYAnchor.constraint(equalTo: centerYAnchor))
        constraints.append(textContainer.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: Constants.horizontalInset))
        constraints.append(textContainer.trailingAnchor.constraint(equalTo: trailingAnchor))
        return constraints
    }
    
    func makeTopToBottomConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        constraints.append(image.topAnchor.constraint(greaterThanOrEqualTo: topAnchor))
        constraints.append(image.topAnchor.constraint(equalTo: topAnchor))
        constraints.append(image.leadingAnchor.constraint(equalTo: leadingAnchor))
        
        constraints.append(textContainer.leadingAnchor.constraint(equalTo: leadingAnchor))
        constraints.append(textContainer.bottomAnchor.constraint(equalTo: bottomAnchor))
        return constraints
    }
    
}
