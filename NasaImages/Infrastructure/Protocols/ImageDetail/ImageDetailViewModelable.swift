//
//  ImageDetailViewmodelable.swift
//  NasaImages
//
//  Created by Shivam Gaur (BLR GSS) on 08/04/21.
//

import Foundation
import UIKit

protocol ImageDetailViewModelable {
    var provider: NasaImageProvidable? { get set }
    var showingLastImageCallback: (() -> Void)? { get set }
    var dataSource: ((NasaImage?, UIImage?) -> Void)? { get set }
}
