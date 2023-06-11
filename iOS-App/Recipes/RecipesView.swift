//
//  ContentView.swift
//  Recipes
//
//  Created by Mathew Zinke on 6/10/23.
//

import SwiftUI


struct RecipesView: View
{
    @AppStorage("current_recipe") var current_recipe: String = ""
    @AppStorage("login") var login: String = ""


    var body: some View
    {
        var recipes:[String] = ["Test 1", "Test 2"]
        VStack {
            if current_recipe == ""
            {
                Text("Please select a recipe")
                List
                {
                    ForEach(0 ..< recipes.count)
                    {
                        x in
                        Button(
                            action:
                            {
                                current_recipe = recipes[x]
                            }
                        )
                        {
                            Text(recipes[x])
                        }
                    }
                }
            }
            else
            {
                RecipeView()
            }
        }
        .padding()
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
