//
//  ContentView.swift
//  RecipeAI
//
//  Created by Lunis Ahdidouch on 03/04/2023.
//

import SwiftUI
import OpenAISwift



struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    let recipes = Recipes()
    @State var text = ""
    @State var models = [String]()
    @State var prompt = "Change the ingredients and instructions accordingly to good taste. Then resend the ingredients and instructions with the changes added and reformat it nicely."

    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                ForEach(models, id: \.self){ string in
                    Text(string)
                }
            }
            
            Spacer()
            HStack{
//                TextField("Type here...", text: $text)
                Text("Remove an ingredient")
                    .contextMenu {
                        Button {
                            text = "Remove Chicken"
                            send()
                        } label: {
                            Label("Chicken", systemImage: "list.clipboard")
                        }

                        Button {
                            text = "Parmesan Cheese"
                            send()
                        } label: {
                            Label("Parmesan Cheese", systemImage: "list.clipboard")
                        }
                        
                        Button {
                            text = "Remove Asparagus"
                            send()
                        } label: {
                            Label("Asparagus", systemImage: "list.clipboard")
                        }

                        Button {
                            text = "Remove Creme Fraiche"
                            send()
                        } label: {
                            Label("Creme Fraiche", systemImage: "list.clipboard")
                        }
                    }
            }
            Text(recipes.ingredients[0].joined(separator: "\n"))
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(recipes.instructions[0], id: \.self) { instruction in
                    Text(instruction)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 2))
            }
            }
//            Text(recipe)
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
        

        @State var fullPrompt = "\(text) \(prompt) \(recipes.ingredients[0]) \(recipes.instructions[0])"

        viewModel.send(text: fullPrompt){ response in
            DispatchQueue.main.async {
                self.models.append("ChatGPT: \(response.trimmingCharacters(in: .whitespacesAndNewlines))")
                self.text = ""
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
