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
    
    private let spotiLightView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let cashView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private let productsView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
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
    
    func build(configuration: Configuration) {
        self.configuration = configuration
        
        switch configuration.type {
        case .spotlight:
            spotiLightView.isHidden = false
            cashView.isHidden = true
            productsView.isHidden = true
        case .cash:
            spotiLightView.isHidden = true
            cashView.isHidden = false
            productsView.isHidden = true
        case .products:
            spotiLightView.isHidden = true
            cashView.isHidden = true
            productsView.isHidden = false
        }
    }
}
