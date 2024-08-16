//
//  CompanyNetworkProtocol.swift
//  Devskiller
//
//  Created by Grey  on 14.08.2024.
//  Copyright © 2024 Mindera. All rights reserved.
//

import Foundation

protocol CompanyNetworkServiceProtocol: AnyObject {
    func fetchCompanyData(completion: @escaping (Result<CompanyModel, Error>) -> Void)
    func fetchCompanyLanchDatas(completion: @escaping (Result<[WelcomeElement], Error>) -> Void)
}
