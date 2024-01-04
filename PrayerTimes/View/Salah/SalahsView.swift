//
//  SalahsView.swift
//  PrayerTimes
//
//  Created by Safa on 30.11.2023.
//

import SwiftUI


struct SalahsView: View {

    
    @EnvironmentObject var viewModel : SalahsViewModel
    @AppStorage("city") var city : String?
    @AppStorage("country") var country : String?
    @Binding var onProgress : Bool
    @State var showError : Bool = false
    @State var errorMessage : String?
    @State var timeToSalah : String?

    
        var body: some View {
            
            VStack{
                
                if onProgress {
                    ProgressView()
                }
                else
                {
                    VStack(){
                        
                        Spacer()
                        
                        Text("\(country ?? "Turkiye"), \(city ?? "Ankara")")
                            .foregroundColor(.black)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .padding(.top)
                        
                        Text(viewModel.date ?? "Unknown")
                            .foregroundColor(.black)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .padding(.bottom)
                        
                        Text(viewModel.nextSalah ?? "Last Salah has passed")
                            .foregroundColor(.black)
                            .font(.system(size: 20))

                        Text(timeToSalah ?? " ")
                            .onReceive(viewModel.timer) { _ in

                                if viewModel.remainingSec != 0 {
                                    viewModel.remainingSec -= 1
                                    
                                    let sec = viewModel.remainingSec
                                    timeToSalah =  (Int(sec / 3600) == 0 ? "" : "\(Int(sec / 3600)) hour ") +
                                    (Int(sec / 60) % 60 == 0 ? "" : "\(Int(sec / 60) % 60) minutes ") +
                                     "\(sec % 60) seconds"

                                }else {
                                    viewModel.calculateTimeToSalah()
                                }
                            }
                            .font(.system(size: 25))


                        VStack{
                            ForEach(viewModel.result ?? [], id: \.self) { salah in
                                SalahsCellView(salah: salah)
                                
                            }
                        }
                        
                        Spacer()
                        
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .background(Color.backgroundSalahView)
                    
                }
   
            }
            .onAppear(perform: {

                Task{
                    //Fetch datas using async method
                    try await viewModel.fetchTimesAsync(city ?? "Ankara")
                    //Error check
                    if let _ = viewModel.error {
                        self.showError = true
                    }
                    //dismiss ProgressView()
                    self.onProgress = false
                }
                

                    
                /*In case of using fetching data using completition method*/
                /*
                viewModel.fetchTimes(city) { timeResult in
                        
                    switch timeResult {
                        case .success(let salahs):
                            //load datas
                            self?.salahs = salahs
                            //dismiss ProgressView()
                            self.onProgress = false
                            
                                
                        case .failure(let error):
                            //load error message
                            self.errorMessage = error.description
                            //present message
                            self.showError = true
                            //dismiss ProgressView()
                            self.onProgress = false
                            
                        default:
                            print("default")
                    
                 }*/
                 
        
            })
            .alert(isPresented: $showError) {
                Alert(title: Text("Error!"), message: Text(self.viewModel.error?.description ?? "Some Error"), dismissButton: .default(Text("OK")))
            }
                
        }
        

    
}
/*
struct TimesView_Previews: PreviewProvider {
    static var previews: some View {
        SalahsView(city: "test", country: "test", onProgress: false)
    }
}*/
