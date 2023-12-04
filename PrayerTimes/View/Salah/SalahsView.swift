//
//  SalahsView.swift
//  PrayerTimes
//
//  Created by Safa on 30.11.2023.
//

import SwiftUI


struct SalahsView: View {

    
    @ObservedObject var viewModel : SalahsViewModel = SalahsViewModel(service: WebService())
    @State var city : String
    @State var country : String
    @Binding var onProgress : Bool
    @State var showError : Bool = true
    @State var errorMessage : String?

    
        var body: some View {
            
            VStack{
                
                if onProgress {
                    ProgressView()
                }
                else
                {
                    VStack(){
                        
                        Spacer(minLength: UIScreen.main.bounds.height * 0.1)
                        
                        Image("TitleImage")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .overlay(
                                Text("PRAYER TIMES")
                                    .padding()
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                                    .offset(y: UIScreen.main.bounds.height * -0.08)
                            )
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.2, alignment: .bottom)
                        
                        
                        Text("\(country), \(city)")
                            .foregroundColor(.black)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        
                        Text(TimeFormat.fetchTime())
                            .foregroundColor(.black)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .padding()
                        

                        VStack{
                            ForEach(viewModel.result ?? [], id: \.self) { salah in
                                SalahsCellView(salah: salah)
                                
                            }
                        }
                        //.frame(height: UIScreen.main.bounds.height * 0.36)
                        
                        Spacer()
                        
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .edgesIgnoringSafeArea(.all)
                    .background(Color(.systemGreen))

                }
            }
            .onAppear(perform: {
                    
                Task{
                    //Fetch datas using async method
                    try await viewModel.fetchTimes(city)
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
                            self.salahs = salahs
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
                     }
                 }
                 */
        
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
