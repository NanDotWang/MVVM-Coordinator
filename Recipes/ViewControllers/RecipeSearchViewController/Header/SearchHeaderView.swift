//
//  SearchHeaderView.swift
//  Recipes
//
//  Created by Nan Wang on 2018-06-23.
//  Copyright © 2018 Nan. All rights reserved.
//

import UIKit

class SearchHeaderView: UIView {
    
    enum Option: String {
        case topTrending = "Top trending 🚀"
        case searchResults = "Search results:"
    }
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.backgroundColor = .white
        return label
    }()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 70))
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHeader(_ option: Option) {
        self.headerLabel.text = option.rawValue
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(headerLabel, constraints: [
            headerLabel.heightAnchor.constraint(equalToConstant: 40),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
    }
}
