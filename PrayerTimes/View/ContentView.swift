//
//  ContentView.swift
//  PrayerTimes
//
//  Created by Safa on 12.12.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var selection : Int = 1
    @State var onProgress : Bool = true
    
    var body: some View {
        TabView(selection: $selection){
            SalahsView(onProgress: $onProgress)
                .tabItem {
                    Label("Prayers", systemImage: "1.circle")
                }
                .tag(1)
            
            PrayerTimesView(selectedItem: $selection)
                .tabItem {
                    Label("Settings", systemImage: "2.circle")
                }
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
