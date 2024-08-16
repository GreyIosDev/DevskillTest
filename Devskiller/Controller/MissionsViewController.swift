//
//  ViewController.swift
//  Devskiller
//
//  Copyright © 2023 Mindera. All rights reserved.
//

import UIKit
import SDWebImage

// view controller that displays mission data.
final class MissionsViewController: UIViewController, HeaderTableViewCellProtocol {
    
    // Network service to fetch company and mission data.
    private let companyModel: CompanyNetworkServiceProtocol
    
    // View model to hold fetched company data.
    var companyViewModel: CompanyModel?
    
    // View model to hold fetched mission data.
    var dataViewModel: [WelcomeElement] = []
    
    // Lazy-loaded table view for displaying sections of data.
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        // Registers table view cells with different identifiers.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(UINib(nibName: "MissionsTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell1")
        tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell2")
        tableView.delegate = self
        tableView.backgroundColor = .systemBackground
        tableView.dataSource = self
        return tableView
    }()
    
    init(companyModel: CompanyNetworkServiceProtocol, companyViewModel: CompanyModel? = nil) {
        self.companyModel = companyModel
        self.companyViewModel = companyViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Called when the view is loaded; sets up the view and fetches data.
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchData()
    }
    
    // Adds the table view to the main view hierarchy.
    private func setupView() {
        view.addSubview(tableView)
    }
    
    // Lays out the subviews, setting the table view to fill the screen.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // Fetches company and mission data asynchronously.
    func fetchData() {
        let dispatchGroup = DispatchGroup()
        
        // Fetches company data and stores it in the view model.
        dispatchGroup.enter()
        companyModel.fetchCompanyData { [weak self] response in
            defer { dispatchGroup.leave() }
            if case let .success(companyData) = response {
                self?.companyViewModel = companyData
            }
        }
        
        // Fetches mission data and stores it in the view model.
        dispatchGroup.enter()
        companyModel.fetchCompanyLanchDatas { [weak self] response in
            defer { dispatchGroup.leave() }
            if case let .success(launchData) = response {
                self?.dataViewModel = launchData
            }
        }
        
        // Reloads the table view once all data has been fetched.
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// Extension to handle table view delegate and data source methods.
extension MissionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Only handle selection in the third section (missions section)
        if indexPath.section == 2 {
            // Get the mission link from the data model
            if let missionLink = dataViewModel[indexPath.row].links.wikipedia,
               let url = URL(string: missionLink) {
                // Attempt to open the URL in the default browser
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                let alertController = UIAlertController(title: "Link Unavailable",
                                                        message: "There is no external link available for this mission.",
                                                        preferredStyle: .alert)
                
                //OK button to dismiss the alert
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                
                // Displays alert to the user
                if let topController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController {
                    var topViewController = topController
                    while let presentedViewController = topViewController.presentedViewController {
                        topViewController = presentedViewController
                    }
                    topViewController.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    // Returns the number of rows for each section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return dataViewModel.count
        }
        return 0
    }
    
    // Configures and returns the appropriate cell for each row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as? HeaderTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.selectionStyle = .none
            
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            configureCompanyCell(cell)
            cell.selectionStyle = .none
            
            return cell
        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as? MissionsTableViewCell else {
                return UITableViewCell()
            }
            configureMissionCell(cell, for: indexPath.row)
            
            return cell
        }
        return UITableViewCell()
    }
    
    // Returns the header view for each section.
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel()
        headerLabel.backgroundColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
        }
        headerLabel.textColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor.black : UIColor.white
        }
        headerLabel.font = UIFont.boldSystemFont(ofSize: 24)
        headerLabel.textAlignment = .left
        headerLabel.text = section == 1 ? " COMPANY" : " LAUNCHES"
        
        return headerLabel
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return UITableView.automaticDimension
        }
    }
    
    // Returns the height for each row in the table view.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        } else {
            return 150
        }
    }
    
    // Activated when the header cell is tapped
    func didTap() {
        filterButtonTapped()
    }
    // This will handle sorting the mission data by the selected order and reloads the table view.
    func sortByOrder(_ order: LaunchOrder) {
        switch order {
        case .ascending:
            dataViewModel.sort { $0.dateUTC < $1.dateUTC }
        case .descending:
            dataViewModel.sort { $0.dateUTC > $1.dateUTC }
        }
        tableView.reloadData()
    }
}
