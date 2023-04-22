import UIKit

protocol ConfigurableCell: UICollectionViewCell {
    associatedtype ConfigurableModel
    func configure(with model: ConfigurableModel)
    static var reuseId: String { get }
}
