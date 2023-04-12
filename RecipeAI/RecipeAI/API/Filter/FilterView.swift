//
//  FilterView.swift
//  RecipeAI
//
//  Created by Roy Braks on 06/04/2023.
//

import Foundation
import SwiftUI

struct FilterView: View {
    @ObservedObject var filterViewModel = FilterViewModel()
        
    let layout = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {

        VStack{
            VStack(alignment: .leading){
                Text("Diet")
                    .font(.title2)
                    .fontWeight(.bold)
                LazyVGrid(columns: layout) {
                    ForEach(filterViewModel.dietTypes.indices) { filter in
                            
                            if (!(filterViewModel.dietTypesBool[filter])) {
                                
                                Button(filterViewModel.dietTypes[filter]) {
                                    filterViewModel.dietTypesBool[filter] = true
                                    UserDefaults.standard.set(filterViewModel.dietTypesBool, forKey: "filterDiet")
                                    print(filterViewModel.dietTypesBool)

                                }
                                .multilineTextAlignment(.center)
                                .buttonStyle(.bordered)
                                .foregroundColor(Color.black)
                                
                            } else {
                                Button(filterViewModel.dietTypes[filter]) {
                                    filterViewModel.dietTypesBool[filter] = false
                                    UserDefaults.standard.set(filterViewModel.dietTypesBool, forKey: "filterDiet")
                                    print(filterViewModel.dietTypesBool)
                                }
                                .tint(Color.green)
                                .foregroundColor(Color.white)
                                .buttonStyle(.borderedProminent)

                            }
                    }
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            }
        }
        .padding()
        .navigationTitle("Filters")

    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        ExplorePage()
    }
}
