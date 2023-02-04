
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


INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Skinless Salmon Fillet', 'Skinless Salmon Fillets']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Salt', 'Salt']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Ground Pepper', 'Ground Pepper']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Olive Oil', 'Olive Oil']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Garlic', 'Garlic']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Low-Sodium Chicken Broth', 'Low-Sodium Chicken Broth']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Lemon Juice', 'Lemon Juice']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Unsalted Butter', 'Unsalted Butter']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Honey', 'Honey']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Parsley', 'Parsley']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Lemon Slices', 'Lemon Slices']);


INSERT INTO "RecipesIngredients" ("Recipes.id", "Ingredients.id", "amount", "units", "quality", "is_required", "notes")
SELECT "Recipes"."id", "Ingredients"."id", "Temp"."amount", "Temp"."units", "Temp"."quality", "Temp"."is_required", "Temp"."notes"
FROM
(
	VALUES
	(
		ARRAY['Skinless Salmon Fillets', 'Skinless Salmon Fillets']::VARCHAR(64)[2],
		ARRAY['6oz, 1" thick', '6oz, 1" thick'],
		4.0, '', TRUE, ''
	),
	(
		ARRAY['Salt', 'Salt']::VARCHAR(64)[2],
		ARRAY['', ''],
		0.0, '', TRUE, ''
	),
	(
		ARRAY['Ground Pepper', 'Ground Pepper']::VARCHAR(64)[2],
		ARRAY['', ''],
		0.0, '', TRUE, ''
	),
	(
		ARRAY['Olive Oil', 'Olive Oil']::VARCHAR(64)[2],
		ARRAY['Teaspoon', 'Teaspoons'],
		2.0, '', TRUE, ''
	),
	(
		ARRAY['Garlic', 'Garlic']::VARCHAR(64)[2],
		ARRAY['Clove', 'Cloves'],
		2.0, 'Minced', TRUE, ''
	),
	(
		ARRAY['Low-Sodium Chicken Broth', 'Low-Sodium Chicken Broth']::VARCHAR(64)[2],
		ARRAY['Cup', 'Cups'],
		0.25, '', TRUE, ''
	),
	(
		ARRAY['Lemon Juice', 'Lemon Juice']::VARCHAR(64)[2],
		ARRAY['Tablespoon', 'Tablespoons'],
		2.0, '', TRUE, ''
	),
	(
		ARRAY['Unsalted Butter', 'Unsalted Butter']::VARCHAR(64)[2],
		ARRAY['Tablespoon', 'Tablespoons'],
		3.0, '', TRUE, 'Chop into 1 tablespoon pieces'
	),
	(
		ARRAY['Unsalted Butter', 'Unsalted Butter']::VARCHAR(64)[2],
		ARRAY['Teaspoon', 'Teaspoons'],
		1.0, '', TRUE, ''
	),
	(
		ARRAY['Honey', 'Honey']::VARCHAR(64)[2],
		ARRAY['Teaspoon', 'Teaspoons'],
		0.5, '', TRUE, ''
	),
	(
		ARRAY['Fresh Parsley', 'Fresh Parsley']::VARCHAR(64)[2],
		ARRAY['Tablespoon', 'Tablespoons'],
		2.0, '', TRUE, ''
	),
	(
		ARRAY['Lemon Slicies', 'Lemon Slicies']::VARCHAR(64)[2],
		ARRAY['', ''],
		0.0, '', FALSE, 'for garnish'
	)
) AS "Temp"("Ingredients.names", "units", "amount", "quality", "is_required", "notes")
JOIN "Recipes" ON "Recipes"."name" = 'Salmon with Lemon Butter'
JOIN "Ingredients" ON "Temp"."Ingredients.names" = "Ingredients"."names";