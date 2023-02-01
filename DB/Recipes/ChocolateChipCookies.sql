
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
('Salted Butter');
INSERT INTO "Ingredients" ("name") VALUES
('Sugar');
INSERT INTO "Ingredients" ("name") VALUES
('Light Brown Sugar');
INSERT INTO "Ingredients" ("name") VALUES
('Vanilla Extract');
INSERT INTO "Ingredients" ("name") VALUES
('Eggs');
INSERT INTO "Ingredients" ("name") VALUES
('All-Purose Flour');
INSERT INTO "Ingredients" ("name") VALUES
('Baking Soda');
INSERT INTO "Ingredients" ("name") VALUES
('Baking Powder');
INSERT INTO "Ingredients" ("name") VALUES
('Sea Salt');
INSERT INTO "Ingredients" ("name") VALUES
('Chocolate Chips');


INSERT INTO "RecipesIngredients" ("Recipes.id", "Ingredients.id", "amount", "units", "quality", "is_required", "notes")
SELECT "Recipes"."id", "Ingredients"."id", "Temp"."amount", "Temp"."units", "Temp"."quality", "Temp"."is_required",
  "Temp"."notes"
FROM
(
	VALUES
	('Chocolate Chip Cookies', 'Salted Butter', 1.0, ARRAY['Cup', 'Cups'], 'Softened', TRUE, ''),
	('Chocolate Chip Cookies', 'Sugar', 1.0, ARRAY['Cup', 'Cups'], 'Granulated', TRUE, ''),
	('Chocolate Chip Cookies', 'Light Brown Sugar', 1.0, ARRAY['Cup', 'Cups'], 'Packed', TRUE, ''),
	('Chocolate Chip Cookies', 'Vanilla Extract', 2.0, ARRAY['Teaspoon', 'Teaspoon'], '', TRUE, ''),
	('Chocolate Chip Cookies', 'Eggs', 2.0, ARRAY['', ''], 'Large', TRUE, ''),
	('Chocolate Chip Cookies', 'All-Purose Flour', 3.0, ARRAY['Cup', 'Cups'], '', TRUE, ''),
	('Chocolate Chip Cookies', 'Baking Soda', 1.0, ARRAY['Teaspoon', 'Teaspoon'], '', TRUE, ''),
	('Chocolate Chip Cookies', 'Baking Powder', 0.5, ARRAY['Teaspoon', 'Teaspoon'], '', TRUE, ''),
	('Chocolate Chip Cookies', 'Sea Salt', 1.0, ARRAY['Teaspoon', 'Teaspoon'], '', FALSE, ''),
	('Chocolate Chip Cookies', 'Chocolate Chips', 2.0, ARRAY['Cup', 'Cups'], '', TRUE, '')
) AS "Temp"("Recipes.name", "Ingredients.name", "amount", "units", "quality", "is_required", "notes")
JOIN "Recipes" ON "Temp"."Recipes.name" = "Recipes"."name"
JOIN "Ingredients" ON "Temp"."Ingredients.name" = "Ingredients"."name";
