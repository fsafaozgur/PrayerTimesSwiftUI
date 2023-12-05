//
//  SalahViewModelTests.swift
//  SalahViewModelTests
//
//  Created by Safa on 3.12.2023.
//

import XCTest
@testable import PrayerTimes
import Combine

class SalahViewModelTests: XCTestCase {
    
    var salahsTimesVievModel : SalahsViewModel!
    var salahs : [Salah]?
    private var cancellable : Set<AnyCancellable>!
    

    override func setUp()  {
        super.setUp()
        salahsTimesVievModel = SalahsViewModel(service: MockWebService())
        cancellable = []
    }
    
    override func tearDown() {
        super.tearDown()
        salahsTimesVievModel = nil
        cancellable = []
    }
    
    
    func testFetchTimesAsyncSuccessfully() throws {
        
        let expectation  = XCTestExpectation(description: "data fetching")
        
        Task{
            try await salahsTimesVievModel.fetchTimesAsync("AnyCity")
            expectation.fulfill()
        }
 
        //wait expetation to be fulfilled
        wait(for: [expectation], timeout: 2)
        
        //testing whether 6 object are being fetched or not when we try to read datas from Salah.json file that includes 6 datas
        XCTAssertEqual(self.salahsTimesVievModel.result?.count, 6)
        
    }
    
    
    
    //Another method for testing FetchTimesAsync method using Combine
    func testAnotherFetchTimesAsyncSuccessfully() async throws {
        
        let expectation  = XCTestExpectation(description: "data fetching")
      
        try await salahsTimesVievModel.fetchTimesAsync("AnyCity")
        
        salahsTimesVievModel.$result
            .sink { value in
                XCTAssertEqual(value?.count, 6)
                expectation.fulfill()
            }
            .store(in: &cancellable)
            

        //wait expetation to be fulfilled
        wait(for: [expectation], timeout: 2)


    }
    
    
    
  
    func testTrToEngSuccessfully() throws {

            XCTAssertEqual(self.salahsTimesVievModel.trToEng(string: "Gümüşhane"), "gumushane")
            
    }
    
    
    
    
    //In case of use completititon method to fetch data, test was added
    func testFetchTimesSuccessfully() throws {
        
        salahsTimesVievModel.fetchTimes("AnyCity") { result in
            
                switch result {
                    case .success(let salahs):
                        //load datas
                        self.salahs = salahs
                        
                    case .failure(let error):
                        print(error.description)
                    default:
                        print("default")
                }
            
            //testing whether 6 object are being fetched or not when we try to read datas from Salah.json file that includes 6 datas
            XCTAssertEqual(self.salahs?.count, 6)
        }
        
    }
    
    
    
}

    


