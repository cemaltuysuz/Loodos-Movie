//
//  ImageLoader.swift
//  Loodos-Movie
//
//  Created by cemal tüysüz on 24.06.2023.
//

import UIKit

public class ImageLoader{
    
    static func load(name: String) -> UIImage? {
        if #available(iOS 13.0, *) {
            return UIImage.init(systemName: name)
        } else {
            return UIImage.init(named: name)
        }
    }
    
    static func load(from urlString: String?, completionHandler: @escaping((UIImage?)->Void)) {
        guard
            let urlString = urlString,
            let url = URL(string: urlString)
        else {
            print("invalid image url : \(urlString ?? "")")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {
                return completionHandler(nil)
            }
            completionHandler(image)
        }
        .resume()
    }
}
