//
//  LoadingTableViewCell.swift
//  CoreList
//
//  Created by Robert on 2/12/17.
//  Copyright © 2017 Robert Nguyen. All rights reserved.
//

import UIKit

public class LoadingTableViewCell: UITableViewCell, LoadingAnimatable {
    private lazy var activityView = UIActivityIndicatorView()

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
