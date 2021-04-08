//
//  Providable.swift
//  NasaImages
//
//  Created by Shivam Gaur (BLR GSS) on 08/04/21.
//

import UIKit

protocol Providable {
    func get<T: Codable>(with params: JSONDictionary, _ type: T.Type, completion: @escaping (T?, NetworkError?) -> Void)
    func getImage(_ identifier: String, completion: @escaping (UIImage?) -> Void)
}
