import UIKit

final class HomeHeaderView: UIView {
    
    // MARK: - Properties
    private let imageIcon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
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
}

// MARK: - ViewCodeProtocol
extension HomeHeaderView: ViewCodeProtocol {
    func buildViewHierarchy() {
        addSubview(imageIcon)
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        imageIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageIcon.topAnchor.constraint(equalTo: topAnchor),
            imageIcon.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageIcon.heightAnchor.constraint(equalToConstant: Constants.iconSize),
            imageIcon.widthAnchor.constraint(equalToConstant: Constants.iconSize)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: imageIcon.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageIcon.trailingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupAditionalConfiguration() {
        backgroundColor = .clear
    }
    
    private enum Constants {
        static let iconSize: CGFloat = 24.0
    }
}

// MARK: - Configuration
extension HomeHeaderView {
    struct Configuration {
        let imageIcon: String
        let name: String
    }
    
    func build(configuration: Configuration) {
        imageIcon.image = UIImage(named: configuration.imageIcon)
        titleLabel.text = "Olá, \(configuration.name)"
    }
}

