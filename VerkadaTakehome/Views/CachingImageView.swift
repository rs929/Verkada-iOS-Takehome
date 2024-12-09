//
//  CachingImageView.swift
//  VerkadaTakehome
//
//  Created by Richie Sun on 12/9/24.
//

import SwiftUI

struct CachingImageView: View {

    // MARK: - Properties

    @State private var image: UIImage?
    @State private var isLoading: Bool = false

    let url: URL?
    var placeholderText: String = "Image Not Available"

    // MARK: - UI

    var body: some View {
        ZStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else if isLoading {
                LoadingView()
            } else {
                Text(placeholderText)
            }
        }
        .onAppear {
            if let url {
                Task {
                    await loadImage(from: url)
                }
            }
        }
        .onChange(of: url) { _, url in
            if let url {
                Task {
                    await loadImage(from: url)
                }
            }
        }

    }

    // MARK: - Functions

    func loadImage(from url: URL) async {
        if let cachedImage = ImageCacheManager.shared.getImage(forKey: url.absoluteString) {
            image = cachedImage
            return
        }

        isLoading = true

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let downloadedImage = UIImage(data: data) else {
                isLoading = false
                return
            }

            ImageCacheManager.shared.setImage(downloadedImage, forKey: url.absoluteString)

            DispatchQueue.main.async {
                self.image = downloadedImage
                self.isLoading = false
            }
        } catch {
            NetworkManager.shared.logger.error("Error in CachingImageView.loadImage: \(error.localizedDescription)")

            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
}

