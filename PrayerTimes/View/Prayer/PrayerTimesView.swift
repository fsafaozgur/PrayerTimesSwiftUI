//
//  PrayerTimesView.swift
//  PrayerTimes
//
//  Created by Safa on 30.11.2023.
//

import SwiftUI

struct PrayerTimesView: View {
    
    @EnvironmentObject var salahViewModel : SalahsViewModel
    @StateObject var viewModel : PrayerTimesViewModel = PrayerTimesViewModel()
    @AppStorage("city") var selectedCity : String?
    @AppStorage("country") var selectedCountry : String?
    @State var isCountrySelected : Bool = false
    @State var isCitySelected : Bool = false
    @Binding var selectedItem : Int
    
    //to show ProgressView() until all datas being fetched from server, we used this flag
    @State var onProgress : Bool = false


    
    var body: some View {
    
        NavigationView {
        
            VStack(){

                Spacer(minLength: UIScreen.main.bounds.height * 0.1)

                
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
                    
                    PrayerTimesCellView(head: "Country:", description: selectedCountry ?? "Turkiye", didSelected: {
                        isCountrySelected = true

                    }).sheet(isPresented: $isCountrySelected) {
                        CellListView(itemArray: $viewModel.countries, isShown: $isCountrySelected) { item in
                            selectedCountry = item
                        }
                    }
                    
                    
                    PrayerTimesCellView(head: "City:", description: selectedCity ?? "Ankara", didSelected: {
                           isCitySelected = true
                    })
                    .sheet(isPresented: $isCitySelected) {
                        CellListView(itemArray: $viewModel.cities, isShown: $isCitySelected) { item in
                            selectedCity = item
                        }
                    }
                    
      
                }.padding(.vertical)
                
                
                Button(action: {
                            
                    Task{
                        try await salahViewModel.fetchTimesAsync(selectedCity ?? "Ankara")
                        selectedItem = 1
                    }

                }, label: {
                    Text("Apply")
                })
                .frame(width: 90, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .background(Color(.blue))
                .font(.title2)
                
                Spacer()
                
            }
            .frame(width: UIScreen.main.bounds.width)
            .background(Color(.systemGreen))
            .onAppear(perform: {
                Task{
                    do{
                        try await viewModel.getCities()
                    }catch(let error){
                        if let error = error as? ErrorType {
                            //for now, not need to handle error, if we want, we can do it like SalahViewModel
                            print(error.description)
                        }
                    }
                }
                    
            })
        }
    } 
}

/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            PrayerTimesView()
                .previewDevice("iphone 11")
                .previewDisplayName("iPhone 11")
            PrayerTimesView()
                .previewDevice("iPhone SE")
                .previewDisplayName("iPhone SE")
            
        }
        
    }
}*/
