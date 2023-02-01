
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


INSERT INTO "Recipes" ("name", "rating", "serving_size", "total_time", "cook_time", "prep_time", "instructions") VALUES
('Banana Bread', 5, 3, INTERVAL '1 HOURS 20 MINUTES', INTERVAL '50 MINUTES', INTERVAL '30 MINUTES',
	'[
		"Combine and stir dry ingredients.",
		"Combine and stir wet ingredients.",
		"Combine mixtures. Do not over stir.",
		"Optionally add pecans.",
		"Bake at 350°F for approximately ${timer::00:50:00} or until the toothpick comes out clean.",
		"Enjoy!"
	]'
);


INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Sugar', 'Sugar']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['All-Purose Flour', 'All-Purose Flour']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Salted Butter', 'Salted Butter']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Egg', 'Eggs']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Banana', 'Bananas']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Butter Milk', 'Butter Milk']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Baking Soda', 'Baking Soda']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Sour Cream', 'Sour Cream']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Vanilla Extract', 'Vanilla Extract']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Pecan', 'Pecans']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Chocolate Chips', 'Chocolate Chips']);


INSERT INTO "RecipesIngredients" ("Recipes.id", "Ingredients.id", "amount", "units", "quality", "is_required", "notes")
SELECT "Recipes"."id", "Ingredients"."id", "Temp"."amount", "Temp"."units", "Temp"."quality", "Temp"."is_required",
  "Temp"."notes"
FROM
(
	VALUES
	(
		'Banana Bread', ARRAY['Sugar', 'Sugar']::VARCHAR(64)[2], 
		3.0, ARRAY['Cup', 'Cups'],
		'', TRUE, ''
	),
	(
		'Banana Bread', ARRAY['All-Purose Flour', 'All-Purose Flour']::VARCHAR(64)[2], 
		3.0, ARRAY['Cup', 'Cups'],
		'', TRUE, ''
	),
	(
		'Banana Bread', ARRAY['Salted Butter', 'Salted Butter']::VARCHAR(64)[2], 
		1.0, ARRAY['Cup', 'Cups'],
		'Melted', TRUE, 'Melted'
	),
	(
		'Banana Bread', ARRAY['Egg', 'Eggs']::VARCHAR(64)[2], 
		4.0, ARRAY['', ''],
		'Large', TRUE, ''
	),
	(
		'Banana Bread', ARRAY['Banana', 'Bananas']::VARCHAR(64)[2], 
		2.0, ARRAY['Cup', 'Cups'],
		'Mashed', TRUE, ''
	),
	(
		'Banana Bread', ARRAY['Butter Milk', 'Butter Milk']::VARCHAR(64)[2], 
		0.5, ARRAY['Cup', 'Cups'],
		'', TRUE, ''
	),
	(
		'Banana Bread', ARRAY['Baking Soda', 'Baking Soda']::VARCHAR(64)[2], 
		2.0, ARRAY['Teaspoon', 'Teaspoons'],
		'', TRUE, ''
	),
	(
		'Banana Bread', ARRAY['Vanilla Extract', 'Vanilla Extract']::VARCHAR(64)[2], 
		2.0, ARRAY['Teaspoon', 'Teaspoons'],
		'', TRUE, ''
	),
	(
		'Banana Bread', ARRAY['Pecan', 'Pecans']::VARCHAR(64)[2], 
		2.0, ARRAY['Cup', 'Cups'],
		'Chopped', FALSE, ''
	),
	(
		'Banana Bread', ARRAY['Chocolate Chips', 'Chocolate Chips']::VARCHAR(64)[2], 
		2.0, ARRAY['Cup', 'Cups'],
		'', FALSE, ''
	)
) AS "Temp"("Recipes.name", "Ingredients.name", "amount", "units", "quality", "is_required", "notes")
JOIN "Recipes" ON "Temp"."Recipes.name" = "Recipes"."name"
JOIN "Ingredients" ON "Temp"."Ingredients.name" = "Ingredients"."names";
