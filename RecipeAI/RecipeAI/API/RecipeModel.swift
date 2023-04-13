//
//  RecipeModel.swift
//  RecipeAI
//
//  Created by Roy Braks on 05/04/2023.
//

import Foundation

struct RecipesResponse: Codable {
    let hits: [RecipeHit]
}

struct RecipeHit: Codable {
    let recipe: Recipe
}

struct Recipe: Codable {
    let label: String
    let image: String
    let shareAs: String
}
