
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
	RecipeName := 'Eggplant Parmesan';


	INSERT INTO "Recipes" ("name", "rating", "servings", "total_time", "prep_time", "cook_time", "url", "instructions") VALUES
	(RecipeName, 3, 4, INTERVAL '80 MINUTES', INTERVAL '20 MINUTES', INTERVAL '60 MINUTES',
		'https://irritablebowelsyndrom.net/recipes/eggplant-parmesan',
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
		(ARRAY['Garlic Oil', 'Garlic Oil']::VARCHAR(64)[2]),
		(ARRAY['Butter', 'Butter']::VARCHAR(64)[2]),
		(ARRAY['Bay Leaf', 'Bay Leaves']::VARCHAR(64)[2]),
		(ARRAY['Crushed Tomatoes', 'Crushed Tomatoes']::VARCHAR(64)[2]),
		(ARRAY['Oregano', 'Oregano']::VARCHAR(64)[2]),
		(ARRAY['Basil', 'Basil']::VARCHAR(64)[2]),
		(ARRAY['Sugar', 'Sugar']::VARCHAR(64)[2]),
		(ARRAY['Black Pepper', 'Black Pepper']::VARCHAR(64)[2]),
		(ARRAY['Salt', 'Salt']::VARCHAR(64)[2]),
		(ARRAY['Water', 'Water']::VARCHAR(64)[2]),
		(ARRAY['Eggplant', 'Eggplants']::VARCHAR(64)[2]),
		(ARRAY['Vegetable Oil', 'Vegetable Oil']::VARCHAR(64)[2]),
		(ARRAY['Corn Starch', 'Corn Starch']::VARCHAR(64)[2]),
		(ARRAY['Provolone Cheese', 'Provolone Cheese']::VARCHAR(64)[2]),
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
			ARRAY['Garlic Oil', 'Garlic Oil']::VARCHAR(64)[2],
			ARRAY['Tablespoon', 'Tablespoons'],
			2.0, '', TRUE, ''
		),
		(
			ARRAY['Butter', 'Butter']::VARCHAR(64)[2],
			ARRAY['Tablespoon', 'Tablespoons'],
			2.0, '', TRUE, ''
		),
		(
			ARRAY['Bay Leaf', 'Bay Leaves']::VARCHAR(64)[2],
			ARRAY['', ''],
			2.0, '', TRUE, ''
		),
		(
			ARRAY['Crushed Tomatoes', 'Crushed Tomatoes']::VARCHAR(64)[2],
			ARRAY['Can', 'Cans'],
			2.0, '14 oz ', TRUE, ''
		),
		(
			ARRAY['Oregano', 'Oregano']::VARCHAR(64)[2],
			ARRAY['Tablespoon', 'Tablespoons'],
			1.0, 'Dried', TRUE, ''
		),
		(
			ARRAY['Basil', 'Basil']::VARCHAR(64)[2],
			ARRAY['Tablespoon', 'Tablespoons'],
			1.0, 'Dried', TRUE, ''
		),
		(
			ARRAY['Sugar', 'Sugar']::VARCHAR(64)[2],
			ARRAY['Teaspoon', 'Teaspoons'],
			3.0, '', TRUE, ''
		),
		(
			ARRAY['Black Pepper', 'Black Pepper']::VARCHAR(64)[2],
			ARRAY['', ''],
			0.0, '', TRUE, 'To taste'
		),
		(
			ARRAY['Salt', 'Salt']::VARCHAR(64)[2],
			ARRAY['', ''],
			0.0, '', TRUE, 'To taste'
		),
		(
			ARRAY['Water', 'Water']::VARCHAR(64)[2],
			ARRAY['Cup', 'Cups'],
			1.0, '', TRUE, ''
		),
		(
			ARRAY['Eggplant', 'Eggplants']::VARCHAR(64)[2],
			ARRAY['', ''],
			1.0, 'Medium', TRUE, ''
		),
		(
			ARRAY['Vegetable Oil', 'Vegetable Oil']::VARCHAR(64)[2],
			ARRAY['Cup', 'Cups'],
			1.0, '', TRUE, 'For frying'
		),
		(
			ARRAY['Corn Starch', 'Corn Starch']::VARCHAR(64)[2],
			ARRAY['Cup', 'Cups'],
			0.5, '', TRUE, ''
		),
		(
			ARRAY['Provolone Cheese', 'Provolone Cheese']::VARCHAR(64)[2],
			ARRAY['Slice', 'Slices'],
			12.0, '', TRUE, ''
		),
		(
			ARRAY['Parsley', 'Parsley']::VARCHAR(64)[2],
			ARRAY['Handful', 'Handfuls'],
			1.0, 'Chopped', TRUE, ''
		)
	) AS "Temp"("Ingredients.names", "units", "amount", "quality", "is_required", "notes")
	JOIN "Recipes" ON "Recipes"."name" = RecipeName
	LEFT JOIN "Ingredients" ON "Temp"."Ingredients.names" = "Ingredients"."names";

END $$;
