//
//  ViewController.swift
//  NasaImages
//
//  Created by Shivam Gaur (BLR GSS) on 08/04/21.
//

import UIKit

class ImageDetailViewController: UIViewController, ImageDetailViewable {
   
    var viewModel: ImageDetailViewModelable?
  
    @IBOutlet internal weak var photoImageView: UIImageView!
    @IBOutlet internal weak var descriptionLabel: UILabel!
    

    override func loadView() {
        super.loadView()
        viewModel = ImageDetailViewModel()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.dataSource = { [weak self] (nasaObj, image) in
            guard let nasaModel = nasaObj,
                  let downloadedImage = image else {
                return
            }
            self?.descriptionLabel?.text = nasaModel.explanation
            self?.title = nasaModel.title
            self?.photoImageView?.image = downloadedImage
        }
    }

}

