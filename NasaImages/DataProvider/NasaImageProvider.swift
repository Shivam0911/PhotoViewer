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
    var showingLastImageCallback: (() -> Void)?

    init() {
        provider = NetworkProvider()
        cacheProvider = CacheProvider()
    }
    
    func getNasaImage(with params: JSONDictionary, completion: @escaping (NasaImage?, UIImage?) -> Void) {
        provider.get(with: params, NasaImage.self) { [weak self] (nasaObj, nError) in
            if let nError = nError, nError == .notConnected {
                self?.showingLastImageCallback?()
            }
            self?.checkForLocalCache(with: nasaObj, completion: completion)
        }
    }
    
    private func checkForLocalCache(with nasaObj: NasaImage?,
                                    completion: @escaping (NasaImage?, UIImage?) -> Void) {
        self.cacheProvider.getData { [weak self] (cacheImage, cacheNasaObj) in
            if let cachedImage = cacheImage,
               let cacheNasaObj = cacheNasaObj,
               let isSameday = self?.isSameDay(with: cacheNasaObj.date),
               isSameday {
                completion(cacheNasaObj, cachedImage)
            } else {
                if let nasaObj = nasaObj {
                    self?.downLoadImage(with: nasaObj, completion: completion)
                } else {
                    completion(nil, nil)
                }
            }
        }

    }
    
    private func isSameDay(with date: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let date = dateFormatter.date(from: date) {
            let currentDate =  Date()
            let diff = Calendar.current.dateComponents([.day], from: currentDate, to: date)
            return  diff.day == 0
        }
        return  false
    }
    
    private func downLoadImage(with nasaObj: NasaImage, completion: @escaping (NasaImage?, UIImage?) -> Void ) {
        self.provider.getImage(nasaObj.hdurl) { image in
            guard let image = image else {
                completion(nil, nil)
                return
            }
            self.cacheProvider.saveImage(with: image, for: nasaObj)
            completion(nasaObj, image)
        }
    }
}
