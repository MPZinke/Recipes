
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


DO $$
DECLARE RecipeName VARCHAR(64);
BEGIN
	RecipeName := 'Pad Thai';


	INSERT INTO "Recipes" ("name", "rating", "servings", "total_time", "prep_time", "cook_time", "url", "instructions") VALUES
	(RecipeName, 5, 4, INTERVAL '30 MINUTES', INTERVAL '15 MINUTES', INTERVAL '15 MINUTES',
		'https://tastesbetterfromscratch.com/pad-thai/#recipe',
		'{
			"Sauce":
			[
				"Make sauce by combining sauce ingredients in a bowl. Set aside."
			],
			"Noodles":
			[
				"Cook noodles according to package instructions, just until tender.",
				"When done, rinse under cold water."
			],
			"Stir Fry":
			[
				"Heat 1½ tablespoons of oil in a large saucepan over medium-high heat.",
				"Add the chicken or tofu, garlic and bell pepper.",
				"If using chicken, cook until just cooked through, about 3-4 minutes, flipping only once.",
				"Push everything to the side of the pan.",
				"Add a little oil and the beaten eggs",
				"Scramble the eggs, breaking them into small pieces with a spatula as they cook."
			],
			"Combine":
			[
				"Add noodles, sauce, bean sprouts and peanuts to the pan (reserving some peanuts for topping at the end), tossing everything to combine.",
				"Garnish the top with green onions, extra peanuts, cilantro and lime wedges."
			]
		}'
	);


	INSERT INTO "Ingredients" ("names")
	SELECT "Temp"."names"
	FROM
	(
		VALUES
		(ARRAY['Flat Rice Noodles', 'Flat Rice Noodles']::VARCHAR(64)[2]),
		(ARRAY['Oil', 'Oil']::VARCHAR(64)[2]),
		(ARRAY['Garlic', 'Garlic']::VARCHAR(64)[2]),
		(ARRAY['Chicken Breast', 'Chicken Breasts']::VARCHAR(64)[2]),
		(ARRAY['Egg', 'Eggs']::VARCHAR(64)[2]),
		(ARRAY['Bean Sprout', 'Bean Sprouts']::VARCHAR(64)[2]),
		(ARRAY['Red Bell Pepper', 'Red Bell Peppers']::VARCHAR(64)[2]),
		(ARRAY['Green Onion', 'Green Onions']::VARCHAR(64)[2]),
		(ARRAY['Roasted Peanuts', 'Roasted Peanuts']::VARCHAR(64)[2]),
		(ARRAY['Lime', 'Limes']::VARCHAR(64)[2]),
		(ARRAY['Cilantro', 'Cilantro']::VARCHAR(64)[2]),
		(ARRAY['Fish Sauce', 'Fish Sauce']::VARCHAR(64)[2]),
		(ARRAY['Low-Sodium Soy Sauce', 'Low-Sodium Soy Sauce']::VARCHAR(64)[2]),
		(ARRAY['Light Brown Sugar', 'Light Brown Sugar']::VARCHAR(64)[2]),
		(ARRAY['Rice Vinegar', 'Rice Vinegar']::VARCHAR(64)[2]),
		(ARRAY['Sriracha Sauce', 'Sriracha Sauce']::VARCHAR(64)[2]),
		(ARRAY['Creamy Peanut Butter', 'Creamy Peanut Butter']::VARCHAR(64)[2])
	) AS "Temp" ("names")
	WHERE "Temp"."names" NOT IN
	(
		SELECT "names"
		FROM "Ingredients"
	);


	INSERT INTO "RecipesIngredients" ("Recipes.id", "Ingredients.id", "group", "amount", "units", "quality", "is_required", "notes")
	SELECT "Recipes"."id", "Ingredients"."id", "Temp"."group", "Temp"."amount", "Temp"."units", "Temp"."quality", "Temp"."is_required",
	  "Temp"."notes"
	FROM
	(
		VALUES
		(
			ARRAY['Flat Rice Noodles', 'Flat Rice Noodles']::VARCHAR(64)[2],
			'',
			ARRAY['Ounce', 'Ounces'],
			8.0, 'Softened', TRUE, ''
		),
		(
			ARRAY['Oil', 'Oil']::VARCHAR(64)[2],
			'',
			ARRAY['Tablespoon', 'Tablespoons'],
			3.0, '', TRUE, ''
		),
		(
			ARRAY['Garlic', 'Garlic']::VARCHAR(64)[2],
			'',
			ARRAY['Clove', 'Cloves'],
			3.0, 'Minced', TRUE, ''
		),
		(
			ARRAY['Chicken Breast', 'Chicken Breasts']::VARCHAR(64)[2],
			'',
			ARRAY['', ''],
			8.0, '', TRUE, 'Or shrimp or extra-firm tofu. Cut into small pieces'
		),
		(
			ARRAY['Egg', 'Eggs']::VARCHAR(64)[2],
			'',
			ARRAY['', ''],
			2.0, '', TRUE, 'Scrambled'
		),
		(
			ARRAY['Bean Sprout', 'Bean Sprouts']::VARCHAR(64)[2],
			'',
			ARRAY['Cup', 'Cups'],
			1.0, 'Fresh', TRUE, ''
		),
		(
			ARRAY['Red Bell Pepper', 'Red Bell Peppers']::VARCHAR(64)[2],
			'',
			ARRAY['', ''],
			1.0, 'Thinly sliced', TRUE, ''
		),
		(
			ARRAY['Green Onion', 'Green Onions']::VARCHAR(64)[2],
			'',
			ARRAY['', ''],
			3.0, 'Chopped', TRUE, ''
		),
		(
			ARRAY['Roasted Peanuts', 'Roasted Peanuts']::VARCHAR(64)[2],
			'',
			ARRAY['Cup', 'Cups'],
			1.5, 'Dry', TRUE, ''
		),
		(
			ARRAY['Lime', 'Limes']::VARCHAR(64)[2],
			'',
			ARRAY['', ''],
			2.0, '', TRUE, 'Cut into wedges'
		),
		(
			ARRAY['Cilantro', 'Cilantro']::VARCHAR(64)[2],
			'',
			ARRAY['Cup', 'Cups'],
			1.5, 'Fresh, chopped', TRUE, ''
		),
		(
			ARRAY['Fish Sauce', 'Fish Sauce']::VARCHAR(64)[2],
			'Sauce',
			ARRAY['Tablespoon', 'Tablespoons'],
			3.0, '', TRUE, ''
		),
		(
			ARRAY['Low-Sodium Soy Sauce', 'Low-Sodium Soy Sauce']::VARCHAR(64)[2],
			'Sauce',
			ARRAY['Tablespoon', 'Tablespoons'],
			1.0, '', TRUE, ''
		),
		(
			ARRAY['Light Brown Sugar', 'Light Brown Sugar']::VARCHAR(64)[2],
			'Sauce',
			ARRAY['Tablespoon', 'Tablespoons'],
			5.0, '', TRUE, ''
		),
		(
			ARRAY['Rice Vinegar', 'Rice Vinegar']::VARCHAR(64)[2],
			'Sauce',
			ARRAY['Tablespoon', 'Tablespoons'],
			2.0, '', TRUE, 'Or Tamarind Paste'
		),
		(
			ARRAY['Sriracha Sauce', 'Sriracha Sauce']::VARCHAR(64)[2],
			'Sauce',
			ARRAY['Tablespoon', 'Tablespoons'],
			1.0, '', TRUE, 'Or more to taste'
		),
		(
			ARRAY['Creamy Peanut Butter', 'Creamy Peanut Butter']::VARCHAR(64)[2],
			'Sauce',
			ARRAY['Tablespoon', 'Tablespoons'],
			2.0, '', FALSE, ''
		)
	) AS "Temp"("Ingredients.names", "group", "units", "amount", "quality", "is_required", "notes")
	JOIN "Recipes" ON "Recipes"."name" = RecipeName
	LEFT JOIN "Ingredients" ON "Temp"."Ingredients.names" = "Ingredients"."names";

END $$;
