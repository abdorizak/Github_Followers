//
//  GFAvatarImageView.swift
//  Github Followers
//
//  Created by Abdirizak Hassan on 10/27/21.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let cache = NetworkManger.shared.cache
    let placehorderImage = Images.placeholderImage 
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placehorderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(fromURL url: String ) {
        NetworkManger.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
