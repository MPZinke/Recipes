
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


-- https://healthyfitnessmeals.com/honey-garlic-chicken/#recipe


INSERT INTO "Recipes" ("name", "rating", "serving_size", "total_time", "instructions") VALUES
('Honey Garlic Chicken', 3, 3, INTERVAL '4 HOURS', 
	'[
		"Prepare 2 bowls, one with beaten egg, and the second with cornstarch mixed with a pinch of salt and pepper.",
		"Dip the chicken into the beaten egg. Place all the pieces into the cornstarch and toss to lightly and evenly coat.",
		"Heat the oil in a non-stick skillet over medium heat. Add the chicken pieces in a single layer without overlapping.",
		"Cook until golden brown on all sides, about 8-10 minutes.",
		"In a medium bowl whisk all the sauce ingredients. Pour sauce over the chicken and toss to coat then set aside.",
		"Quickly wipe the pan clean with a paper towel, and add in the remaining oil.",
		"Preheat skillet again, stir fry the broccoli until they start to brown. About 2-3 minutes. Season with a pinch of salt and pepper and set aside.",
		"Add about 1/2 cup of cooked quinoa to each meal prep bowl. Divide the broccoli and chicken among your bowls and arrange over the quinoa.",
		"Garnish with green onions, sesame seeds, and lime wedges.",
		"Refrigerated for up to 4 days. Serve cold or reheated, as desired."
	]'
);


INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Chicken Breast', 'Chicken Breasts'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Egg', 'Eggs'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Corn Starch', 'Corn Starch'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Salt', 'Salt'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Broccoli', 'Broccoli'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Sesame Oil', 'Sesame Oil'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Quinoa', 'Quinoa'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Honey', 'Honey'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Sriracha Sauce', 'Sriracha Sauce'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Garlic', 'Garlic'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Rice Vinegar', 'Rice Vinegar'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Green Onion', 'Green Onions'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Black White Sesame Seeds', 'Black White Sesame Seeds'])
ON CONFLICT ("names", "brand") DO NOTHING;


INSERT INTO "RecipesIngredients" ("Recipes.id", "Ingredients.id", "amount", "units", "quality", "is_required", "notes")
SELECT "Recipes"."id", "Ingredients"."id", "Temp"."amount", "Temp"."units", "Temp"."quality", "Temp"."is_required",
  "Temp"."notes"
FROM
(
	VALUES
	(
		ARRAY['Chicken Breast', 'Chicken Breasts']::VARCHAR(64)[2],
		ARRAY['', ''],
		4.0, '', TRUE, 'diced into 1-inch pieces'
	),
	(
		ARRAY['Egg', 'Eggs']::VARCHAR(64)[2],
		ARRAY['', ''],
		1.0, 'Large', TRUE, 'Beaten'
	),
	(
		ARRAY['Corn Starch', 'Corn Starch']::VARCHAR(64)[2],
		ARRAY['Tablespoon', 'Tablespoons'],
		2.0, '', TRUE, ''
	),
	(
		ARRAY['Salt', 'Salt']::VARCHAR(64)[2],
		ARRAY['Teaspoon', 'Teaspoons'],
		1.25, '', TRUE, ''
	),
	(
		ARRAY['Broccoli', 'Broccoli']::VARCHAR(64)[2],
		ARRAY['Head', 'Heads'],
		1.0, '', TRUE, 'cut into small florets'
	),
	(
		ARRAY['Sesame Oil', 'Sesame Oil']::VARCHAR(64)[2],
		ARRAY['Teaspoon', 'Teaspoons'],
		2.0, '', TRUE, ''
	),
	(
		ARRAY['Quinoa', 'Quinoa']::VARCHAR(64)[2],
		ARRAY['Cup', 'Cups'],
		2.0, 'Cooked', TRUE, ''
	),
	(
		ARRAY['Honey', 'Honey']::VARCHAR(64)[2],
		ARRAY['Tablespoon', 'Tablespoons'],
		2.0, '', TRUE, ''
	),
	(
		ARRAY['Sriracha Sauce', 'Sriracha Sauce']::VARCHAR(64)[2],
		ARRAY['Tablespoon', 'Tablespoons'],
		3.0, '', TRUE, ''
	),
	(
		ARRAY['Garlic', 'Garlic']::VARCHAR(64)[2],
		ARRAY['Clove', 'Cloves'],
		2.0, 'Minced', TRUE, ''
	),
	(
		ARRAY['Rice Vinegar', 'Rice Vinegar']::VARCHAR(64)[2],
		ARRAY['Tablespoon', 'Tablespoons'],
		1.0, '', TRUE, ''
	),
	(
		ARRAY['Sesame Oil', 'Sesame Oil']::VARCHAR(64)[2],
		ARRAY['Teaspoon', 'Teaspoons'],
		1.0, '', TRUE, ''
	),
	(
		ARRAY['Green Onion', 'Green Onions']::VARCHAR(64)[2],
		ARRAY['', ''],
		2.0, 'Thinly sliced', TRUE, ''
	),
	(
		ARRAY['Black White Sesame Seeds', 'Black White Sesame Seeds']::VARCHAR(64)[2],
		ARRAY['Teaspoon', 'Teaspoons'],
		1.0, '', FALSE, ''
	)
) AS "Temp"("Ingredients.names", "units", "amount", "quality", "is_required", "notes")
JOIN "Recipes" ON "Recipes"."name" = 'Honey Garlic Chicken'
LEFT JOIN "Ingredients" ON "Temp"."Ingredients.names" = "Ingredients"."names";