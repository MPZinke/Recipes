

/***********************************************************************************************************************
*                                                                                                                      *
*   created by: MPZinke                                                                                                *
*   on 2024.04.01                                                                                                      *
*                                                                                                                      *
*   DESCRIPTION: TEMPLATE                                                                                              *
*   BUGS:                                                                                                              *
*   FUTURE:                                                                                                            *
*                                                                                                                      *
***********************************************************************************************************************/


DO $$
DECLARE RecipeName VARCHAR(64);
BEGIN
	RecipeName := 'Coissant Chicken Sandwich';


	INSERT INTO "Recipes" ("name", "rating", "servings", "total_time", "prep_time", "cook_time", "url", "instructions") VALUES
	(RecipeName, 3, 4, INTERVAL '80 MINUTES', INTERVAL '20 MINUTES', INTERVAL '60 MINUTES',
		'',
		'[
			"Grill the chicken breasts.",
			"Slice and toast the croissants.",
			"Add cheese, chicken and honey mustard to the croissants."
		]'
	);


	INSERT INTO "Ingredients" ("names")
	SELECT "Temp"."names"
	FROM
	(
		VALUES
		(ARRAY['Croissant', 'Croissants']::VARCHAR(64)[2]),
		(ARRAY['Butter', 'Butter']::VARCHAR(64)[2]),
		(ARRAY['Honey Mustard', 'Honey Mustard']::VARCHAR(64)[2]),
		(ARRAY['Chicken Breast', 'Chicken Breasts']::VARCHAR(64)[2]),
		(ARRAY['Muenster Cheese', 'Muenster Cheese']::VARCHAR(64)[2])
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
			ARRAY['Croissant', 'Croissants']::VARCHAR(64)[2],
			ARRAY['', ''],
			8.0, '', TRUE, ''
		),
		(
			ARRAY['Honey Mustard', 'Honey Mustard']::VARCHAR(64)[2],
			ARRAY['Tablespoon', 'Tablespoons'],
			0.0, 'to tastes', TRUE, ''
		),
		(
			ARRAY['Butter', 'Butter']::VARCHAR(64)[2],
			ARRAY['Tablespoon', 'Tablespoons'],
			2.0, '', FALSE, ''
		),
		(
			ARRAY['Chicken Breast', 'Chicken Breasts']::VARCHAR(64)[2],
			ARRAY['', ''],
			4.0, '', TRUE, ''
		),
		(
			ARRAY['Muenster Cheese', 'Muenster Cheese']::VARCHAR(64)[2],
			ARRAY['Slices', 'Slicess'],
			8.0, '', TRUE, ''
		)
	) AS "Temp"("Ingredients.names", "units", "amount", "quality", "is_required", "notes")
	JOIN "Recipes" ON "Recipes"."name" = RecipeName
	LEFT JOIN "Ingredients" ON "Temp"."Ingredients.names" = "Ingredients"."names";

END $$;
