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
    
    private let errorTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .systemRed
        label.numberOfLines = 2
        label.text = "Image not available"
        label.isHidden = true
        return label
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
        container.addSubview(errorTitleLabel)
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
        
        errorTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorTitleLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            errorTitleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            errorTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            errorTitleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor)
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
        bannerImageView.downloadImage(with: configuration.imageUrl) { [weak self] error in
            guard let self else { return }
            
            if error == .loadingImageError {
                errorTitleLabel.isHidden = false
            }
        }
    }
}
