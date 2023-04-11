//
//  APICallExplore.swift
//  RecipeAI
//
//  Created by Roy Braks on 05/04/2023.
//

import Foundation
import Kingfisher

class APICallExplore: ObservableObject {

    @Published var recipeImages = [String]()
    
    let url = URL(string:"nog toevoegen")!

    func getRecipes() {

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("Error: No data returned")
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(RecipesResponse.self, from: data)
                
                DispatchQueue.main.async {
                    self.recipeImages.append(contentsOf: result.hits.map { $0.recipe.image })
                    print(self.recipeImages.count)
                }
            }
            catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }

        }.resume()
    }
}
