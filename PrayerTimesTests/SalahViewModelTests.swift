//
//  SalahViewModelTests.swift
//  SalahViewModelTests
//
//  Created by Safa on 3.12.2023.
//

import XCTest
@testable import PrayerTimes

class SalahViewModelTests: XCTestCase {
    
    var salahsTimesVievModel : SalahsViewModel!
    var salahs : [Salah]?

    override func setUp()  {
        super.setUp()
        salahsTimesVievModel = SalahsViewModel(service: MockWebService())
    }
    
    override func tearDown() {
        super.tearDown()
    }
        
        
    func testFetchTimesSuccessfully() throws {
        
        salahsTimesVievModel.fetchTimes("Ankara") { result in
            
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
    
    func testTrToEngSuccessfully() throws {
        

            //Fonksiyonumuzun Turkce karakterleri Ingilizce karakterlere basariyla cevirdigini kontrol ediyoruz
            XCTAssertEqual(self.salahsTimesVievModel.trToEng(string: "Gümüşhane"), "gumushane")
            
        }}

    


