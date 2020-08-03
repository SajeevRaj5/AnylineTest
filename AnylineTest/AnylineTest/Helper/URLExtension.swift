//
//  URLExtension.swift
//  AnylineTest
//
//  Created by sajeev Raj on 04/08/2020.
//  Copyright © 2020 AnylineTest. All rights reserved.
//

import UIKit

extension URL {
    func image(completion: @escaping (UIImage, Data) -> Void) {
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: self)
            if let imageData = data, let image = UIImage(data:imageData) {
                completion(image, imageData)
            }
        }
    }
}
