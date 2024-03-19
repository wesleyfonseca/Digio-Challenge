import UIKit

final class ProductDetailView: UIView {
    
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
    
    private let bannerImageContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 50
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 3
        view.clipsToBounds = true
        return view
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
extension ProductDetailView: ViewCodeProtocol {
    func buildViewHierarchy() {
        addSubview(bannerImageContainerView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        bannerImageContainerView.addSubview(bannerImageView)
    }
    
    func setupConstraints() {
        bannerImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bannerImageContainerView.heightAnchor.constraint(equalToConstant: 100),
            bannerImageContainerView.widthAnchor.constraint(equalToConstant: 100),
            bannerImageContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
            bannerImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0)
        ])
        
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bannerImageView.heightAnchor.constraint(equalToConstant: 50),
            bannerImageView.widthAnchor.constraint(equalToConstant: 50),
            bannerImageView.centerXAnchor.constraint(equalTo: bannerImageContainerView.centerXAnchor),
            bannerImageView.centerYAnchor.constraint(equalTo: bannerImageContainerView.centerYAnchor)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: bannerImageContainerView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: bannerImageContainerView.trailingAnchor, constant: 8.0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0)
        ])
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: bannerImageContainerView.bottomAnchor, constant: 24.0),
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
extension ProductDetailView {
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
