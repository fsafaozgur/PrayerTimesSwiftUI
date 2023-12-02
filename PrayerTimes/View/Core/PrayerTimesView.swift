//
//  PrayerTimesView.swift
//  PrayerTimes
//
//  Created by Safa on 30.11.2023.
//

import SwiftUI

struct PrayerTimesView: View {
    
    @State var isCountrySelected : Bool = false
    @State var isCitySelected : Bool = false
    @State var selectedCountry : String?
    @State var selectedCity : String?
    
    //to show ProgressView() until all datas being fetched from server, we used this flag
    @State var onProgress : Bool = false
    
    
    @State var isLinkActive : Bool = false
    @State var viewModel : PrayerTimesViewModel = PrayerTimesViewModel()
    
    //to use only one PrayerListView for both cities and countries, we used [Any] type and if-statements to specify the views
    @State var cities : [Any] = []
    
    //API only support Turkey, so others are dummy datas
    @State var countries : [Any] = ["Turkiye", "France", "Germany"]

    
    var body: some View {
    
        NavigationView {
        
            VStack(){

                        
                Image("TitleImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay(
                        Text("PRAYER TIMES")
                            .padding()
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 200, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                            .offset(y: UIScreen.main.bounds.height * -0.1)
                    )
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.3, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
                Text("Which location are you looking for ?")
                    .font(.headline)
                
                
                VStack(spacing: 20){
                    
                    PrayerTimesCellView(head: "Country:", description: selectedCountry, didSelected: {
                        isCountrySelected = true

                    }).sheet(isPresented: $isCountrySelected) {
                        CellListView(itemArray: $countries, isShown: $isCountrySelected) { item in
                            selectedCountry = item
                        }
                    }
                    
                    
                    PrayerTimesCellView(head: "City:", description: selectedCity, didSelected: {
                           isCitySelected = true
                    })
                    .sheet(isPresented: $isCitySelected) {
                        CellListView(itemArray: $cities, isShown: $isCitySelected) { item in
                            selectedCity = item
                        }
                    }
                    
      
                }.padding(.vertical)
                
                NavigationLink(destination: SalahsView(city: selectedCity ?? "Ankara", country: selectedCountry ?? "Turkey", onProgress: $onProgress), isActive: $isLinkActive) {
                        Button(action: {
                            self.onProgress = true
                            self.isLinkActive = true
                        }, label: {
                            Text("Apply")
                        })
                }
                .frame(width: 90, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .background(Color(.blue))
                .font(.title2)
                .sheet(isPresented: $onProgress, content: {
                    ProgressView()
                })


                Spacer()
                
            }
            .onAppear(perform: {
                viewModel.getCities() { cities in
                    if let cities = cities {
                        self.cities = cities as [Any]
                    }
                }
            })
        }
    } 
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerTimesView()
    }
}
