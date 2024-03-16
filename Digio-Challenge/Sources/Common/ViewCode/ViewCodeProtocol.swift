import Foundation

protocol ViewCodeProtocol: AnyObject {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAditionalConfiguration()
    func setupView()
}

extension ViewCodeProtocol {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAditionalConfiguration()
    }
    
    func buildViewHierarchy() {}
    func setupConstraints() {}
    func setupAditionalConfiguration() {}
}
