//
//  MovieListCellViewModel.swift
//  MovieDatabase
//
//  Created by Piotr Furmanski on 11/02/2021.
//

import UIKit

class MovieListCellViewModel {
    private(set) var cachedImage = NSCache<NSString, UIImage>()
    
    func loadImage(urlString: String, id: String,
                   completion: @escaping (_ image: UIImage?, _ id: String) -> ()) {
        if let image = cachedImage.object(forKey: id as NSString) {
            completion(image, id)
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async { [weak self] in
            guard let strongSelf = self else { return }
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    strongSelf.cachedImage.setObject(image,
                                                     forKey: id as NSString)
                    DispatchQueue.main.async {
                        completion(image, id)
                    }
                }
            }
        }
    }
}
