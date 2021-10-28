//
//  GFAvatarImageView.swift
//  Github Followers
//
//  Created by Abdirizak Hassan on 10/27/21.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placehorderImage = UIImage(named: "avatar-placeholder")
    
    
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
    
    func dowloadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.image = image
            }
            
        }.resume()
    }
    
    
}
