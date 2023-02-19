
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
	RecipeName := 'Sloppy Joe';


	INSERT INTO "Recipes" ("name", "rating", "servings", "total_time", "prep_time", "cook_time", "url", "instructions") VALUES
	(RecipeName, 3, 4, INTERVAL '30 MINUTES', INTERVAL '10 MINUTES', INTERVAL '20 MINUTES',
		'https://natashaskitchen.com/sloppy-joe-recipe/',
		'[
			"Finely chop the onion.",
			"Seed and finely dice the green pepper.",
			"In a bowl, combine the Worcestershire sauce, mustard, brown sugar, and tomato sauce.",
			"Place a large skillet or dutch oven over medium/high heat.",
			"Add olive oil and ground beef.",
			"Saute the beef for about 5 minutes until cooked through and no longer pink, breaking it up with a spatula.",
			"Season with salt and pepper and add in the diced peppers and onion.",
			"Cook another 5 minutes until the veggies are tender and beef is browned.",
			"Add the minced garlic and saute 30 seconds until fragrant, stirring constantly.",
			"Add in the sauce and bring to a light boil.",
			"Reduce heat to low and simmer uncovered for about 10-15 minutes or until thickened to your liking.",
			"Season to taste with salt and pepper and add water if you prefer a looser consistency.",
			"Serve on toasted buns for Sloppy Joe Sandwiches."
		]'
	);


	INSERT INTO "Ingredients" ("names")
	SELECT "Temp"."names"
	FROM
	(
		VALUES
		(ARRAY['Ground Beef', 'Ground Beef']::VARCHAR(64)[2]),
		(ARRAY['Green Pepper', 'Green Peppers']::VARCHAR(64)[2]),
		(ARRAY['Onion', 'Onions']::VARCHAR(64)[2]),
		(ARRAY['Garlic', 'Garlic']::VARCHAR(64)[2]),
		(ARRAY['Tomato Sauce', 'Tomato Sauce']::VARCHAR(64)[2]),
		(ARRAY['Brown Sugar', 'Brown Sugar']::VARCHAR(64)[2]),
		(ARRAY['Yellow Mustard', 'Yellow Mustard']::VARCHAR(64)[2]),
		(ARRAY['Worcestershire Sauce', 'Worcestershire Sauce']::VARCHAR(64)[2]),
		(ARRAY['Olive Oil', 'Olive Oil']::VARCHAR(64)[2]),
		(ARRAY['Salt', 'Salt']::VARCHAR(64)[2]),
		(ARRAY['Black Pepper', 'Black Pepper']::VARCHAR(64)[2]),
		(ARRAY['Hamburger Bun', 'Hamburger Buns']::VARCHAR(64)[2])
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
			ARRAY['Ground Beef', 'Ground Beef']::VARCHAR(64)[2],
			ARRAY['Pound', 'Pounds'],
			1.0, '', TRUE, '85%-90% Lean'
		),
		(
			ARRAY['Green Pepper', 'Green Peppers']::VARCHAR(64)[2],
			ARRAY['', ''],
			0.5, 'Finely Diced', TRUE, ''
		),
		(
			ARRAY['Onion', 'Onions']::VARCHAR(64)[2],
			ARRAY['', ''],
			1.0, 'Small Finely Chopped', TRUE, ''
		),
		(
			ARRAY['Garlic', 'Garlic']::VARCHAR(64)[2],
			ARRAY['Clove', 'Cloves'],
			3.0, 'Minced', TRUE, ''
		),
		(
			ARRAY['Tomato Sauce', 'Tomato Sauce']::VARCHAR(64)[2],
			ARRAY['Can', 'Cans'],
			1.0, '15 oz', TRUE, ''
		),
		(
			ARRAY['Brown Sugar', 'Brown Sugar']::VARCHAR(64)[2],
			ARRAY['Tablespoon', 'Tablespoons'],
			1.0, '', TRUE, ''
		),
		(
			ARRAY['Yellow Mustard', 'Yellow Mustard']::VARCHAR(64)[2],
			ARRAY['Teaspoon', 'Teaspoons'],
			1.0, '', TRUE, ''
		),
		(
			ARRAY['Worcestershire Sauce', 'Worcestershire Sauce']::VARCHAR(64)[2],
			ARRAY['Tablespoon', 'Tablespoons'],
			1.0, 'Chopped', TRUE, ''
		),
		(
			ARRAY['Olive Oil', 'Olive Oil']::VARCHAR(64)[2],
			ARRAY['Tablespoon', 'Tablespoons'],
			1.0, '', TRUE, ''
		),
		(
			ARRAY['Salt', 'Salt']::VARCHAR(64)[2],
			ARRAY['Tablespoon', 'Tablespoons'],
			0.5, '', TRUE, ''
		),
		(
			ARRAY['Black Pepper', 'Black Pepper']::VARCHAR(64)[2],
			ARRAY['Teaspoon', 'Teaspoons'],
			0.25, '', TRUE, ''
		),
		(
			ARRAY['Hamburger Bun', 'Hamburger Buns']::VARCHAR(64)[2],
			ARRAY['', ''],
			4.0, '', FALSE, ''
		)
	) AS "Temp"("Ingredients.names", "units", "amount", "quality", "is_required", "notes")
	JOIN "Recipes" ON "Recipes"."name" = RecipeName
	LEFT JOIN "Ingredients" ON "Temp"."Ingredients.names" = "Ingredients"."names";

END $$;
