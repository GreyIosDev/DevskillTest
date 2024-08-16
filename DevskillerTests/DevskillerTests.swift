//
//  DevskillerTests.swift
//  DevskillerTests
//
//  Created by Ivo Silva on 18/09/2020.
//  Copyright © 2020 Mindera. All rights reserved.
//

import XCTest
@testable import Devskiller

class DevskillerTests: XCTestCase {
    var mockOnboardingService:MockCompanyNetworkService!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockOnboardingService = MockCompanyNetworkService()
    }
    
    override func tearDownWithError() throws {
        mockOnboardingService = nil
    }
    
    func testFetchDataSuccess() throws {
        let sut = try makeSUT()
        let expectedData = try mockCompanyData()
        sut.fetchData()
        let actualData = sut.companyViewModel!.employees
        XCTAssertEqual(expectedData.employees, actualData)
    }
    
    private func makeSUT() throws -> MissionsViewController {
        let vc = MissionsViewController(companyModel: mockOnboardingService)
        return vc
    }
    
    private func mockCompanyData() throws -> CompanyModel {
        var data:CompanyModel!
        mockOnboardingService.fetchCompanyData { result in
            switch result {
            case .success(let success):
                data = success
            case .failure(let failure):
                print(failure)
            }
        }
        return data
    }
    
}

class MockCompanyNetworkService:CompanyNetworkServiceProtocol {
    func fetchCompanyData(completion: @escaping (Result<CompanyModel, any Error>) -> Void) {
        completion(.success(companyModel))
    }
    
    func fetchCompanyLanchDatas(completion: @escaping (Result<[WelcomeElement], any Error>) -> Void) {
    }
}
