//
//  Prompts.swift
//  RecipeAI
//
//  Created by Lunis Ahdidouch on 06/04/2023.
//

import Foundation
import SwiftUI

class prompts{
    init() {}
    public let choices = ["Remove Chicken", "Remove Asparagus", "Remove Parmesan Cheese", "Remove Creme Fraiche"]
    
    
     public let prompt = """
        Change the ingredients and create instructions on how to make the recipe based on the name and ingredients . Then send the list of ingredients with the instructions on how to make it with the following format:
        Ingredients:
        -
        -
        -
        
        Instructions:
        1.
        
        2.
        
        3.
        
        4.
        """
}
//Add a - before each ingredient, so for example - 1 chicken breast.
//Format it as follows:
//Ingredients:
//-
//-
//-
//-
//-
//
//Instructions:
//1.
//
//2.
//
//3.
//
//4.
//
//Continue like for the necesary amount of steps and add enters between each step of the instructions.
