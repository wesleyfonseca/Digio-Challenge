import UIKit

final class HomeCollectionCell: UICollectionViewCell {
    
    // MARK: Properties
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private let spotiLightView: BannerImageView = {
        let view = BannerImageView()
        return view
    }()
    
    private let cashView: BannerImageView = {
        let view = BannerImageView()
        return view
    }()
    
    private let productsView: ProductImageView = {
        let view = ProductImageView()
        return view
    }()
    
    private var configuration: HomeCollectionCell.Configuration?
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
   
}

// MARK: - ViewCodeProtocol
extension HomeCollectionCell: ViewCodeProtocol {
    func buildViewHierarchy() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(spotiLightView)
        stackView.addArrangedSubview(cashView)
        stackView.addArrangedSubview(productsView)
    }
    
    func setupConstraints() {
        stackView.pinToBounds(of: contentView)
    }
    
    func setupAditionalConfiguration() {
        backgroundColor = .clear
    }
}

// MARK: - Configuration
extension HomeCollectionCell {
    enum HomeCollectionCellType {
        case spotlight
        case cash
        case products
    }
    
    struct Configuration {
        let type: HomeCollectionCellType
        let spotlightConfiguration: [Spotlight]?
        let cashConfiguration: Cash?
        let productsConfiguration: [Product]?
        
        init(
            type: HomeCollectionCellType,
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
    
    func build(configuration: Configuration, indexPath: IndexPath) {
        self.configuration = configuration
        
        switch configuration.type {
        case .spotlight:
            spotiLightView.isHidden = false
            cashView.isHidden = true
            productsView.isHidden = true
            
            guard let bannerUrl = configuration.spotlightConfiguration?[indexPath.item].bannerURL else {
                return
            }
            
            spotiLightView.build(configuration: .init(type: configuration.type, imageUrl: bannerUrl))
        case .cash:
            spotiLightView.isHidden = true
            cashView.isHidden = false
            productsView.isHidden = true
            
            guard let bannerUrl = configuration.cashConfiguration?.bannerURL else {
                return
            }
            
            cashView.build(configuration: .init(type: configuration.type, imageUrl: bannerUrl))
        case .products:
            spotiLightView.isHidden = true
            cashView.isHidden = true
            productsView.isHidden = false
            
            guard let bannerUrl = configuration.productsConfiguration?[indexPath.item].imageURL else {
                return
            }
            
            productsView.build(configuration: .init(imageUrl: bannerUrl))
        }
    }
}
