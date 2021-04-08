//
//  ImageDetailViewModel.swift
//  NasaImages
//
//  Created by Shivam Gaur (BLR GSS) on 08/04/21.
//

import Foundation
import UIKit

class  ImageDetailViewModel: ImageDetailViewModelable {
    var provider: NasaImageProvidable?
    
    var dataSource: ((NasaImage?, UIImage?) -> Void)?
    
    init() {
        self.provider = NasaImageProvider()
        loadImage()
    }
    
    private func loadImage() {
        
        let parameters: JSONDictionary = [
            ApiKeys.apiKey.rawValue: GlobalConstants.NASA_API_KEY,
        ]
        provider?.getNasaImage(with: parameters, completion: {  (nasaObj, nasaImage)  in
            self.dataSource!(nasaObj, nasaImage)
        })
    }
    
}
