import UIKit

final class NetworkImageLoader: UIImageView {
    
    // MARK: - Properties
    private let imageCache = NSCache<NSString, UIImage>()
    private var imageUrlString: String?
    
    // MARK: - Methods
    func downloadImage(with urlString: String, completion: ((NetworkErrorType) -> Void)? = nil ) {
        imageUrlString = urlString
        
        guard let url = URL(string: urlString) else {
            completion?(.unknown)
            return
        }
        
        image = nil
        
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error {
                print(error.localizedDescription)
                completion?(.loadingImageError)
                return
            }
            
            guard let data else {
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self?.imageCache.setObject(image, forKey: NSString(string: urlString))
                    if self?.imageUrlString == urlString {
                        self?.image = image
                    }
                } else {
                    completion?(.loadingImageError)
                }
            }
        }.resume()
    }
}
