//
//  RecipeHeaderView.swift
//  Recipes
//
//  Created by Nan Wang on 2018-06-23.
//  Copyright © 2018 Nan. All rights reserved.
//

import UIKit

class RecipeHeaderView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 2))
        
        addSubview(imageView, constraints: [
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadImage(with imageUrl: URL?, apiService: APIService) {
        
        guard let imageUrl = imageUrl else { return }
        
        apiService.load(.recipeImage(with: imageUrl)) { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let image):
                self.imageView.image = image
            case .failure(let error):
                print("⚠️ \(#function) failed with error: \(error.localizedDescription)")
            }
        }
    }
}
