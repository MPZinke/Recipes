
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


INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Salted Butter', 'Salted Butter']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Sugar', 'Sugar']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Light Brown Sugar', 'Light Brown Sugar']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Vanilla Extract', 'Vanilla Extract']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Egg', 'Eggs']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['All-Purose Flour', 'All-Purose Flour']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Baking Soda', 'Baking Soda']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Baking Powder', 'Baking Powder']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Salt', 'Salt']);
INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Chocolate Chips', 'Chocolate Chips']);


INSERT INTO "RecipesIngredients" ("Recipes.id", "Ingredients.id", "amount", "units", "quality", "is_required", "notes")
SELECT "Recipes"."id", "Ingredients"."id", "Temp"."amount", "Temp"."units", "Temp"."quality", "Temp"."is_required",
  "Temp"."notes"
FROM
(
	VALUES
	(
		ARRAY['Salted Butter', 'Salted Butter']::VARCHAR(64)[2],
		ARRAY['Cup', 'Cups'],
		1.0, 'Softened', TRUE, ''
	),
	(
		ARRAY['Sugar', 'Sugar']::VARCHAR(64)[2],
		ARRAY['Cup', 'Cups'],
		1.0, 'Granulated', TRUE, ''
	),
	(
		ARRAY['Light Brown Sugar', 'Light Brown Sugar']::VARCHAR(64)[2],
		ARRAY['Cup', 'Cups'],
		1.0, 'Packed', TRUE, ''
	),
	(
		ARRAY['Vanilla Extract', 'Vanilla Extract']::VARCHAR(64)[2],
		ARRAY['Teaspoon', 'Teaspoons'],
		2.0, '', TRUE, ''
	),
	(
		ARRAY['Egg', 'Eggs']::VARCHAR(64)[2],
		ARRAY['', ''],
		2.0, 'Large', TRUE, ''
	),
	(
		ARRAY['All-Purose Flour', 'All-Purose Flour']::VARCHAR(64)[2],
		ARRAY['Cup', 'Cups'],
		3.0, '', TRUE, ''
	),
	(
		ARRAY['Baking Soda', 'Baking Soda']::VARCHAR(64)[2],
		ARRAY['Teaspoon', 'Teaspoons'],
		1.0, '', TRUE, ''
	),
	(
		ARRAY['Baking Powder', 'Baking Powder']::VARCHAR(64)[2],
		ARRAY['Teaspoon', 'Teaspoons'],
		0.5, '', TRUE, ''
	),
	(
		ARRAY['Salt', 'Salt']::VARCHAR(64)[2],
		ARRAY['Teaspoon', 'Teaspoons'],
		1.0, 'Course', FALSE, ''
	),
	(
		ARRAY['Chocolate Chips', 'Chocolate Chips']::VARCHAR(64)[2],
		ARRAY['Cup', 'Cups'],
		2.0, '', TRUE, ''
	)
) AS "Temp"("Ingredients.names", "units", "amount", "quality", "is_required", "notes")
JOIN "Recipes" ON "Recipes"."name" = 'Chocolate Chip Cookies'
JOIN "Ingredients" ON "Temp"."Ingredients.names" = "Ingredients"."names";
