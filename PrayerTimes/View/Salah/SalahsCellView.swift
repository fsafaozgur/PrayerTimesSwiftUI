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
            
            Text(salah.vakit)
                .font(.headline)
                .padding(.horizontal)
            Spacer()
            
            Text(salah.saat)
                .padding()
                .font(.headline)

        }
        .foregroundColor(.white)
        .frame(width: UIScreen.main.bounds.width * 0.8)
        .border(Color.gray, width: 1)
    }
}

struct TimeCellView_Previews: PreviewProvider {
    static var previews: some View {
        SalahsCellView(salah: Salah(saat: "test", vakit: "test"))
    }
}
