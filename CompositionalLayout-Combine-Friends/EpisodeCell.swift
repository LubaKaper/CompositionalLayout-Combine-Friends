//
//  EpisodeCell.swift
//  CompositionalLayout-Combine-Friends
//
//  Created by Liubov Kaper  on 8/25/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

class EpisodeCell: UICollectionViewCell {
    
    static let reuseIdentifier = "imageCell"
    
    public lazy var imageView: UIImageView = {
      let iv = UIImageView()
      iv.image = UIImage(systemName: "photo")
      iv.layer.cornerRadius = 8
      iv.clipsToBounds = true
      return iv
    }()
    
    public lazy var summaryTextView: UITextView = {
        let tv = UITextView()
        tv.text = "summary"
        tv.isScrollEnabled = true
        return tv
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
      imageViewConstraints()
        textViewConstraints()
    }
    
    private func imageViewConstraints() {
      addSubview(imageView)
      imageView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        imageView.topAnchor.constraint(equalTo: topAnchor),
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
        //imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
      ])
    }
    private func textViewConstraints() {
        addSubview(summaryTextView)
        summaryTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            summaryTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            summaryTextView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 3),
            summaryTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            summaryTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2)
        ])
    }
}
