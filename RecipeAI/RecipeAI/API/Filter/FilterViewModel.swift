//
//  FilterViewModel.swift
//  RecipeAI
//
//  Created by Roy Braks on 06/04/2023.
//

import Foundation

class FilterViewModel: ObservableObject {
    @Published var dietTypes = ["High Fiber", "High Protein", "Low Carb", "Low Fat", "Low Sodium"]
    
    @Published var dietTypesBool = [false, false, false, false, false]
    
    var startLink = "https://api.edamam.com/api/recipes/v2?type=public&app_id=104e9190&app_key=ddb3653ba1ff401aa1594cbbd3bc476b&"
    
    
    func createApiLink() {
        for (index,dietType) in dietTypesBool.enumerated() {
            
            if dietType {
                switch index {
                case 0:
                    startLink.append("diet=high-fiber")
                case 1:
                    startLink.append("&diet=high-protein")
                case 2:
                    startLink.append("&diet=low-carb")
                case 3:
                    startLink.append("&diet=low-fat")
                case 4:
                    startLink.append("&diet=low-sodium")
                default:
                    break
                }
            }
        }
        print(startLink)
    }
}

