import UIKit

final class HomeTableCell: UITableViewCell {
    
    // MARK: - Properties
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 8.0
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
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
        collectionView.register(
            HomeCollectionCell.self,
            forCellWithReuseIdentifier: String(describing: HomeCollectionCell.self)
        )
        return collectionView
    }()
    
    private let bannerImageView: NetworkImageLoader = {
        let imageView = NetworkImageLoader()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var cardWidth: Double {
        guard let configuration else { return 0.0 }
        
        switch configuration.collectionConfiguration.type {
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
        
        switch configuration.collectionConfiguration.type {
        case .spotlight:
            return 200
        case .cash:
            return 100
        case .products:
            return 40
        }
    }
    
    private var configuration: HomeTableCell.Configuration?
    
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
extension HomeTableCell: ViewCodeProtocol {
    func buildViewHierarchy() {
        contentView.addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.pinToBounds(of: contentView)
    }
    
    func setupAditionalConfiguration() {
        backgroundColor = .clear
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension HomeTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeCollectionCell.self), for: indexPath) as? HomeCollectionCell else {
            return UICollectionViewCell()
        }
        
        guard let configuration else {
            return UICollectionViewCell()
        }
    
        cell.build(configuration: configuration.collectionConfiguration)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("\(indexPath.item + 1)")
    }
}

// MARK: - Configuration
extension HomeTableCell {
    struct Configuration {
        let title: String?
        let collectionConfiguration: HomeCollectionCell.Configuration
        
        init(
            title: String? = nil,
            collectionConfiguration: HomeCollectionCell.Configuration
        ) {
            self.title = title
            self.collectionConfiguration = collectionConfiguration
        }
    }
    
    func build(configuration: Configuration) {
        self.configuration = configuration
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(collectionView)
        
        collectionView.heightAnchor.constraint(equalToConstant: cardHeight).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        
        if let title = configuration.title {
            titleLabel.text = title
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.insetsMargin).isActive = true
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24).isActive = true
        }
    }
}
