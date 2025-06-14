
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
	RecipeName := 'Jacket Potatoes';


	INSERT INTO "Recipes" ("name", "rating", "servings", "total_time", "instructions") VALUES
	(RecipeName, 4, 1, INTERVAL '4 HOURS', 
		'[
			"Slice a cross shape about 1/4-inch thick into each potato. This helps them release some steam, makes the interior more fluffy, and also makes them easier to slice into when they''re piping hot.",
			"Bake at 400°F for {{ timer(hours=2) }}. The potatoes won''t burn at this temperature and the long bake means the skin will be so crisp that it''s practically cracker-like.",
			"After the two hours are up, remove the potatoes and carefully cut deeper into the slices you made initially. Then put the potatoes back in the oven for {{ timer(minutes=10) }}. This helps to dry out the flesh further and makes it extra fluffy."
		]'
	);


	INSERT INTO "Ingredients" ("names")
	SELECT "Temp"."names"
	FROM
	(
		VALUES
		(ARRAY['Russet Potato', 'Russet Potatoes']::VARCHAR(64)[2]),
		(ARRAY['Salt', 'Salt']::VARCHAR(64)[2]),
		(ARRAY['Black Pepper', 'Black Pepper']::VARCHAR(64)[2]),
		(ARRAY['Chives', 'Chives']::VARCHAR(64)[2]),
		(ARRAY['Salted Butter', 'Salted Butter']::VARCHAR(64)[2]),
		(ARRAY['Sour Cream', 'Sour Cream']::VARCHAR(64)[2])
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
			ARRAY['Russet Potato', 'Russet Potatoes']::VARCHAR(64)[2],
			ARRAY['', ''],
			1.0, 'Medium', TRUE, ''
		),
		(
			ARRAY['Salt', 'Salt']::VARCHAR(64)[2],
			ARRAY['', ''],
			0.0, 'Course', FALSE, ''
		),
		(
			ARRAY['Black Pepper', 'Black Pepper']::VARCHAR(64)[2],
			ARRAY['', ''],
			0.0, 'Ground', FALSE, ''
		),
		(
			ARRAY['Chives', 'Chives']::VARCHAR(64)[2],
			ARRAY['', ''],
			0.0, '', FALSE, 'For garnish'
		),
		(
			ARRAY['Salted Butter', 'Salted Butter']::VARCHAR(64)[2],
			ARRAY['', ''],
			0.0, '', FALSE, ''
		),
		(
			ARRAY['Sour Cream', 'Sour Cream']::VARCHAR(64)[2],
			ARRAY['', ''],
			0.0, '', FALSE, ''
		)
	) AS "Temp"("Ingredients.names", "units", "amount", "quality", "is_required", "notes")
	JOIN "Recipes" ON "Recipes"."name" = RecipeName
	LEFT JOIN "Ingredients" ON "Temp"."Ingredients.names" = "Ingredients"."names";

END $$;
