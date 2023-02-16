
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


DO $$
DECLARE RecipeName VARCHAR(64);
BEGIN
	RecipeName := 'Banana Bread';


	INSERT INTO "Recipes" ("name", "rating", "servings", "total_time", "cook_time", "prep_time", "instructions") VALUES
	(RecipeName, 5, 3, INTERVAL '1 HOURS 20 MINUTES', INTERVAL '50 MINUTES', INTERVAL '30 MINUTES',
		'[
			"Combine and stir ${title::\\{\"title\": \"Sugar, Flour, Butter, Baking Soda\", \"text\": \"dry ingredients\"\\}}.",
			"Combine and stir ${title::\\{\"title\": \"Eggs, Banana, Butter Milk, Vanilla\", \"text\": \"wet ingredients\"\\}}.",
			"Combine mixtures. Do not over stir.",
			"Optionally add pecans.",
			"Bake at 350°F for approximately ${timer::00:50:00} or until the toothpick comes out clean.",
			"Enjoy!"
		]'
	);


	INSERT INTO "Ingredients" ("names")
	SELECT "Temp"."names"
	FROM
	(
		VALUES
		(ARRAY['Sugar', 'Sugar']::VARCHAR(64)[2]),
		(ARRAY['All-Purose Flour', 'All-Purose Flour']::VARCHAR(64)[2]),
		(ARRAY['Salted Butter', 'Salted Butter']::VARCHAR(64)[2]),
		(ARRAY['Egg', 'Eggs']::VARCHAR(64)[2]),
		(ARRAY['Banana', 'Bananas']::VARCHAR(64)[2]),
		(ARRAY['Butter Milk', 'Butter Milk']::VARCHAR(64)[2]),
		(ARRAY['Baking Soda', 'Baking Soda']::VARCHAR(64)[2]),
		(ARRAY['Sour Cream', 'Sour Cream']::VARCHAR(64)[2]),
		(ARRAY['Vanilla Extract', 'Vanilla Extract']::VARCHAR(64)[2]),
		(ARRAY['Pecan', 'Pecans']::VARCHAR(64)[2]),
		(ARRAY['Chocolate Chips', 'Chocolate Chips']::VARCHAR(64)[2])
	) AS "Temp" ("names")
	WHERE "Temp"."names" NOT IN
	(
		SELECT "names"
		FROM "Ingredients"
	);



	INSERT INTO "RecipesIngredients" ("Recipes.id", "Ingredients.id", "group", "amount", "units", "quality",
	  "is_required", "notes")
	SELECT "Recipes"."id", "Ingredients"."id", "Temp"."group", "Temp"."amount", "Temp"."units", "Temp"."quality",
	  "Temp"."is_required", "Temp"."notes"
	FROM
	(
		VALUES
		(
			ARRAY['Sugar', 'Sugar']::VARCHAR(64)[2],
			'Dry Ingredients',
			ARRAY['Cup', 'Cups'],
			3.0, '', TRUE, ''
		),
		(
			ARRAY['All-Purose Flour', 'All-Purose Flour']::VARCHAR(64)[2],
			'Dry Ingredients',
			ARRAY['Cup', 'Cups'],
			3.0, '', TRUE, ''
		),
		(
			ARRAY['Salted Butter', 'Salted Butter']::VARCHAR(64)[2],
			'Dry Ingredients',
			ARRAY['Cup', 'Cups'],
			1.0, 'Melted', TRUE, 'Melted'
		),
		(
			ARRAY['Egg', 'Eggs']::VARCHAR(64)[2],
			'Wet Ingredients',
			ARRAY['', ''],
			4.0, 'Large', TRUE, ''
		),
		(
			ARRAY['Banana', 'Bananas']::VARCHAR(64)[2],
			'Wet Ingredients',
			ARRAY['Cup', 'Cups'],
			2.0, 'Mashed', TRUE, ''
		),
		(
			ARRAY['Butter Milk', 'Butter Milk']::VARCHAR(64)[2],
			'Wet Ingredients',
			ARRAY['Cup', 'Cups'],
			0.5, '', TRUE, ''
		),
		(
			ARRAY['Baking Soda', 'Baking Soda']::VARCHAR(64)[2],
			'Dry Ingredients',
			ARRAY['Teaspoon', 'Teaspoons'],
			2.0, '', TRUE, ''
		),
		(
			ARRAY['Vanilla Extract', 'Vanilla Extract']::VARCHAR(64)[2],
			'Wet Ingredients',
			ARRAY['Teaspoon', 'Teaspoons'],
			2.0, '', TRUE, ''
		),
		(
			ARRAY['Pecan', 'Pecans']::VARCHAR(64)[2],
			'',
			ARRAY['Cup', 'Cups'],
			2.0, 'Chopped', FALSE, ''
		),
		(
			ARRAY['Chocolate Chips', 'Chocolate Chips']::VARCHAR(64)[2],
			'',
			ARRAY['Cup', 'Cups'],
			2.0, '', FALSE, ''
		)
	) AS "Temp"("Ingredients.names", "group", "units", "amount", "quality", "is_required", "notes")
	JOIN "Recipes" ON "Recipes"."name" = RecipeName
	LEFT JOIN "Ingredients" ON "Temp"."Ingredients.names" = "Ingredients"."names";

END $$;
