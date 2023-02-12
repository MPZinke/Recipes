
/***********************************************************************************************************************
*                                                                                                                      *
*   created by: MPZinke                                                                                                *
*   on 2023.01.21                                                                                                      *
*                                                                                                                      *
*   DESCRIPTION: TEMPLATE                                                                                              *
*   BUGS:                                                                                                              *
*   FUTURE:                                                                                                            *
*                                                                                                                      *
***********************************************************************************************************************/


DO $$
DECLARE RecipeName VARCHAR(64);
BEGIN
	RecipeName := 'Garlic Butter Chicken With Lemon Zucchini Noodle';


	INSERT INTO "Recipes" ("name", "rating", "servings", "total_time", "instructions") VALUES
	(RecipeName, 3, 3, INTERVAL '2 HOURS', 
		'{
			"Prepare The Chicken Bites":
			[
				"Slice chicken breasts into bite-sized chunks.",
				"Combine ${quantity::\\{\"amount\": 2.0, \"units\": [\"Tablespoon\", \"Tablespoons\"], \"name\": \"olive oil\"\\}}, ${quantity::\\{\"amount\": 2.0, \"units\": [\"Teaspoon\", \"Teaspoons\"], \"name\": \"salt\"\\}}, ${quantity::\\{\"amount\": 2.0, \"units\": [\"Teaspoon\", \"Teaspoons\"], \"name\": \"pepper\"\\}}, ${quantity::\\{\"amount\": 2.0, \"units\": [\"Teaspoon\", \"Teaspoons\"], \"name\": \"garlic powder\"\\}}, ${quantity::\\{\"amount\": 1.0, \"units\": [\"Teaspoon\", \"Teaspoons\"], \"name\": \"italian seasoning\"\\}}, and ${quantity::\\{\"amount\": 1.0, \"units\": [\"Tablespoon\", \"Tablespoons\"], \"name\": \"sriracha\"\\}}.",
				"Mix ${quantity::\\{\"amount\": 3.0, \"quality\": \"Boneless\", \"name\": \"chicken chunks\"\\}} & spices until evenly seasoned.",
				"Marinate in the refrigerator for ${timer::00:30:00} to ${timer::01:00:00}."
			],
			"Preparing The Zucchini Noodles":
			[
				"Wash and trim the ends of the zucchini.",
				"Using a spiralizer, make the zucchini noodles.",
				"If you do not have a spiralizer, use a peeler to slices the zucchini, then cut it into strips.",
				"Set the zucchini noodles aside."
			],
			"Cooking The Chicken Bites":
			[
				"Bring the marinated chicken bites to room temperature.",
				"Heat ${quantity::\\{\"amount\": 2.0, \"units\": [\"Tablespoon\", \"Tablespoons\"], \"name\": \"butter\"\\}}  in a large skillet over medium-low heat.",
				"Gently stir-fry the chicken pieces, in batches if needed, on all sides until golden brown.",
				"Remove the chicken bites from the skillet and set aside to a plate."
			],
			"Cooking The Zucchini Noodles":
			[
				"In the same skillet over medium-high, add ${quantity::\\{\"amount\": 2.0, \"units\": [\"Tablespoon\", \"Tablespoons\"], \"name\": \"butter\"\\}}, ${quantity::\\{\"amount\": 0.5, \"quality\": \"Juiced\", \"name\": \"lemon juice\"\\}}, ${quantity::\\{\"amount\": 1.0, \"units\": [\"Tablespoon\", \"Tablespoons\"], \"name\": \"hot sauce\"\\}}, and ${quantity::\\{\"amount\": 0.25, \"units\": [\"Cup\", \"Cups\"], \"name\": \"chicken broth\"\\}}.",
				"Bring to a simmer and allow to reduce for 1-2 minutes.",
				"Stir regularly.",
				"Stir in fresh ${quantity::\\{\"amount\": 1.0, \"units\": [\"Tablespoon\", \"Tablespoons\"], \"name\": \"fresh parsley\"\\}} and ${quantity::\\{\"amount\": 2.0, \"units\": [\"Teaspoon\", \"Teaspoons\"], \"name\": \"minced garlic\"\\}}.",
				"Add the zucchini noodles and toss for two to three minutes.",
				"Allow the cooking juices to reduce for one minute if the zucchini noodles render too much water."
			],
			"Combine":
			[
				"Add the chicken bites back to the pan and stir for another minute to reheat.",
				"Garnish with more parsley, fresh thyme, crushed chili pepper, and lemon slices and serve."
			]
		}'
	);


	INSERT INTO "Ingredients" ("names")
	SELECT "Temp"."names"
	FROM
	(
		VALUES
		(ARRAY['Chicken Breast', 'Chicken Breasts']::VARCHAR(64)[2]),
		(ARRAY['Zucchini', 'Zucchinis']::VARCHAR(64)[2]),
		(ARRAY['Butter', 'Butter']::VARCHAR(64)[2]),
		(ARRAY['Garlic', 'Garlic']::VARCHAR(64)[2]),
		(ARRAY['Sriracha Sauce', 'Sriracha Sauce']::VARCHAR(64)[2]),
		(ARRAY['Chicken Broth', 'Chicken Broth']::VARCHAR(64)[2]),
		(ARRAY['Lemon', 'Lemons']::VARCHAR(64)[2]),
		(ARRAY['Parsley', 'Parsley']::VARCHAR(64)[2]),
		(ARRAY['Thyme Leaf', 'Thyme Leaves']::VARCHAR(64)[2]),
		(ARRAY['Crush Red Pepper', 'Crush Red Pepper']::VARCHAR(64)[2]),
		(ARRAY['Olive Oil', 'Olive Oils']::VARCHAR(64)[2]),
		(ARRAY['Salt', 'Salts']::VARCHAR(64)[2]),
		(ARRAY['Black Pepper', 'Black Peppers']::VARCHAR(64)[2]),
		(ARRAY['Garlic Powder', 'Garlic Powder']::VARCHAR(64)[2]),
		(ARRAY['Italian Seasoning', 'Italian Seasonings']::VARCHAR(64)[2])
	) AS "Temp" ("names")
	WHERE "Temp"."names" NOT IN
	(
		SELECT "names"
		FROM "Ingredients"
	);


	INSERT INTO "RecipesIngredients" ("Recipes.id", "Ingredients.id", "amount", "units", "quality", "is_required", "notes")
	SELECT "Recipes"."id", "Ingredients"."id", "Temp"."amount", "Temp"."units", "Temp"."quality", "Temp"."is_required",
	  "Temp"."notes"
	FROM
	(
		VALUES
		(
			ARRAY['Chicken Breast', 'Chicken Breasts']::VARCHAR(64)[2],
			ARRAY['', ''],
			3.0, 'Boneless', TRUE, ''
		),
		(
			ARRAY['Zucchini', 'Zucchinis']::VARCHAR(64)[2],
			ARRAY['', ''],
			4.0, 'Medium', TRUE, ''
		),
		(
			ARRAY['Butter', 'Butter']::VARCHAR(64)[2],
			ARRAY['Tablespoon', 'Tablespoons'],
			4.0, '', TRUE, ''
		),
		(
			ARRAY['Garlic', 'Garlic']::VARCHAR(64)[2],
			ARRAY['Teaspoon', 'Teaspoons'],
			2.0, 'Minced', TRUE, ''
		),
		(
			ARRAY['Sriracha Sauce', 'Sriracha Sauce']::VARCHAR(64)[2],
			ARRAY['Tablespoon', 'Tablespoons'],
			1.0, '', TRUE, ''
		),
		(
			ARRAY['Chicken Broth', 'Chicken Broth']::VARCHAR(64)[2],
			ARRAY['Cup', 'Cups'],
			0.25, 'Low-Sodium', TRUE, ''
		),
		(
			ARRAY['Lemon', 'Lemons']::VARCHAR(64)[2],
			ARRAY['', ''],
			0.5, 'Juiced', TRUE, ''
		),
		(
			ARRAY['Parsley', 'Parsley']::VARCHAR(64)[2],
			ARRAY['Tablespoon', 'Tablespoons'],
			1.0, '', TRUE, ''
		),
		(
			ARRAY['Thyme Leaf', 'Thyme Leaves']::VARCHAR(64)[2],
			ARRAY['Teaspoon', 'Teaspoons'],
			1.0, '', TRUE, ''
		),
		(
			ARRAY['Crush Red Pepper', 'Crush Red Pepper']::VARCHAR(64)[2],
			ARRAY['', ''],
			0.0, '', FALSE, ''
		),
		(
			ARRAY['Lemon', 'Lemons']::VARCHAR(64)[2],
			ARRAY['', ''],
			0.0, 'Sliced', TRUE, ''
		),
		(
			ARRAY['Olive Oil', 'Olive Oils']::VARCHAR(64)[2],
			ARRAY['Tablespoon', 'Tablespoons'],
			2.0, '', TRUE, ''
		),
		(
			ARRAY['Sriracha Sauce', 'Sriracha Sauce']::VARCHAR(64)[2],
			ARRAY['Tablespoon', 'Tablespoons'],
			1.0, '', TRUE, ''
		),
		(
			ARRAY['Salt', 'Salts']::VARCHAR(64)[2],
			ARRAY['Teaspoon', 'Teaspoons'],
			2.0, '', TRUE, ''
		),
		(
			ARRAY['Black Pepper', 'Black Peppers']::VARCHAR(64)[2],
			ARRAY['Teaspoon', 'Teaspoons'],
			1.0, '', TRUE, ''
		),
		(
			ARRAY['Garlic Powder', 'Garlic Powder']::VARCHAR(64)[2],
			ARRAY['Teaspoon', 'Teaspoons'],
			2.0, '', TRUE, ''
		),
		(
			ARRAY['Italian Seasoning', 'Italian Seasonings']::VARCHAR(64)[2],
			ARRAY['Teaspoon', 'Teaspoons'],
			1.0, '', TRUE, ''
		)
	) AS "Temp"("Ingredients.names", "units", "amount", "quality", "is_required", "notes")
	JOIN "Recipes" ON "Recipes"."name" = RecipeName
	LEFT JOIN "Ingredients" ON "Temp"."Ingredients.names" = "Ingredients"."names";

END $$;
