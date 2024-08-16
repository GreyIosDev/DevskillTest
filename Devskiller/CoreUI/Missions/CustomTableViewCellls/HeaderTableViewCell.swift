//
//  HeaderTableViewCell.swift
//  Devskiller
//
//  Created by Grey on 09.08.2024.
//  Copyright © 2024 Mindera. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    weak var delegate: HeaderTableViewCellProtocol?
    
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .systemBackground
        setupButton()
        updateAppearanceForCurrentTraitCollection()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateAppearanceForCurrentTraitCollection()
        }
    }
    
    private func setupButton() {
        button.setTitle("", for: .normal)
        button.layer.borderWidth = 4
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.label.cgColor
        if let image = UIImage(named: "funnel")?.withRenderingMode(.alwaysTemplate) {
            button.setImage(image, for: .normal)
        }
        button.tintColor = UIColor.label
    }
    
    private func updateAppearanceForCurrentTraitCollection() {
        button.layer.borderColor = UIColor.label.cgColor
        if let image = button.imageView?.image {
            button.setImage(image.withTintColor(UIColor.label), for: .normal)
        }
    }
    
    @IBAction func didTapFilter(_ sender: Any) {
        delegate?.didTap()
    }
}
