//
//  MissionsVC+Cells.swift
//  Devskiller
//
//  Created by Grey  on 15.08.2024.
//  Copyright © 2024 Mindera. All rights reserved.
//

import Foundation
import UIKit

extension MissionsViewController {
    
    // Configures the company information cell.
    func configureCompanyCell(_ cell: UITableViewCell) {
        cell.textLabel?.numberOfLines = 0
        guard let companyViewModel = companyViewModel else { return }
        cell.textLabel?.text = """
        \(companyViewModel.name) was founded by \(companyViewModel.founder) in \(companyViewModel.founded).
        It has now \(companyViewModel.employees) employees, \(companyViewModel.launchSites) launch sites, and is valued at USD \(companyViewModel.valuation).
        """
        cell.textLabel?.textColor = .label
    }
    
    // Configures the mission cell.
    func configureMissionCell(_ cell: MissionsTableViewCell, for index: Int) {
        let mission = dataViewModel[index]
        cell.missionLabel.text = mission.name
        cell.dateTimeLabel.text = mission.dateUTC
        cell.rocketLabel.text = mission.rocket
        cell.rocketImage.sd_setImage(with: URL(string: mission.links.patch?.small ?? ""))
        cell.dateLaunchLabel.text = "\(Date().timeIntervalSince1970) - \(mission.datePrecision)"
        
        let config = UIImage.SymbolConfiguration(pointSize: 5, weight: .regular)
        let successImage = UIImage(systemName: "checkmark", withConfiguration: config)?.withTintColor(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor.green : UIColor.black
        }, renderingMode: .alwaysOriginal)
        
        let failureImage = UIImage(systemName: "xmark", withConfiguration: config)?.withTintColor(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor.red : UIColor.black
        }, renderingMode: .alwaysOriginal)
        
        cell.checkImageLabel.image = mission.success ?? false ? successImage : failureImage
        
        // Set text color to adapt to light and dark modes.
        cell.missionLabel.textColor = .label
        cell.dateTimeLabel.textColor = .label
        cell.rocketLabel.textColor = .label
        cell.dateLaunchLabel.textColor = .label
    }
    
    // Presents an action sheet to filter missions by ascending or descending order.
    func filterButtonTapped() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: LaunchOrder.ascending.value, style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.sortByOrder(.ascending)
        })
        
        alertController.addAction(UIAlertAction(title: LaunchOrder.descending.value, style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.sortByOrder(.descending)
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
}
