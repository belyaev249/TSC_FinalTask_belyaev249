import UIKit
import Combine

final class MainModuleViewController: UIViewController {
    
    private var bag = Set<AnyCancellable>()
    private let viewModel: MainModuleViewModel
 
    // MARK: - properties
            
    private lazy var mainView = MainModuleView()
    
    // MARK: - initialization
    
    init(viewModel: MainModuleViewModel = MainModuleViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - lifecycles
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

// MARK: - actions

@objc
private extension MainModuleViewController {
    
}

final class MainModuleView: UIView {
    
    // MARK: - ui
    
    private(set) lazy var segment: UISegmentedControl = {
        var view = UISegmentedControl(items: ["Header", "List", "Cards", "Button"])
        
        return view
    }()
    
    private(set) lazy var megaView: MegaView = {
        var view = MegaView(frame: .init(), collectionViewLayout: .init())
        view.backgroundColor = .white

        view.register(MegaViewCell.self, forCellWithReuseIdentifier: MegaViewCell.reuseId)
        view.register(MegaViewButton.self, forCellWithReuseIdentifier: MegaViewButton.reuseId)
        
        return view
    }()
    
    // MARK: - initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray4
        
        addSubview(segment)
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(handleSegment), for: .valueChanged)
        addSubview(megaView)
        
        self.megaView.layoutUpdated = {[weak self] _ in
            self?.setNeedsLayout()
        }
        
        self.reloadTable(headerModel)
        
    }
    
    @objc func handleSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.reloadTable(headerModel)
        case 1:
            self.reloadTable(listModel)
        case 2:
            self.reloadTable(cardsModel)
        case 3:
            self.reloadTable(buttonModel)
        default:
            self.reloadTable(headerModel)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        segment.frame = .init(x: 50, y: 50, width: frame.width - 100, height: 50)
        
        megaView.layer.cornerRadius = 20.0
        
        let maxHeight = (frame.height - 100) * 0.8
        
        let width = frame.width * 0.8
        let height = megaView.collectionViewLayout.collectionViewContentSize.height > 0.0
        ? (megaView.collectionViewLayout.collectionViewContentSize.height > maxHeight
           ? maxHeight : megaView.collectionViewLayout.collectionViewContentSize.height)
        : 300.0
        
        megaView.frame = .init(x: (frame.width - width) / 2.0,
                               y: (frame.height - height) / 2.0,
                               width: width,
                               height: height)
    }
    
    func reloadTable(_ model: MegaModel) {
        self.megaView.reload(
            with: model,
            completion: {[weak self] in
                self?.setNeedsLayout()
            })
    }
    
}
