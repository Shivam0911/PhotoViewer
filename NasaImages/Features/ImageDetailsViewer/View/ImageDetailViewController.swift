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
        viewModel?.showingLastImageCallback = { [weak self] in
            let alertMsg = "Alert"
            let messgage = "We are not connected to the internet, showing you the last image we have."
            let messageVC = UIAlertController(title: alertMsg,
                                              message: messgage ,
                                              preferredStyle: .alert)
            self?.present(messageVC, animated: true) {
                Timer.scheduledTimer(withTimeInterval: 1,
                                     repeats: false,
                                     block: { (_) in
                                        messageVC.dismiss(animated: true, completion: nil)})
                
            }
            
        }
    }

}

