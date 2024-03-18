import UIKit

final class ProductImageView: UIView {
    
    // MARK: - Properties
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16.0
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 1, height: 2)
        view.layer.shadowRadius = 3
        return view
    }()
    
    private let bannerImageView: NetworkImageLoader = {
        let imageView = NetworkImageLoader()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewCodeProtocol
extension ProductImageView: ViewCodeProtocol {
    func buildViewHierarchy() {
        addSubview(container)
        container.addSubview(bannerImageView)
    }
    
    func setupConstraints() {
        container.pinToBounds(
            of: self,
            customSpacing: .init(
                top: 4,
                left: 4,
                bottom: 4,
                right: 4
            )
        )
        
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bannerImageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            bannerImageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            bannerImageView.heightAnchor.constraint(equalToConstant: 60),
            bannerImageView.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func setupAditionalConfiguration() {
        backgroundColor = .clear
    }
}

// MARK: - Configuration
extension ProductImageView {
    struct Configuration {
        let imageUrl: String
    }
    
    func build(configuration: Configuration) {
        bannerImageView.downloadImage(with: configuration.imageUrl)
    }
}
