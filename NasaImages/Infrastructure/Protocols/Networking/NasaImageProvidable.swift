//
//  NasaImageProvidable.swift
//  NasaImages
//
//  Created by Shivam Gaur (BLR GSS) on 08/04/21.
//

import UIKit

protocol NasaImageProvidable {
    var provider: Providable { get  }
    var showingLastImageCallback: (() -> Void)? { get set }
    func getNasaImage(with params: JSONDictionary, completion: @escaping (NasaImage?, UIImage?) -> Void)
}
