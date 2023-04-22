import UIKit

struct Text {
    let text: String
    let font: UIFont
    let color: UIColor
}

struct MegaItemModel {
    enum Appearance {
        case leadingToTrailing
        case trailingToLeading
        case topToBottom
    }
    struct Description {
        let title: Text?
        let subtitle: Text?
        let image: UIImage?
        let didTap: ((UIAction) -> Void)?
        init(title: Text? = nil,
             subtitle: Text? = nil,
             image: UIImage? = nil,
             didTap: ((UIAction) -> Void)? = nil) {
            self.title = title
            self.subtitle = subtitle
            self.image = image
            self.didTap = didTap
        }
    }
    let id = UUID().uuidString
    let description: Description
    let appearance: Appearance
    let color: UIColor
}

extension MegaItemModel: Equatable, Hashable {
    static func == (lhs: MegaItemModel, rhs: MegaItemModel) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


struct MegaListModel {
    enum Appearance {
        case list
        case cards
    }
    let items: [MegaItemModel]
    let appearance: Appearance
}


struct MegaFooterModel {
    let text: Text
    
}



struct MegaModel {
    let header: MegaItemModel?
    let list: MegaListModel?
    let footer: MegaItemModel?
    init(header: MegaItemModel? = nil,
         list: MegaListModel? = nil,
         footer: MegaItemModel? = nil) {
        self.header = header
        self.list = list
        self.footer = footer
    }
}




private enum MegaSections: CaseIterable {
    case header
    case list
    case footer
}


private final class MegaViewDataSource: UICollectionViewDiffableDataSource<MegaSections, MegaItemModel> {
    
    init(collectionView: UICollectionView) {
        
        func makeCell<T: ConfigurableCell>
        (type: T.Type,
         collectionView: UICollectionView,
         indexPath: IndexPath,
         itemIdentifier: T.ConfigurableModel) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: T.reuseId, for: indexPath) as? T
            else {
                return UICollectionViewCell()
            }
            cell.configure(with: itemIdentifier)
            return cell
        }
        
        super.init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            
            let section = indexPath.section
            
            switch section {
            case 0:
                return makeCell(type: MegaViewCell.self,
                                     collectionView: collectionView,
                                     indexPath: indexPath,
                                     itemIdentifier: itemIdentifier)
            case 1:
                return makeCell(type: MegaViewCell.self,
                                     collectionView: collectionView,
                                     indexPath: indexPath,
                                     itemIdentifier: itemIdentifier)
            case 2:
                return makeCell(type: MegaViewButton.self,
                                     collectionView: collectionView,
                                     indexPath: indexPath,
                                     itemIdentifier: itemIdentifier)
            default:
                return makeCell(type: MegaViewCell.self,
                                     collectionView: collectionView,
                                     indexPath: indexPath,
                                     itemIdentifier: itemIdentifier)
            }
            
            
        }
        
    }
    
    
    
    
}

final class MegaView: UICollectionView {
    
    var layoutUpdated: ((CGSize?) -> Void)?
         
    private lazy var diffDataSource: MegaViewDataSource = .init(collectionView: self)
        
    // MARK: initialization
        
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.setupSnapshot()
        self.collectionViewLayout = makeLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeLayout() -> UICollectionViewLayout {
                        
        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: {[weak self] section, env in
                
                self?.layoutUpdated?(env.container.contentSize)
                                            
                switch section {
                case 0:
                    return self?.makeHeaderSection()
                case 1:
                    return self?.makeListSection()
                case 2:
                    return self?.makeFooterSection()
                default:
                    return self?.makeHeaderSection()
                }
                
        })
        
