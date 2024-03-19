import UIKit

final class BannerDetailView: UIView {
    
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = .lightGray
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = .darkGray
        label.numberOfLines = .zero
        return label
    }()
    
    private let bannerImageView: NetworkImageLoader = {
        let image = NetworkImageLoader()
        image.contentMode = .scaleAspectFit
        return image
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
extension BannerDetailView: ViewCodeProtocol {
    func buildViewHierarchy() {
        addSubview(bannerImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
            bannerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bannerImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 16.0),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0)
        ])
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -8.0)
        ])
    }
    
    func setupAditionalConfiguration() {
        backgroundColor = .clear
    }
}

// MARK: - Configuration
extension BannerDetailView {
    struct Configuration {
        let imageUrl: String
        let name: String
        let description: String
    }
    
    func build(configuration: Configuration) {
        bannerImageView.downloadImage(with: configuration.imageUrl)
        titleLabel.text = configuration.name
        descriptionLabel.text = configuration.description
    }
}
