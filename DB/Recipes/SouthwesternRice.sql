
/***********************************************************************************************************************
*                                                                                                                      *
*   created by: MPZinke                                                                                                *
*   on 2023.01.30                                                                                                      *
*                                                                                                                      *
*   DESCRIPTION: TEMPLATE                                                                                              *
*   BUGS:                                                                                                              *
*   FUTURE:                                                                                                            *
*                                                                                                                      *
***********************************************************************************************************************/


-- https://www.tasteofhome.com/recipes/southwestern-rice/






DO $$
DECLARE RecipeName VARCHAR(64);
BEGIN
	RecipeName := 'Southwestern Rice';


	INSERT INTO "Recipes" ("name", "rating", "servings", "total_time", "prep_time", "cook_time", "url", "instructions") VALUES
	(RecipeName, 3, 8, INTERVAL '30 MINUTES', INTERVAL '10 MINUTES', INTERVAL '20 MINUTES',
		'https://www.tasteofhome.com/recipes/southwestern-rice/',
		'[
			"In a large nonstick skillet, heat oil over medium-high heat.",
			"Saute pepper and onion 3 minutes.",
			"Add garlic.",
			"Cook and stir 1 minute.",
			"Stir in rice, spices and broth, bringing to a boil.",
			"Reduce heat; simmer, covered, until rice is tender, about 15 minutes.",
			"Stir in remaining ingredients; cook, covered, until heated through."
		]'
	);


	INSERT INTO "Ingredients" ("names")
	SELECT "Temp"."names"
	FROM
	(
		VALUES
		(ARRAY['Olive Oil', 'Olive Oil']::VARCHAR(64)[2]),
		(ARRAY['Green Pepper', 'Green Peppers']::VARCHAR(64)[2]),
		(ARRAY['Onion', 'Onions']::VARCHAR(64)[2]),
		(ARRAY['Garlic', 'Garlic']::VARCHAR(64)[2]),
		(ARRAY['Rice', 'Rice']::VARCHAR(64)[2]),
		(ARRAY['Cumin', 'Cumin']::VARCHAR(64)[2]),
		(ARRAY['Tumeric', 'Tumeric']::VARCHAR(64)[2]),
		(ARRAY['Chicken Broth', 'Chicken Broth']::VARCHAR(64)[2]),
		(ARRAY['Corn', 'Corn']::VARCHAR(64)[2]),
		(ARRAY['Black Beans', 'Black Beans']::VARCHAR(64)[2]),
		(ARRAY['Diced Tomatoes', 'Diced Tomatoes']::VARCHAR(64)[2])
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
			ARRAY['Olive Oil', 'Olive Oil']::VARCHAR(64)[2],
			ARRAY['Tablespoon', 'Tablespoons'],
			1.0, '', TRUE, ''
		),
		(
			ARRAY['Green Pepper', 'Green Peppers']::VARCHAR(64)[2],
			ARRAY['', ''],
			1.0, 'Diced', TRUE, ''
		),
		(
			ARRAY['Onion', 'Onions']::VARCHAR(64)[2],
			ARRAY['', ''],
			1.0, 'Medium Chopped', TRUE, ''
		),
		(
			ARRAY['Garlic', 'Garlic']::VARCHAR(64)[2],
			ARRAY['Clove', 'Cloves'],
			2.0, 'Minced', TRUE, ''
		),
		(
			ARRAY['Rice', 'Rice']::VARCHAR(64)[2],
			ARRAY['Cup', 'Cups'],
			2.0, '', TRUE, 'Scrambled'
		),
		(
			ARRAY['Cumin', 'Cumin']::VARCHAR(64)[2],
			ARRAY['Teaspoon', 'Teaspoons'],
			0.5, '', TRUE, ''
		),
		(
			ARRAY['Tumeric', 'Tumeric']::VARCHAR(64)[2],
			ARRAY['Teaspoon', 'Teaspoons'],
			0.125, '', TRUE, ''
		),
		(
			ARRAY['Chicken Broth', 'Chicken Broth']::VARCHAR(64)[2],
			ARRAY['Can', 'Cans'],
			1.0, '', TRUE, ''
		),
		(
			ARRAY['Corn', 'Corn']::VARCHAR(64)[2],
			ARRAY['Cup', 'Cups'],
			2.0, '', TRUE, ''
		),
		(
			ARRAY['Black Beans', 'Black Beans']::VARCHAR(64)[2],
			ARRAY['Can', 'Cans'],
			2.0, '', TRUE, 'Rinsed and Drained'
		),
		(
			ARRAY['Diced Tomatoes', 'Diced Tomatoes']::VARCHAR(64)[2],
			ARRAY['Can', 'Cans'],
			1.5, '', TRUE, 'Undrained'
		)
	) AS "Temp"("Ingredients.names", "units", "amount", "quality", "is_required", "notes")
	JOIN "Recipes" ON "Recipes"."name" = RecipeName
	LEFT JOIN "Ingredients" ON "Temp"."Ingredients.names" = "Ingredients"."names";

END $$;
