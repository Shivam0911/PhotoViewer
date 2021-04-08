//
//  ImageDetailViewable.swift
//  NasaImages
//
//  Created by Shivam Gaur (BLR GSS) on 08/04/21.
//

import UIKit

protocol ImageDetailViewable: AnyObject {
    var viewModel: ImageDetailViewModelable? { get set }
    var photoImageView: UIImageView! { get set }
    var descriptionLabel: UILabel! { get set }
}
