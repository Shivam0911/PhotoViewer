//
//  CacheProvidable.swift
//  NasaImages
//
//  Created by Shivam Gaur (BLR GSS) on 08/04/21.
//

import Foundation
import UIKit

protocol CacheProvidable {
    func saveImage(with: UIImage, for nasaObj: NasaImage)
    func getData(for nasaObj: NasaImage, completion: (UIImage?, NasaImage?) -> Void)
}
