//
//  ContentView.swift
//  RecipeAI
//
//  Created by Lunis Ahdidouch on 03/04/2023.
//

import SwiftUI
import OpenAISwift

final class ViewModel: ObservableObject{
    init() {}
    
    private var client: OpenAISwift?
    
    func setup(){
        client = OpenAISwift(authToken: "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")
    }
    
    func send(text: String,
              completion: @escaping (String) -> Void){
        client?.sendCompletion(with: text,
                               maxTokens: 500,
                               completionHandler: { result in
            switch result {
            case .success(let model):
                let output = model.choices.first?.text ?? ""
                completion(output)
            case .failure(let error):
                print("Error: \(error)")
                break
            }
            
        })
    }
}

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    @State var text = ""
    @State var models = [String]()
    @State var prompt = "Change the ingredients and instructions accordingly to good taste and format it nicely"
    @State var recipe = "Ingredients: 8 Chicken Tenders 6 ounces Fettuccine Pasta 1 bunch Kale ½ bunch Asparagus 1 bunch Rosemary 2 tablespoons Creme Fraiche 2 tablespoons Parmesan Cheese (Grated) 0.12 teaspoon Crushed Red Pepper Flakes. Instructions:  1 Prepare the ingredients: Wash and dry the fresh produce. Heat a medium pot of salted water to boiling on high. Snap off and discard the tough, woody ends of the asparagus; cut the asparagus into 1-inch pieces on an angle. Remove and discard the kale stems; finely chop the leaves. Pick the rosemary leaves off the stems; discard the stems and roughly chop the leaves. Pat the chicken dry with paper towels and chop into bite-sized pieces; transfer to a bowl. Season the chopped chicken with salt and pepper; toss to coat. 2Cook the chicken: In a large, high-sided pan, heat 2 teaspoons of olive oil on medium-high until hot. Add the seasoned chicken and cook, stirring occasionally, 4 to 6 minutes, or until lightly browned and cooked through. 3Cook the pasta: While the chicken cooks, add the pasta to the pot of boiling water and cook 8 to 10 minutes, or until al dente (still slightly firm to the bite). Reserving ¾ cup of the pasta cooking water, drain thoroughly. 4Add the vegetables: While the pasta cooks, to the pan of chicken, add the asparagus, kale, rosemary, 2 tablespoons of water and as much of the red pepper flakes as you’d like, depending on how spicy you’d like the dish to be; season with salt and pepper. Cook, stirring frequently, 2 to 4 minutes, or until the asparagus is bright green and the kale has wilted. 5Finish the pasta: To the pan of chicken and vegetables, add the cooked pasta, crème fraîche and half the reserved pasta cooking water; season with salt and pepper. Cook, stirring vigorously to coat the pasta, 2 to 3 minutes, or until thoroughly combined. (If the sauce seems dry, gradually add the remaining pasta cooking water to achieve your desired consistency.) Remove from heat and season with salt and pepper to taste. 6Plate your dish: Divide the finished pasta between 2 dishes. Garnish with the cheese. Enjoy! "
    
    var body: some View {
        VStack(alignment: .leading){
            ForEach(models, id: \.self){ string in
                Text(string)
            }
            
            Spacer()
            
            HStack{
                TextField("Type here...", text: $text)
                Button("Send"){
                    send()
                }
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
        
        models.append("Me: \(text) ---  \(recipe) --- \(prompt)")
        viewModel.send(text: text){ response in
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
