
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
('Chocolate Chip Cookies', 5, 36, INTERVAL '30 Minutes', INTERVAL '10 Minutes', INTERVAL '8 Minutes',  
'[
	"Preheat oven to 375 degrees Farenheit. Line a baking pan with parchment paper and set aside.",
	"Mix flour, baking soda, salt, and baking powder in a bowl. Set aside.",
	"In a separate bowl, cream together butter and sugars until combined.",
	"Beat in eggs and vanilla until fluffy.",
	"Mix in the dry ingredients until combined.",
	"Add 12 oz package of chocolate chips and mix well.",
	"Roll 2-3 Table Spoons of dough at a time into balls and place them evenly spaced on your prepared cookie sheets.",
	"Bake in preheated oven for approximately 8-10 minutes. Take them out when they are just BARELY starting to turn brown.",
	"Let them sit on the baking pan for 2 minutes before removing to cooling rack.",
	"Repeat until all cookies dough has been baked."
]');


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


INSERT INTO "RecipesIngredients" ("Recipes.id", "Ingredients.id", "amount", "quantity", "is_required", "notes")
SELECT "Recipes"."id", "Ingredients"."id", "Temp"."amount", "Temp"."quantity", "Temp"."is_required", "Temp"."notes"
FROM
(
	VALUES
	('Chocolate Chip Cookies', 'Salted Butter', 1, 'Cup', TRUE, 'Softened'),
	('Chocolate Chip Cookies', 'Sugar', 1, 'Cup', TRUE, 'Granulated'),
	('Chocolate Chip Cookies', 'Light Brown Sugar', 1, 'Ground', TRUE, 'Packed'),
	('Chocolate Chip Cookies', 'Vanilla Extract', 2, 'Tea Spoons', TRUE, ''),
	('Chocolate Chip Cookies', 'Eggs', 2, 'Large', TRUE, ''),
	('Chocolate Chip Cookies', 'All-Purose Flour', 3, 'Cups', TRUE, ''),
	('Chocolate Chip Cookies', 'Baking Soda', 1, 'Tea Spoon', TRUE, ''),
	('Chocolate Chip Cookies', 'Baking Powder', 0.5, 'Tea Spoon', TRUE, ''),
	('Chocolate Chip Cookies', 'Sea Salt', 1, 'Tea Spoon', FALSE, ''),
	('Chocolate Chip Cookies', 'Chocolate Chips', 2, 'Cups', TRUE, '')
) AS "Temp"("Recipes.name", "Ingredients.name", "amount", "quantity", "is_required", "notes")
JOIN "Recipes" ON "Temp"."Recipes.name" = "Recipes"."name"
JOIN "Ingredients" ON "Temp"."Ingredients.name" = "Ingredients"."name";
