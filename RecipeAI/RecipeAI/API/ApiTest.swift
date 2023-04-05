//
//  ApiTest.swift
//  RecipeAI
//
//  Created by Roy Braks on 05/04/2023.
//

import SwiftUI

struct ApiTest: View {
    
    let apiId = "104e9190"
    let apiKey = "ddb3653ba1ff401aa1594cbbd3bc476b"


    func getRecipes() {
        
        let url = URL(string: "https://api.edamam.com/api/recipes/v2?type=public&app_id=\(apiId)&app_key=\(apiKey)&imageSize=SMALL&random=true&field=label&field=image&field=shareAs&field=dietLabels&field=totalTime&field=cuisineType&field=dishType&field=externalId")!
        
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
                    recipeImages = result.hits.map { $0.recipe.image }
                }
                
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
            
        }.resume()
    }
    let apiCallExplore = APICallExplore()
    
    @State private var recipeImages = [String]()
    
    var body: some View {
        Button("Click") {
            getRecipes()
        }
        
        let layout = [
            GridItem(.fixed(UIScreen.main.bounds.width/3)),
            GridItem(.fixed(UIScreen.main.bounds.width/3)),
            GridItem(.fixed(UIScreen.main.bounds.width/3))
        ]

        ScrollView {
            LazyVGrid(columns: layout, spacing: 0) {
                ForEach(recipeImages, id: \.self) { image in
                        AsyncImage(url: URL(string: image)) { image in
                            image.image?.resizable()
                        }
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
    }
}


struct ApiTest_Previews: PreviewProvider {
    static var previews: some View {
        ApiTest()
    }
}
