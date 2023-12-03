//
//  SalahsView.swift
//  PrayerTimes
//
//  Created by Safa on 30.11.2023.
//

import SwiftUI


struct SalahsView: View {

    
    @State var viewModel = SalahsViewModel(service: WebService())
    @State var salahs : [Salah]?
    @State var city : String
    @State var country : String
    @Binding var onProgress : Bool
    @State var showError : Bool = true
    @State var errorMessage : String?

    
        var body: some View {
            
     
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
                    ForEach(salahs ?? [], id: \.self) { salah in
                        SalahsCellView(salah: salah)

                    }
                }
                .frame(height: UIScreen.main.bounds.height * 0.36)
                
                
                
                HStack{
                    
                    Spacer()
                    
                    Button(action: {
                        //This feature will be activated later
                    }, label: {
                        Text("<<Previous")
                    })
                    .frame(width: 110, height: 50, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color(.green))
                    .font(.title2)
                    .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .padding()

                    Spacer()
                    
                    
                    Button(action: {
                        //This feature will be activated later
                    }, label: {
                        Text("Next>>")
                    })
                    .frame(width: 110, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .background(Color(.green))
                    .font(.title2)
                    .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .padding()
                    
                    Spacer()
                    
                }
                .padding(.horizontal)

                Spacer()
                
                }
                .background(Color(.systemGreen))
                .edgesIgnoringSafeArea(.all)
                .onAppear(perform: {
                                    
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
        
                })
                .alert(isPresented: $showError) {
                    Alert(title: Text("Error!"), message: Text(self.errorMessage ?? "Some Error"), dismissButton: .default(Text("OK")))
                }
                
            }
        

    
}
/*
struct TimesView_Previews: PreviewProvider {
    static var previews: some View {
        SalahsView(city: "test", country: "test", onProgress: false)
    }
}*/
