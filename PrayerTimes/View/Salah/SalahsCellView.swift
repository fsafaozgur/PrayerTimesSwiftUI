//
//  SalahsCellView.swift
//  PrayerTimes
//
//  Created by Safa on 30.11.2023.
//

import SwiftUI

struct SalahsCellView: View {
    
    @State var salah : Salah
    
    
    var body: some View {
        HStack {
            
            Text(salah.salah)
                .font(.title)
                .padding(.horizontal)
            Spacer()
            
            Text(salah.time)
                .padding()
                .font(.title)

        }
        .foregroundColor(.white)
        .frame(width: UIScreen.main.bounds.width * 0.8)
        .border(Color.gray, width: 1)
    }
}

struct TimeCellView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            SalahsCellView(salah: Salah(time: "test", salah: "test"))
                .previewLayout(.sizeThatFits)
                .previewDevice("iphone 11")
                .previewDisplayName("iPhone 11")
            SalahsCellView(salah: Salah(time: "test", salah: "test"))
                .previewLayout(.sizeThatFits)
                .previewDevice("iphone 8")
                .previewDisplayName("iPhone 8")
            
        }
    }
}
