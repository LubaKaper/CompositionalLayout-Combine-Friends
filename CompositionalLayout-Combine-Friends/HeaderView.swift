//
//  HeaderView.swift
//  CompositionalLayout-Combine-Friends
//
//  Created by Liubov Kaper  on 8/25/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
        static let reuseIdentifier = "headerView"
        
        public lazy var imageView: UIImageView = {
          let iv = UIImageView()
          iv.image = UIImage(systemName: "photo")
          iv.layer.cornerRadius = 8
          iv.clipsToBounds = true
          return iv
        }()
        
        override init(frame: CGRect) {
          super.init(frame: frame)
          commonInit()
        }
        
        required init?(coder: NSCoder) {
          super.init(coder: coder)
          commonInit()
        }
        
        private func commonInit() {
          setupImageConstraints()
        }
        
        private func setupImageConstraints() {
          addSubview(imageView)
          imageView.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
          ])
        }
}
