import UIKit

final class ProductImageView: UIView {
    
    // MARK: - Properties
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16.0
        view.addShadow()
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
    
    // MARK: - Enums
    private enum Constants {
        static let spacing: CGFloat = 4.0
        static let imageSize: CGFloat = 60.0
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
                top: Constants.spacing,
                left: Constants.spacing,
                bottom: Constants.spacing,
                right: Constants.spacing
            )
        )
        
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bannerImageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            bannerImageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            bannerImageView.heightAnchor.constraint(equalToConstant: Constants.imageSize),
            bannerImageView.widthAnchor.constraint(equalToConstant: Constants.imageSize)
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
