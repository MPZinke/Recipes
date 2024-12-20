
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
	RecipeName := 'Pita Bread';


	INSERT INTO "Recipes" ("name", "rating", "servings", "total_time", "prep_time", "cook_time", "url", "instructions") VALUES
	(RecipeName, 4, 8, INTERVAL '40 MINUTES', INTERVAL '30 MINUTES', INTERVAL '10 MINUTES',
		'https://www.themediterraneandish.com/homemade-pita-bread-recipe/',
		'[
			"Combine 120-130° water, yeast, and sugar, whisking together.",
			"Add 1/2 cup of flour and whisk together.",
			"Wait 15 minutes.",
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
		(ARRAY['Salt', 'Salt']::VARCHAR(64)[2]),
		(ARRAY['Yeast', 'Yeast']::VARCHAR(64)[2]),
		(ARRAY['Water', 'Water']::VARCHAR(64)[2]),
		(ARRAY['Sugar', 'Sugar']::VARCHAR(64)[2]),
		(ARRAY['Flour', 'Flour']::VARCHAR(64)[2])
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
			ARRAY['Salt', 'Salt']::VARCHAR(64)[2],
			ARRAY['Teaspoon', 'Teaspoons'],
			1.0, '', TRUE, ''
		),
		(
			ARRAY['Yeast', 'Yeast']::VARCHAR(64)[2],
			ARRAY['Packet', 'Packets'],
			1.0, '', TRUE, ''
		),
		(
			ARRAY['Water', 'Water']::VARCHAR(64)[2],
			ARRAY['Cup', 'Cups'],
			1.0, '', TRUE, ''
		),
		(
			ARRAY['Sugar', 'Sugar']::VARCHAR(64)[2],
			ARRAY['Teaspoon', 'Teaspoons'],
			1.0, '', TRUE, ''
		),
		(
			ARRAY['Flour', 'Flour']::VARCHAR(64)[2],
			ARRAY['Cups', 'Cupss'],
			3.0, '', TRUE, ''
		)
	) AS "Temp"("Ingredients.names", "units", "amount", "quality", "is_required", "notes")
	JOIN "Recipes" ON "Recipes"."name" = RecipeName
	LEFT JOIN "Ingredients" ON "Temp"."Ingredients.names" = "Ingredients"."names";

END $$;
