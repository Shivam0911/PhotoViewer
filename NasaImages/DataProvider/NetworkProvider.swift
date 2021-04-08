//
//  NetworkProvider.swift
//  NasaImages
//
//  Created by Shivam Gaur (BLR GSS) on 08/04/21.
//

import Foundation
import UIKit
import Network

enum NetworkError {
    case notConnected
    case unknown
}

class NetworkProvider: Providable {
    
    let monitor = NWPathMonitor()
    var isConnectedToInternet: Bool = false
    let queue = DispatchQueue(label: "Internet_Monitor")

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnectedToInternet = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
    func get<T: Codable>(with params: JSONDictionary, _ type: T.Type, completion: @escaping (T?, NetworkError?) -> Void) {
        if !isConnectedToInternet {
            DispatchQueue.main.async {
                completion(nil, NetworkError.notConnected)
            }
        }
        let success = { (result: T?) in
            DispatchQueue.main.async {
                completion(result, nil)
            }
        }
        let failure = {
            DispatchQueue.main.async {
                completion(nil, .unknown)
            }
        }
        guard let url = URL(string: baseUrl+route(for: type)),
              let requestURL = url.getApiRequestURL(with: params) else {
            failure()
            return
        }
        let session = URLSession.shared
        let request = URLRequest(url: requestURL)

        let task = session.dataTask(with: request) { (data, _, _) in
            guard let data = data else {
                failure()
                return
            }
            let result = try? JSONDecoder().decode(T.self, from: data)
            success(result)
        }
        task.resume()
    }
    
    func getImage(_ identifier: String, completion: @escaping (UIImage?) -> Void) {
        let success = { (result: UIImage?) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        let failure = {
            DispatchQueue.main.async {
                completion(nil)
            }
        }
        guard let url = URL(string: identifier) else {
            failure()
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {
                failure()
                return
            }
            let image = UIImage(data: data)
            success(image)
        }
        task.resume()
    }
    
    private var baseUrl: String {
        let path = Bundle.main.path(forResource: "Endpoints", ofType: "plist") ?? ""
        let plist = NSDictionary(contentsOfFile: path)
        return plist?["BaseUrl"] as? String ?? ""
    }
    
    private func route<T: Codable>(for type: T.Type) -> String {
        switch type {
        case is NasaImage.Type:
            return "/planetary/apod"
        default:
            return ""
        }
    }
}
