//
//  ListView.swift
//  PrayerTimes
//
//  Created by Safa on 30.11.2023.
//

import SwiftUI

struct CellListView: View {
    
    @Binding var itemArray : [Any]
    @Binding var isShown : Bool
    var selectedItem : (_ selectedItem: String) -> Void

    
    var body: some View {
        
        if let itemArray = itemArray as? [City] {
            
            List(itemArray, id: \.self){ item in

                Text(item.name)
                        .font(.subheadline)
                        .onTapGesture {
                            selectedItem(String(item.name))
                            isShown = false
                        }

            }
        }
        
        
        if let itemArray = itemArray as? [String] {
            
            List(itemArray, id: \.self){ item in

                Text(item)
                        .font(.subheadline)
                        .onTapGesture {
                            selectedItem(item)
                            isShown = false
                        }

            }
        }

                
                
 
        
        
    }
}

/*
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(itemArray: ["coun1", "coun2", "coun3"] ) { item in
        }
    }
}*/
