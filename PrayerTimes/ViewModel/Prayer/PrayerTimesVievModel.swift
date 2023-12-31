//
//  PrayerTimesVievModel.swift
//  PrayerTimes
//
//  Created by Safa on 2.12.2023.
//

import Foundation


class PrayerTimesViewModel : ObservableObject{
    
    //to use only one PrayerListView for both cities and countries, we used [Any] type and if-statements to specify the views
    @Published var cities : [Any] = []
    
    //API only support Turkey, added a list view in case of more countries datas is will be added in future
    @Published var countries : [Any] = ["Turkiye"]
    

    func getCities() async throws{
        
        if let path = Bundle.main.path(forResource: "citie", ofType: "json") {

            guard let url = URL(fileURLWithPath: path) as? URL else {
                throw ErrorType.pathError
            }
            
            guard let data = try? Data(contentsOf: url) else {
                throw ErrorType.invalidData
            }

            do {
                let result = try JSONDecoder().decode(Cities.self, from: data)
                //send ui changes to main thread
                await MainActor.run {
                    self.cities = result.city
                }
            } catch {
                throw ErrorType.invalidJSONParse
            }
        }
                
    }
    
    
}
    
    
    
    

