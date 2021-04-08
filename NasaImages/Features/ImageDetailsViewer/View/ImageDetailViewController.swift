//
//  ViewController.swift
//  NasaImages
//
//  Created by Shivam Gaur (BLR GSS) on 08/04/21.
//

import UIKit

class ImageDetailViewController: UIViewController, ImageDetailViewable {
   
    var viewModel: ImageDetailViewModelable?
    var photoImageView: UIImageView?
    var descriptionLabel: UILabel?
    

    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

