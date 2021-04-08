//
//  CacheProvider.swift
//  NasaImages
//
//  Created by Shivam Gaur (BLR GSS) on 08/04/21.
//

import Foundation
import UIKit

enum UserDefaultsKey: String {
    case nasaobject
}

class CacheProvider: CacheProvidable {
    
    let defaults = UserDefaults.standard
  
    func saveImage(with: UIImage, for nasaObj: NasaImage) {
        let imageData = with.pngData()
        defaults.set(imageData, forKey: nasaObj.hdurl)
        defaults.save(customObject: nasaObj, inKey: UserDefaultsKey.nasaobject.rawValue)
        defaults.synchronize()
    }
    
    func getData(completion: (UIImage?, NasaImage?) -> Void) {
        guard let nasaObject = defaults.retrieve(object: NasaImage.self, fromKey: UserDefaultsKey.nasaobject.rawValue) else {
            completion(nil, nil)
            return
        }
        guard let imageData = defaults.value(forKey: nasaObject.hdurl) as? Data,
              let image = UIImage(data: imageData) else {
             completion(nil, nil)
            return
        }
        completion(image, nasaObject)
    }
}
