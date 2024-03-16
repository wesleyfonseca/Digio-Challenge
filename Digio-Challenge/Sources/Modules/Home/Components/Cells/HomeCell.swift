import UIKit

final class HomeCell: UITableViewCell {
    
    // MARK: - Properties
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 8.0
        return stackView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(
            top: Constants.insetsMargin,
            left: Constants.insetsMargin,
            bottom: Constants.insetsMargin,
            right: Constants.insetsMargin
        )
        layout.itemSize = CGSize(width: cardWidth, height: cardHeight)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    private let bannerImageView: NetworkImageLoader = {
        let imageView = NetworkImageLoader()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var cardWidth: Double {
        guard let configuration else { return 0.0 }
        
        switch configuration.type {
        case .spotlight:
            return (UIScreen.main.bounds.width * 0.95) - (Constants.insetsMargin * 2)
        case .cash:
            return (UIScreen.main.bounds.width) - (Constants.insetsMargin * 2)
        case .products:
            return (UIScreen.main.bounds.width / 2.5) - (Constants.insetsMargin * 2)
        }
    }
    
    private var cardHeight: Double {
        guard let configuration else { return 0.0 }
        
        switch configuration.type {
        case .spotlight:
            return 200
        case .cash:
            return 100
        case .products:
            return 40
        }
    }
    
    private var configuration: HomeCell.Configuration?
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Enums
    enum Constants {
        static let insetsMargin = 10.0
    }
}

// MARK: - ViewCodeProtocol
extension HomeCell: ViewCodeProtocol {
    func buildViewHierarchy() {
        contentView.addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.pinToBounds(of: self)
    }
    
    func setupAditionalConfiguration() {
        backgroundColor = .clear
    }
    
    private func setupConstraintsWithTypeSelected() {
        guard let configuration else { return }
        
        switch configuration.type {
        case .spotlight:
            return
        case .cash:
            return
        case .products:
            return
        }
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension HomeCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("\(indexPath.item + 1)")
    }
}

// MARK: - Configuration
extension HomeCell {
    enum HomeCellType {
        case spotlight
        case cash
        case products
    }
    
    struct Configuration {
        let type: HomeCellType
        let spotlightConfiguration: [Spotlight]?
        let cashConfiguration: Cash?
        let productsConfiguration: [Product]?
        
        init(
            type: HomeCellType,
            spotlightConfiguration: [Spotlight]? = nil,
            cashConfiguration: Cash? = nil,
            productsConfiguration: [Product]? = nil
        ) {
            self.type = type
            self.spotlightConfiguration = spotlightConfiguration
            self.cashConfiguration = cashConfiguration
            self.productsConfiguration = productsConfiguration
        }
    }
    
    func build(configuration: Configuration) {
        self.configuration = configuration
        
        switch configuration.type {
        case .spotlight:
            break
        case .cash:
            break
        case .products:
            break
        }
        
        stackView.addArrangedSubview(collectionView)
        collectionView.heightAnchor.constraint(equalToConstant: cardHeight).isActive = true
    }
}
