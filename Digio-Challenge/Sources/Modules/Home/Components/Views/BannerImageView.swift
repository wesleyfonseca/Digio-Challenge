import UIKit

import UIKit

final class BannerImageView: UIView {
    
    // MARK: - Properties
    private let bannerImageView: NetworkImageLoader = {
        let imageView = NetworkImageLoader()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16.0
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
    }
}

// MARK: - ViewCodeProtocol
extension BannerImageView: ViewCodeProtocol {
    func buildViewHierarchy() {
        addSubview(bannerImageView)
    }
    
    func setupConstraints() {
        bannerImageView.pinToBounds(
            of: self,
            customSpacing: .init(
                top: Constants.spacing,
                left: Constants.spacing,
                bottom: Constants.spacing,
                right: Constants.spacing
            )
        )

    }
    
    func setupAditionalConfiguration() {
        backgroundColor = .clear
    }
}

// MARK: - Configuration
extension BannerImageView {
    struct Configuration {
        let imageUrl: String
    }
    
    func build(configuration: Configuration) {
        bannerImageView.downloadImage(with: configuration.imageUrl)
    }
}
