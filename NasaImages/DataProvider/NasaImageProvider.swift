//
//  NasaImageProvider.swift
//  NasaImages
//
//  Created by Shivam Gaur (BLR GSS) on 08/04/21.
//

import Foundation
import UIKit

class NasaImageProvider: NasaImageProvidable {
   
    static var imageCache = NSCache<NSString, UIImage>()
    var provider: Providable?

    init() {
        provider = NetworkProvider()
    }
    func getNasaImage(with params: JSONDictionary, completion: @escaping (NasaImage?, UIImage?) -> Void) {
        provider?.get(with: params, NasaImage.self) { [weak self] nasaObj in
            guard let nasaObj = nasaObj else {
                completion(nil, nil)
                return
            }
            if let cachedImage = NasaImageProvider.imageCache.object(forKey: nasaObj.hdurl as NSString) {
                completion(nasaObj, cachedImage)
            } else {
            self?.provider?.getImage(nasaObj.hdurl) { image in
                guard let image = image else {
                    completion(nil, nil)
                    return
                }
                NasaImageProvider.imageCache.setObject(image, forKey: nasaObj.hdurl as NSString)
                completion(nasaObj, image)
            }
        }
        }
    }
}
