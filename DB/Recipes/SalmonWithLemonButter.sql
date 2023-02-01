
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
('Salmon with Lemon Butter', 5, 4, INTERVAL '35 MINUTES', INTERVAL '15 MINUTES', INTERVAL '20 MINUTES',  
	'{
		"Preparation":
		[
			"Remove salmon fillets from refrigerator and allow to rest at room temperature for 10 minutes."
		],
		"Lemon Butter Sauce":
		[
			"Meanwhile, prepare the garlic lemon butter sauce.",
			"Melt 1 teaspoon butter over medium heat.",
			"Add garlic and saute until golden brown (about 1-2 minutes).",
			"Pour in chicken broth and lemon juice.",
			"Let sauce simmer until it has reduced to about half (about 3 tablespoons, about 3 minutes).",
			"Stir in 3 tablespoons butter and honey and which until combined, then set sauce aside."
		],
		"Salmon":
		[
			"Dab both sides of salmon dry with paper towels.",
			"Season both sides with salt abd pepper.",
			"Heat olive oil in a (heavy) non-stick skillet  over medium-high heat.",
			"Once oil is simmering, add salmon and cook about 4 minutes on the first side until golden brown on bottom.",
			"Flip salmon and cook on opposite side until it has cooked through (about 2-3 minutes).",
			"Plate salmon, leaving oil in pan, and drizzle each serving generously with butter sauce.",
			"Sprinkle with parsley and garnish with lemon slices if desired.",
			"Enjoy!"
		]
	}'
);


INSERT INTO "Ingredients" ("name") VALUES
('Skinless Salmon Fillets');
INSERT INTO "Ingredients" ("name") VALUES
('Salt');
INSERT INTO "Ingredients" ("name") VALUES
('Ground Pepper');
INSERT INTO "Ingredients" ("name") VALUES
('Olive Oil');
INSERT INTO "Ingredients" ("name") VALUES
('Garlic');
INSERT INTO "Ingredients" ("name") VALUES
('Low-Sodium Chicken Broth');
INSERT INTO "Ingredients" ("name") VALUES
('Lemon Juice');
INSERT INTO "Ingredients" ("name") VALUES
('Unsalted Butter');
INSERT INTO "Ingredients" ("name") VALUES
('Honey');
INSERT INTO "Ingredients" ("name") VALUES
('Parsley');
INSERT INTO "Ingredients" ("name") VALUES
('Lemon Slices');


INSERT INTO "RecipesIngredients" ("Recipes.id", "Ingredients.id", "amount", "units", "quality", "is_required", "notes")
SELECT "Recipes"."id", "Ingredients"."id", "Temp"."amount", "Temp"."units", "Temp"."quality", "Temp"."is_required", "Temp"."notes"
FROM
(
	VALUES
	('Salmon with Lemon Butter', 'Skinless Salmon Fillets', 4, ARRAY['6oz, 1" thick', '6oz, 1" thick'], '', TRUE, ''),
	('Salmon with Lemon Butter', 'Salt', 0, ARRAY['', ''], '', TRUE, ''),
	('Salmon with Lemon Butter', 'Ground Pepper', 0, ARRAY['', ''], '', TRUE, ''),
	('Salmon with Lemon Butter', 'Olive Oil', 2, ARRAY['Teaspoon', 'Teaspoons'], '', TRUE, ''),
	('Salmon with Lemon Butter', 'Garlic', 2, ARRAY['Clove', 'Cloves'], 'Minced', TRUE, ''),
	('Salmon with Lemon Butter', 'Low-Sodium Chicken Broth', 0.25, ARRAY['Cup', 'Cups'], '', TRUE, ''),
	('Salmon with Lemon Butter', 'Lemon Juice', 2.0, ARRAY['Tablespoon', 'Tablespoons'], '', TRUE, ''),
	('Salmon with Lemon Butter', 'Unsalted Butter', 3.0, ARRAY['Tablespoon', 'Tablespoons'], '', TRUE, 'Chop into 1 tablespoon pieces'),
	('Salmon with Lemon Butter', 'Unsalted Butter', 1, ARRAY['Teaspoon', 'Teaspoons'], '', TRUE, ''),
	('Salmon with Lemon Butter', 'Honey', 0.5, ARRAY['Teaspoon', 'Teaspoons'], '', TRUE, ''),
	('Salmon with Lemon Butter', 'Fresh Parsley', 2.0, ARRAY['Tablespoon', 'Tablespoons'], '', TRUE, ''),
	('Salmon with Lemon Butter', 'Lemon Slicies', 0, ARRAY['', ''],  '', FALSE, 'for garnish')
) AS "Temp"("Recipes.name", "Ingredients.name", "amount", "units", "quality", "is_required", "notes")
JOIN "Recipes" ON "Temp"."Recipes.name" = "Recipes"."name"
JOIN "Ingredients" ON "Temp"."Ingredients.name" = "Ingredients"."name";
