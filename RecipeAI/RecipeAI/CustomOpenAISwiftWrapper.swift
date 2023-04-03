//
//  CustomOpenAISwift.swift
//  RecipeAI
//
//  Created by Lunis Ahdidouch on 03/04/2023.
//

import Foundation
import OpenAISwift

class CustomOpenAISwiftWrapper {
    private var openAIClient: OpenAISwift
    
    init(authToken: String) {
        openAIClient = OpenAISwift(authToken: authToken)
    }
    
    func sendCompletion(with prompt: String, maxTokens: Int = 16, completionHandler: @escaping (Result<OpenAI<TextResult>, OpenAIError>) -> Void) {
        openAIClient.sendCompletion(with: prompt, maxTokens: maxTokens) { result in
            switch result {
            case .success(let success):
                print("Raw Data: \(String(data: success.rawData, encoding: .utf8) ?? "")")
                completionHandler(.success(success))
            case .failure(let failure):
                completionHandler(.failure(failure))
            }
        }
    }
}

