//
//  NasaImageProvider.swift
//  NasaImages
//
//  Created by Shivam Gaur (BLR GSS) on 08/04/21.
//

import Foundation
import UIKit

class NasaImageProvider: NasaImageProvidable {
   
    let cacheProvider: CacheProvidable
    let provider: Providable

    init() {
        provider = NetworkProvider()
        cacheProvider = CacheProvider()
    }
    func getNasaImage(with params: JSONDictionary, completion: @escaping (NasaImage?, UIImage?) -> Void) {
        provider.get(with: params, NasaImage.self) { [weak self] nasaObj in
            guard let nasaObj = nasaObj else {
                completion(nil, nil)
                return
            }
            self?.cacheProvider.getData(for: nasaObj) { [weak self] (cacheImage, cacheNasaObj) in
                if let cachedImage = cacheImage,
                   let nasaObj = cacheNasaObj {
                    completion(nasaObj, cachedImage)
                } else {
                    self?.provider.getImage(nasaObj.hdurl) { image in
                        guard let image = image else {
                            completion(nil, nil)
                            return
                        }
                        self?.cacheProvider.saveImage(with: image, for: nasaObj)
                        completion(nasaObj, image)
                    }
                    
                }
            }
        }
    }
}
