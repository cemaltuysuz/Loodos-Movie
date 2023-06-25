//
//  ImageLoader.swift
//  Loodos-Movie
//
//  Created by cemal tüysüz on 24.06.2023.
//

import UIKit
import Kingfisher

public class ImageLoader{

    static func load(from urlString: String?, completion: @escaping ((UIImage?) -> Void)) {
        guard
            let urlString = urlString,
            let url = URL.init(string: urlString)
        else {
            print("------| Invalid image url format : \(urlString) |----------")
            completion(nil)
            return
         }
         let resource = ImageResource(downloadURL: url)
        
         KingfisherManager.shared.retrieveImage(with: resource,
                                                options: [
                                                    .cacheOriginalImage
                                                ],
                                                progressBlock: nil) { result in
             switch result {
             case .success(let value):
                 return completion(value.image)
             case .failure(let error):
                 print("------| Error received while retrieving image from url: \(error.localizedDescription) |----------")
                 completion(nil)
             }
         }
    }
}
