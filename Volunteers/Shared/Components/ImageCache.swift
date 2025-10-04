//
//  ImageCache.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI
import UIKit

class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {
        cache.countLimit = 100
        cache.totalCostLimit = 50 * 1024 * 1024
    }
    
    func get(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func set(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func remove(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
    func clear() {
        cache.removeAllObjects()
    }
}

struct CacheImage<Placeholder: View>: View {
    let urlString: String
    let contentMode: ContentMode
    let aspectRatio: CGFloat?
    @ViewBuilder let placeholder: () -> Placeholder
    
    @State private var image: UIImage?
    @State private var isLoading = false
    @State private var error: Error?
    
    init(
        _ urlString: String,
        contentMode: ContentMode = .fit,
        aspectRatio: CGFloat? = nil,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        self.urlString = urlString
        self.contentMode = contentMode
        self.aspectRatio = aspectRatio
        self.placeholder = placeholder
    }
    
    var body: some View {
        Group {
            if let image = image {
                imageView(Image(uiImage: image))
            } else if isLoading {
                CircleLoader(size: 20, color: .white)
            } else if let _ = error {
                placeholderView(placeholder)
            } else {
                placeholderView(placeholder)
                    .onAppear {
                        loadImage()
                    }
            }
        }
    }
    
    private func imageView(_ image: Image) -> some View {
        if let aspectRatio = aspectRatio {
            image
                .resizable()
                .aspectRatio(aspectRatio, contentMode: contentMode)
                .clipped()
        } else {
            image
                .resizable()
                .aspectRatio(contentMode: contentMode)
                .clipped()
        }
    }
    
    private func placeholderView(_ placeholder: () -> Placeholder) -> some View {
        if let aspectRatio = aspectRatio {
            placeholder()
                .frame(maxWidth: .infinity)
                .aspectRatio(aspectRatio, contentMode: contentMode)
        } else {
            placeholder()
                .frame(maxWidth: .infinity)
                .aspectRatio(contentMode: contentMode)
        }
    }
    
    private func loadImage() {
        if let cachedImage = ImageCache.shared.get(forKey: urlString) {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else {
            self.error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            return
        }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                
                if let error = error {
                    self.error = error
                    return
                }
                
                guard let data = data, let downloadedImage = UIImage(data: data) else {
                    self.error = NSError(domain: "Invalid image data", code: 0, userInfo: nil)
                    return
                }
                
                ImageCache.shared.set(downloadedImage, forKey: urlString)
                self.image = downloadedImage
            }
        }
        .resume()
    }
}

struct CacheImageAsync: View {
    let urlString: String
    let placeholder: Image
    let contentMode: ContentMode
    let aspectRatio: CGFloat?
    
    @State private var cachedImage: UIImage?
    
    init(
        _ urlString: String,
        placeholder: Image = Image(systemName: "photo"),
        contentMode: ContentMode = .fit,
        aspectRatio: CGFloat? = nil
    ) {
        self.urlString = urlString
        self.placeholder = placeholder
        self.contentMode = contentMode
        self.aspectRatio = aspectRatio
    }
    
    var body: some View {
        Group {
            if let cachedImage = cachedImage {
                imageView(Image(uiImage: cachedImage))
            } else {
                AsyncImage(url: URL(string: urlString)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .scaleEffect(0.8)
                    case .success(let image):
                        imageView(image)
                            .onAppear {
                                cacheImage(from: phase)
                            }
                    case .failure:
                        placeholderView(placeholder)
                    @unknown default:
                        placeholderView(placeholder)
                    }
                }
            }
        }
        .onAppear {
            if let cached = ImageCache.shared.get(forKey: urlString) {
                cachedImage = cached
            }
        }
    }
    
    private func imageView(_ image: Image) -> some View {
        if let aspectRatio = aspectRatio {
            image
                .resizable()
                .aspectRatio(aspectRatio, contentMode: contentMode)
                .clipped()
        } else {
            image
                .resizable()
                .aspectRatio(contentMode: contentMode)
                .clipped()
        }
    }
    
    private func placeholderView(_ placeholder: Image) -> some View {
        if let aspectRatio = aspectRatio {
            placeholder
                .resizable()
                .aspectRatio(aspectRatio, contentMode: contentMode)
                .clipped()
        } else {
            placeholder
                .resizable()
                .aspectRatio(contentMode: contentMode)
                .clipped()
        }
    }
    
    private func cacheImage(from phase: AsyncImagePhase) {
        guard case .success(let image) = phase else { return }
        
        let renderer = ImageRenderer(content: image)
        if let uiImage = renderer.uiImage {
            ImageCache.shared.set(uiImage, forKey: urlString)
        }
    }
}
