
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
	RecipeName := 'Turkey Stuffed Bell Peppers';


	INSERT INTO "Recipes" ("name", "rating", "servings", "prep_time", "cook_time", "total_time", "url", "instructions") VALUES
	(RecipeName, 4, 4, INTERVAL '10 MINUTES', INTERVAL '50 MINUTES', INTERVAL '1 HOURS',
		'https://www.rachelpaulsfood.com/low-fodmap-turkey-stuffed-bell-peppers-gluten-free/',
		'[
			"Start preparing rice.",
			"Cut peppers in half and remove insides.",
			"Cut green onions.",
			"Heat frying pan to medium-high.",
			"Lay your cut peppers in your casserole dish.",
			"Preheat oven to 375°F.",
			"Add infused oil to frying pan.",
			"Brown green onion tips, and any remaining pepper tops in the oil for 1-2 minutes.",
			"Add your ground turkey or beef, and cook until browned through, about 5-7 minutes.",
			"Season with your salt and pepper.",
			"Remove turkey mixture from heat.",
			"Add cooked rice, Marinara, and 1 cup of shredded cheese.",
			"Add salt and pepper to taste.",
			"Scoop your mixture evenly into the hollowed peppers.",
			"Top with the remaining 1/2 cup cheese.",
			"Place in preheated oven and bake until peppers are tender, and mixture warmed through, about 30-45 minutes.",
			"Remove from oven and serve immediately, garnished with fresh parsley."
		]'
	);


	INSERT INTO "Ingredients" ("names")
	SELECT "Temp"."names"
	FROM
	(
		VALUES
		(ARRAY['Ground Turkey', 'Ground Turkey']::VARCHAR(64)[2]),
		(ARRAY['Salt', 'Salt']::VARCHAR(64)[2]),
		(ARRAY['Black Pepper', 'Black Pepper']::VARCHAR(64)[2]),
		(ARRAY['Garlic Infused Oil', 'Garlic Infused Oil']::VARCHAR(64)[2]),
		(ARRAY['Green Onion', 'Green Onions']::VARCHAR(64)[2]),
		(ARRAY['Rice', 'Rice']::VARCHAR(64)[2]),
		(ARRAY['Marinara', 'Marinara']::VARCHAR(64)[2]),
		(ARRAY['Mozzarella', 'Mozzarella']::VARCHAR(64)[2]),
		(ARRAY['Bell Pepper', 'Bell Peppers']::VARCHAR(64)[2]),
		(ARRAY['Parsley', 'Parsley']::VARCHAR(64)[2])
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
			(ARRAY['Ground Turkey', 'Ground Turkey']::VARCHAR(64)[2]),
			ARRAY['LB', 'LBS'],
			1.0, '', TRUE, ''
		),
		(
			(ARRAY['Salt', 'Salt']::VARCHAR(64)[2]),
			ARRAY['Teaspoon', 'Teaspoons'],
			0.5, '', TRUE, 'Plus to taste'
		),
		(
			(ARRAY['Black Pepper', 'Black Pepper']::VARCHAR(64)[2]),
			ARRAY['', ''],
			0.0, 'Ground', TRUE, 'To taste'
		),
		(
			(ARRAY['Garlic Infused Oil', 'Garlic Infused Oil']::VARCHAR(64)[2]),
			ARRAY['Tablespoon', 'Tablespoons'],
			1.0, '', TRUE, 'For garnish'
		),
		(
			(ARRAY['Green Onion', 'Green Onions']::VARCHAR(64)[2]),
			ARRAY['Tablespoon', 'Tablespoons'],
			2.0, '', TRUE, ''
		),
		(
			(ARRAY['Rice', 'Rice']::VARCHAR(64)[2]),
			ARRAY['', ''],
			0.0, '', TRUE, ''
		),
		(
			(ARRAY['Marinara', 'Marinara']::VARCHAR(64)[2]),
			ARRAY['Ounce', 'Ounces'],
			10.0, '', TRUE, ''
		),
		(
			(ARRAY['Mozzarella', 'Mozzarella']::VARCHAR(64)[2]),
			ARRAY['Cup', 'Cups'],
			1.5, '', TRUE, ''
		),
		(
			(ARRAY['Bell Pepper', 'Bell Peppers']::VARCHAR(64)[2]),
			ARRAY['', ''],
			4.0, '', TRUE, ''
		),
		(
			(ARRAY['Parsley', 'Parsley']::VARCHAR(64)[2]),
			ARRAY['', ''],
			0.0, 'Fresh', FALSE, ''
		)
	) AS "Temp"("Ingredients.names", "units", "amount", "quality", "is_required", "notes")
	JOIN "Recipes" ON "Recipes"."name" = RecipeName
	LEFT JOIN "Ingredients" ON "Temp"."Ingredients.names" = "Ingredients"."names";

END $$;
