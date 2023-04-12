//
//  ViewModel.swift
//  RecipeAI
//
//  Created by Lunis Ahdidouch on 05/04/2023.
//

import Foundation
import OpenAISwift

struct Model: Identifiable{
    let id: UUID
    let text: String
}

final class ViewModel: ObservableObject{
    
    private var client: OpenAISwift?
    
    func setup(){
        client = OpenAISwift(authToken: "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")
    }
    
    func send(text: String,
              completion: @escaping (String) -> Void){
        client?.sendCompletion(with: text,
                               maxTokens: 2000,
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
