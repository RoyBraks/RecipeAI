//
//  ApiTest.swift
//  RecipeAI
//
//  Created by Roy Braks on 05/04/2023.
//

import SwiftUI
import Kingfisher

struct ExplorePage: View {
    
    @ObservedObject var apiCallExplore = APICallExplore()

    var body: some View {
        NavigationView {
            VStack {
                Button("Click") {
                    apiCallExplore.getRecipes()
                }
                let layout = [
                    GridItem(.flexible(), spacing: 0),
                    GridItem(.flexible(), spacing: 0),
                    GridItem(.flexible(), spacing: 0)
                ]
                
                ScrollView {
                    LazyVGrid(columns: layout, spacing: 0) {
                        ForEach(apiCallExplore.recipeImages, id: \.self) { imageUrl in
                            KFImage(URL(string: imageUrl))
                                .resizable()
                                .placeholder {
                                    Image(systemName: "photo")
                                }
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }.refreshable {
                    apiCallExplore.recipeImages = []
                    apiCallExplore.getRecipes()
                }
            }
            .navigationTitle("Explore Recipes")
            .toolbar() {
                ToolbarItem {
                    NavigationLink(
                        destination: FilterView(),
                        label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                        }
                    )
                    .foregroundColor(Color.green)
                }
                ToolbarItem{
                    Button{
                        print("nothing")
                    } label: {
                        Image(systemName: "heart")
                    }
                    .foregroundColor(Color.green)
                }
            }
        }
    }
}


struct ExplorePage_Previews: PreviewProvider {
    static var previews: some View {
        ExplorePage()
    }
}
