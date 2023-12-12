//
//  PrayerTimesCellView.swift
//  PrayerTimes
//
//  Created by Safa on 30.11.2023.
//

import SwiftUI

struct PrayerTimesCellView: View {
    
    var head : String
    var description : String?
    var didSelected : () -> Void
    
    var body: some View {
        
  
        VStack(alignment: .leading){
            
            Text(head)
                .font(.headline)

            
            Text(description ?? "Please select")
                .padding()
                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.05, alignment: .leading)
                .background(Color(.systemGray5))


        
        }.onTapGesture {
            didSelected()
        }

        
    }
}

/*
struct ContentListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentListView(head: "deneme", description: "denemebirki") {}
    }
}*/
