//
//  PrayerTimesApp.swift
//  PrayerTimes
//
//  Created by Safa on 30.11.2023.
//

import SwiftUI

@main
struct PrayerTimesApp: App {
    
    var viewModel : SalahsViewModel = SalahsViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
