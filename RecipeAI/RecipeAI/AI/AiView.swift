//
//  ContentView.swift
//  RecipeAI
//
//  Created by Lunis Ahdidouch on 03/04/2023.
//

import SwiftUI
import OpenAISwift



struct AiView: View {
    @ObservedObject var viewModel = ViewModel()
    let recipes = Recipes()
    let allPrompts = prompts()
    @State var latestResponse = ""
    @State var text = "Create the recipe based on the name and the ingredients"
    @State var models = [String]()
    @State var ingredientsSelection = 0

    var joinedArrayIngredients: String {
            recipes.ingredients[0].joined(separator: "\n")
        }
    var joinedArrayInstructions: String {
            recipes.instructions[0].joined(separator: "\n")
        }
    
    var body: some View {
        ScrollView{
            Spacer()
            VStack{
                NavigationView(){
                    NavigationLink(destination: ButtonsPage(text: $text, sendAction: send)){
                        VStack{
                            HStack {
                                Text("Change recipe")
                                    .padding()
                                Spacer(minLength: 0)
                            }
                            Spacer(minLength: 0)
                        }
                    }
                }
                .frame(height: 150, alignment: .leading)
                .onAppear{
                    send()
                }
                Text(latestResponse)
            }
        }
        .onAppear{
            viewModel.setup()
        }
        .padding()
    }

    
    func send() {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else{
            return
        }
        

        @State var fullPrompt = "\(text) \(allPrompts.prompt) \(joinedArrayIngredients)"

        viewModel.send(text: fullPrompt){ response in
            DispatchQueue.main.async{
                self.latestResponse = response.trimmingCharacters(in: .whitespacesAndNewlines)
                self.text = ""
            }
        }
    }
}

struct ButtonsPage: View{
    @Binding var text: String
    let sendAction: () -> Void
    
    var body: some View {
        Menu {
            Button("Remove Chicken", action: {
                text = "Remove Chicken"
                sendAction ()
            })
            Button("Remove Asparagus", action: {
                text = "Remove Asparagus"
                sendAction()
            })
            Button("Remove Parmesan Cheese", action: {
                text = "Remove Parmesan Cheese"
                sendAction()
            })
            Button("Remove Creme Fraiche", action: {
                text = "Remove Creme Fraiche"
                sendAction()
            })
        } label: {
            Text("Remove an ingredient")
        }
        
        Menu {
            Button("Make vegetarian", action: {
                text = "Make it vegetarian"
                sendAction ()
            })
            Button("Make vegan", action: {
                text = "Make it vegan"
                sendAction()
            })
            Button("Low-Calorie", action: {
                text = "Change necessary ingredients to make meal lower in calories."
                sendAction()
            })
        } label: {
            Text("Change dish type")
        }
    }
}
