
/***********************************************************************************************************************
*                                                                                                                      *
*   created by: Morgan Pothoff                                                                                         *
*   on 2023.01.27                                                                                                      *
*                                                                                                                      *
*   DESCRIPTION: TEMPLATE                                                                                              *
*   BUGS:                                                                                                              *
*   FUTURE:                                                                                                            *
*                                                                                                                      *
***********************************************************************************************************************/


INSERT INTO "Recipes" ("name", "rating", "serving_size", "total_time", "prep_time", "cook_time", "instructions") VALUES
('Pad Thai', 5, 4, INTERVAL '30 MINUTES', INTERVAL '15 MINUTES', INTERVAL '15 MINUTES',  
'[
	"Make sauce by combining sauce ingredients in a bowl. Set aside.",
	"Cook noodles according to package instructions, just until tender. When done, rinse under cold water.",
	"Stir Fry: Heat 1½ tablespoons of oil in a large saucepan over medium-high heat. Add the shrimp, chicken or tofu, garlic and bell pepper. The shrimp will cook quickly, about 1-2 minutes on each side, or until pink. If using chicken, cook until just cooked through, about 3-4 minutes, flipping only once.",
	"Push everything to the side of the pan. Add a little oil and add the beaten eggs. Scramble the eggs, breaking them into small pieces with a spatula as they cook.",
	"Add noodles, sauce, bean sprouts and peanuts to the pan (reserving some peanuts for topping at the end). Toss everything to combine.",
	"Garnish the top with green onions, extra peanuts, cilantro and lime wedges."
]');


INSERT INTO "Ingredients" ("brand", "name", "description") VALUES
('', 'Flat Rice Noodles', '');
INSERT INTO "Ingredients" ("brand", "name", "description") VALUES
('', 'Oil', '');
INSERT INTO "Ingredients" ("brand", "name", "description") VALUES
('', 'Garlic Clove', '');
INSERT INTO "Ingredients" ("brand", "name", "description") VALUES
('', 'Chicken Breast', '');
INSERT INTO "Ingredients" ("brand", "name", "description") VALUES
('', 'Egg', '');
INSERT INTO "Ingredients" ("brand", "name", "description") VALUES
('', 'Bean Sprouts', '');
INSERT INTO "Ingredients" ("brand", "name", "description") VALUES
('', 'Red Bell Pepper', '');
INSERT INTO "Ingredients" ("brand", "name", "description") VALUES
('', 'Green Onion', '');
INSERT INTO "Ingredients" ("brand", "name", "description") VALUES
('', 'Roasted Peanuts', '');
INSERT INTO "Ingredients" ("brand", "name", "description") VALUES
('', 'Lime', '');
INSERT INTO "Ingredients" ("brand", "name", "description") VALUES
('', 'Cilantro', '');
INSERT INTO "Ingredients" ("brand", "name", "description") VALUES
('', 'Fish Sauce', '');
INSERT INTO "Ingredients" ("brand", "name", "description") VALUES
('', 'Low-Sodium Soy Sauce', '');
INSERT INTO "Ingredients" ("brand", "name", "description") VALUES
('', 'Light Brown Sugar', '');
INSERT INTO "Ingredients" ("brand", "name", "description") VALUES
('', 'Rice Vinegar', '');
INSERT INTO "Ingredients" ("brand", "name", "description") VALUES
('', 'Sriracha Hot Sauce', '');
INSERT INTO "Ingredients" ("brand", "name", "description") VALUES
('', 'Creamy Peanut Butter', '');


INSERT INTO "RecipesIngredients" ("Recipes.id", "Ingredients.id", "amount", "quantity", "is_required", "notes")
SELECT "Recipes"."id", "Ingredients"."id", "Temp"."amount", "Temp"."quantity", "Temp"."is_required", "Temp"."notes"
FROM
(
	VALUES
	-- For Noodles
	('Pad Thai', 'Flat Rice Noodles', 8, 'Ounces', TRUE, 'Softened'),
	('Pad Thai', 'Oil', 3, 'Tablespoons', TRUE, ''),
	('Pad Thai', 'Garlic Cloves', 3, '', TRUE, 'Minced'),
	('Pad Thai', 'Chicken Breast', 8, '', TRUE, 'Or shrimp or extra-firm tofu. Cut into small pieces'),
	('Pad Thai', 'Eggs', 2, '', TRUE, 'Scrambled'),
	('Pad Thai', 'Bean Sprouts', 1, 'Cup', TRUE, 'Fresh'),
	('Pad Thai', 'Red Bell Pepper', 1, '', TRUE, 'Thinly Sliced'),
	('Pad Thai', 'Green Onions', 3, '', TRUE, 'Chopped'),
	('Pad Thai', 'Roasted Peanuts', 0, '1 ½ Cups', TRUE, 'Dry'),
	('Pad Thai', 'Limes', 2, '', TRUE, 'Cut into wedges'),
	('Pad Thai', 'Cilantro', 0, '1 ½ Cups', TRUE, 'Fresh, Chopped'),
	-- For Sauce
	('Pad Thai', 'Fish Sauce', 3, 'Tablespoons', TRUE, ''),
	('Pad Thai', 'Low-Sodium Soy Sauce', 1, 'Tablespoon', TRUE, ''),
	('Pad Thai', 'Light Brown Sugar', 5, 'Tablespoons', TRUE, ''),
	('Pad Thai', 'Rice Vinegar', 2, 'Tablespoons', TRUE, 'or Tamarind Paste'),
	('Pad Thai', 'Sriracha', 1, 'Tablespoon', TRUE, 'or more to taste'),
	('Pad Thai', 'Creamy Peanut Butter', 2, 'Tablespoons', FALSE, '')
) AS "Temp"("Recipes.name", "Ingredients.name", "amount", "quantity", "is_required", "notes")
JOIN "Recipes" ON "Temp"."Recipes.name" = "Recipes"."name"
JOIN "Ingredients" ON "Temp"."Ingredients.name" = "Ingredients"."name";
