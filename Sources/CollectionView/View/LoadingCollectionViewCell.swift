//
//  LoadingCollectionViewCell.swift
//  CoreList
//
//  Created by Robert on 3/27/17.
//  Copyright © 2017 Robert Nguyen. All rights reserved.
//

import UIKit

public class LoadingCollectionViewCell: UICollectionViewCell, LoadingAnimatable {
    lazy var activityView = UIActivityIndicatorView()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    public func startAnimation() {
        activityView.startAnimating()
    }

    public func stopAnimation() {
        activityView.stopAnimating()
    }

    private func commonInit() {
        activityView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(activityView)
        NSLayoutConstraint.activate([
            activityView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            activityView.topAnchor.constraint(equalTo: contentView.topAnchor),
            activityView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            activityView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
