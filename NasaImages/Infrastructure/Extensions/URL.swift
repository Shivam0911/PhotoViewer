//
//  URL.swift
//  NasaImages
//
//  Created by Shivam Gaur (BLR GSS) on 08/04/21.
//

import Foundation

extension URL {
    
    /// returns URL if is sucessfully parsed as URL other wise nil
    ///
    /// - Returns: URL(Optional)
    
    func getApiRequestURL(with params: JSONDictionary) -> URL? {
    
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return nil
        }
        let queryItems = params.map {
            return URLQueryItem(name: "\($0)", value: "\($1)")
        }
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
    
}
