//
//  CompanyNetworkService.swift
//  Devskiller
//
//  Created by Grey  on 09.08.2024.
//  Copyright © 2024 Mindera. All rights reserved.
//

import Foundation

final class CompanyNetworkService: CompanyNetworkServiceProtocol {
    
    private let URL_COMPANY_DATA = "https://api.spacexdata.com/v4/company"
    private let URL_LAUNCH_DATA = "https://api.spacexdata.com/v4/launches"
    
    func fetchCompanyLanchDatas(completion: @escaping (Result<[WelcomeElement], Error>) -> Void) {
        DataFetcher.fetchData(from: URL_LAUNCH_DATA, completion: completion)
    }
    
    func fetchCompanyData(completion: @escaping (Result<CompanyModel, Error>) -> Void) {
        DataFetcher.fetchData(from: URL_COMPANY_DATA, completion: completion)
    }
    
}
