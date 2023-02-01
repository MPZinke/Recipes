
/***********************************************************************************************************************
*                                                                                                                      *
*   created by: Morgan Pothoff                                                                                         *
*   on 2023.01.21                                                                                                      *
*                                                                                                                      *
*   DESCRIPTION: TEMPLATE                                                                                              *
*   BUGS:                                                                                                              *
*   FUTURE:                                                                                                            *
*                                                                                                                      *
***********************************************************************************************************************/


INSERT INTO "Recipes" ("name", "rating", "serving_size", "total_time", "prep_time", "cook_time", "instructions") VALUES
('Chocolate Chip Cookies', 5, 36, INTERVAL '30 MINUTES', INTERVAL '10 MINUTES', INTERVAL '8 MINUTES',  
	'[
		"Preheat oven to 375 degrees Farenheit. Line a baking pan with parchment paper and set aside.",
		"Mix flour, baking soda, salt, and baking powder in a bowl. Set aside.",
		"In a separate bowl, cream together butter and sugars until combined.",
		"Beat in eggs and vanilla until fluffy.",
		"Mix in the dry ingredients until combined.",
		"Add 12 oz package of chocolate chips and mix well.",
		"Roll 2-3 Tablespoons of dough at a time into balls and place them evenly spaced on your prepared cookie sheets.",
		"Bake in preheated oven for approximately ${timer::00:08:00}-${timer::00:10:00}. Take them out when they are just BARELY starting to turn brown.",
		"Let them sit on the baking pan for ${timer::00:02:00} before removing to cooling rack.",
		"Repeat until all cookies dough has been baked."
	]'
);


INSERT INTO "Ingredients" ("name") VALUES
(ARRAY['Salted Butter', 'Salted Butter']);
INSERT INTO "Ingredients" ("name") VALUES
(ARRAY['Sugar', 'Sugar']);
INSERT INTO "Ingredients" ("name") VALUES
(ARRAY['Light Brown Sugar', 'Light Brown Sugar']);
INSERT INTO "Ingredients" ("name") VALUES
(ARRAY['Vanilla Extract', 'Vanilla Extract']);
INSERT INTO "Ingredients" ("name") VALUES
(ARRAY['Egg', 'Eggs']);
INSERT INTO "Ingredients" ("name") VALUES
(ARRAY['All-Purose Flour', 'All-Purose Flour']);
INSERT INTO "Ingredients" ("name") VALUES
(ARRAY['Baking Soda', 'Baking Soda']);
INSERT INTO "Ingredients" ("name") VALUES
(ARRAY['Baking Powder', 'Baking Powder']);
INSERT INTO "Ingredients" ("name") VALUES
(ARRAY['Sea Salt', 'Sea Salt']);
INSERT INTO "Ingredients" ("name") VALUES
(ARRAY['Chocolate Chips', 'Chocolate Chips']);


INSERT INTO "RecipesIngredients" ("Recipes.id", "Ingredients.id", "amount", "units", "quality", "is_required", "notes")
SELECT "Recipes"."id", "Ingredients"."id", "Temp"."amount", "Temp"."units", "Temp"."quality", "Temp"."is_required",
  "Temp"."notes"
FROM
(
	VALUES
	(
		'Chocolate Chip Cookies', ARRAY['Salted Butter', 'Salted Butter']::VARCHAR(64)[2],
		1.0, ARRAY['Cup', 'Cups'],
		'Softened', TRUE, ''
	),
	(
		'Chocolate Chip Cookies', ARRAY['Sugar', 'Sugar']::VARCHAR(64)[2],
		1.0, ARRAY['Cup', 'Cups'],
		'Granulated', TRUE, ''
	),
	(
		'Chocolate Chip Cookies', ARRAY['Light Brown Sugar', 'Light Brown Sugar']::VARCHAR(64)[2],
		1.0, ARRAY['Cup', 'Cups'],
		'Packed', TRUE, ''
	),
	(
		'Chocolate Chip Cookies', ARRAY['Vanilla Extract', , 'Vanilla Extract']::VARCHAR(64)[2],
		2.0, ARRAY['Teaspoon', 'Teaspoon'],
		'', TRUE, ''
	),
	(
		'Chocolate Chip Cookies', ARRAY['Egg', 'Eggs']::VARCHAR(64)[2],
		2.0, ARRAY['', ''],
		'Large', TRUE, ''
	),
	(
		'Chocolate Chip Cookies', ARRAY['All-Purose Flour', 'All-Purose Flour']::VARCHAR(64)[2],
		3.0, ARRAY['Cup', 'Cups'],
		'', TRUE, ''
	),
	(
		'Chocolate Chip Cookies', ARRAY['Baking Soda', 'Baking Soda']::VARCHAR(64)[2],
		1.0, ARRAY['Teaspoon', 'Teaspoon'],
		'', TRUE, ''
	),
	(
		'Chocolate Chip Cookies', ARRAY['Baking Powder', 'Baking Powder']::VARCHAR(64)[2],
		0.5, ARRAY['Teaspoon', 'Teaspoon'],
		'', TRUE, ''
	),
	(
		'Chocolate Chip Cookies', ARRAY['Sea Salt', 'Sea Salt']::VARCHAR(64)[2],
		1.0, ARRAY['Teaspoon', 'Teaspoon'],
		'', FALSE, ''
	),
	(
		'Chocolate Chip Cookies', ARRAY['Chocolate Chips', 'Chocolate Chips']::VARCHAR(64)[2],
		2.0, ARRAY['Cup', 'Cups'],
		'', TRUE, ''
	)
) AS "Temp"("Recipes.name", "Ingredients.name", "amount", "units", "quality", "is_required", "notes")
JOIN "Recipes" ON "Temp"."Recipes.name" = "Recipes"."name"
JOIN "Ingredients" ON "Temp"."Ingredients.name" = "Ingredients"."name";
