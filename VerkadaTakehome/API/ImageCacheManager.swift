//
//  ImageCacheManager.swift
//  VerkadaTakehome
//
//  Created by Richie Sun on 12/9/24.
//

import Foundation
import SwiftUI

class ImageCacheManager {

    // MARK: Singleton Instance

    static let shared = ImageCacheManager()
    private let cache = NSCache<NSString, UIImage>()

    // MARK: - Init

    private init() {}

    // MARK: - Functions

    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: NSString(string: key))
    }

    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: NSString(string: key))
    }
}
