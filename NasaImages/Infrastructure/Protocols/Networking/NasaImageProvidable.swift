//
//  NasaImageProvidable.swift
//  NasaImages
//
//  Created by Shivam Gaur (BLR GSS) on 08/04/21.
//

import UIKit

protocol ContactProvidable {
    var provider: Providable? { get set }
    func getNasaImage(completion: @escaping (NasaImage?, UIImage?) -> Void)
}