        return layout
    }
    
    private func makeHeaderSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        return section
        
    }
    
    private var appearance: MegaListModel.Appearance = .list
    
    private func makeListSection() -> NSCollectionLayoutSection {
        
        let section: NSCollectionLayoutSection
        
        switch appearance {
        case .list:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            section = NSCollectionLayoutSection(group: group)
        case .cards:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(140), heightDimension: .estimated(140))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                    
            section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            section.interGroupSpacing = 20
        }
        
        section.contentInsets = .init(top: 0, leading: 10, bottom: 10, trailing: 10)
        
        return section
        
    }
    
    private func makeFooterSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 10, leading: 10, bottom: 20, trailing: 10)
        
        return section
        
    }
    
    private func setupSnapshot() {
        var snapshot = diffDataSource.snapshot()
        snapshot.deleteAllItems()
        DispatchQueue.main.async {[weak self] in
            self?.diffDataSource.apply(snapshot, animatingDifferences: false)
        }
    }

    func reload(with model: MegaModel, completion: @escaping () -> Void) {
        var snapshot = diffDataSource.snapshot()
        
        snapshot.deleteAllItems()
        
        snapshot.appendSections(MegaSections.allCases)
        if let header = model.header {
            snapshot.appendItems([header], toSection: .header)
        }
        if let list = model.list {
            self.appearance = list.appearance
            snapshot.appendItems(list.items, toSection: .list)
        }
        if let footer = model.footer {
            snapshot.appendItems([footer], toSection: .footer)
        }
        DispatchQueue.main.async {[weak self] in
            self?.diffDataSource.apply(snapshot, animatingDifferences: false) {
                completion()
            }
        }

    }
    
}

// MARK: - GLOBAL MODEL

let headerModel: MegaModel = .init(
    header: generateHeader()
)

let cardsModel: MegaModel = .init(
    header: generateHeader(),
    list: .init(items: [
        generateItem(.topToBottom),
        generateItem(.topToBottom),
        generateItem(.topToBottom),
        generateItem(.topToBottom),
        generateItem(.topToBottom),
        generateItem(.topToBottom),
        generateItem(.topToBottom),
    ], appearance: .cards)
)

let listModel: MegaModel = .init(
    header: generateHeader(),
    list: .init(items: [
        generateItem(.trailingToLeading),
        generateItem(.trailingToLeading),
        generateItem(.trailingToLeading),
        generateItem(.trailingToLeading),
        generateItem(.trailingToLeading),
        generateItem(.trailingToLeading),
    ], appearance: .list)
)

let buttonModel: MegaModel = .init(
    header: generateHeader(),
    list: .init(items: [
        generateItem(.trailingToLeading),
        generateItem(.trailingToLeading),
        generateItem(.trailingToLeading),
        generateItem(.trailingToLeading),
        generateItem(.trailingToLeading),
        generateItem(.trailingToLeading),
    ], appearance: .list),
    footer: generateItem(.leadingToTrailing)
)

func generateHeader() -> MegaItemModel {
    let itemModel = MegaItemModel(
        description: .init(title: .init(text: "Header",
                                        font: .systemFont(ofSize: 20, weight: .bold),
                                        color: .dynamic(lightColor: .black,
                                                        darkColor: .black)),
                           subtitle: .init(text: "Subtitle",
                                           font: .systemFont(ofSize: 15, weight: .regular),
                                           color: .systemGray3),
                           image: UIImage(named: "star")),
        appearance: .leadingToTrailing, color: .clear)
    return itemModel
}

func generateItem(_ appearance: MegaItemModel.Appearance) -> MegaItemModel {
    var color: UIColor {
        switch appearance {
        case .leadingToTrailing:
            return .dynamic(lightColor: .white, darkColor: .white)
        case .trailingToLeading:
            return .dynamic(lightColor: .white, darkColor: .white)
        case .topToBottom:
            return .dynamic(lightColor: .systemGray6, darkColor: .systemGray6)
        }
    }
    let itemModel = MegaItemModel(
        description: .init(title: .init(text: "Header",
                                        font: .systemFont(ofSize: 17, weight: .regular),
                                        color: .dynamic(lightColor: .black,
                                                        darkColor: .black)),
                           subtitle: .init(text: "Subtitle",
                                           font: .systemFont(ofSize: 13, weight: .regular),
                                           color: .systemGray3),
                           image: UIImage(named: "star")),
        appearance: appearance, color: color)
    return itemModel
}

func generateText(_ text: String) -> Text {
    return .init(text: "Header", font: .systemFont(ofSize: 20), color: .black)
}
