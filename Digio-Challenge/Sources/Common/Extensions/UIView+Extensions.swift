import UIKit

extension UIView {
    
    func pinToBounds(of view: UIView, customSpacing: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: customSpacing.top),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: customSpacing.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -customSpacing.right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -customSpacing.bottom)
        ])
    }
}
