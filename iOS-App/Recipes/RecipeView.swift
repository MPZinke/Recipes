//
//  Recipe.swift
//  Recipes
//
//  Created by Mathew Zinke on 6/10/23.
//

import SwiftUI


struct RecipeView: View
{
    // Not duplicate. Only initializes value if not already initialized
    @AppStorage("current_recipe") var current_recipe: String = ""


    var body: some View
    {
        Button(
            action:
            {
                current_recipe = ""
            }
        )
        {
            Text("Recipes")
        }
        Text(current_recipe)
    }
}
