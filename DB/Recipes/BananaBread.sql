
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


INSERT INTO "Ingredients" ("name") VALUES
('Sugar');
INSERT INTO "Ingredients" ("name") VALUES
('All-Purose Flour');
INSERT INTO "Ingredients" ("name") VALUES
('Salted Butter');
INSERT INTO "Ingredients" ("name") VALUES
('Eggs');
INSERT INTO "Ingredients" ("name") VALUES
('Banana');
INSERT INTO "Ingredients" ("name") VALUES
('Butter Milk');
INSERT INTO "Ingredients" ("name") VALUES
('Baking Soda');
INSERT INTO "Ingredients" ("name") VALUES
('Sour Cream');
INSERT INTO "Ingredients" ("name") VALUES
('Vanilla Extract');
INSERT INTO "Ingredients" ("name") VALUES
('Pecans');
INSERT INTO "Ingredients" ("name") VALUES
('Chocolate Chips');


INSERT INTO "RecipesIngredients" ("Recipes.id", "Ingredients.id", "amount", "quantity", "is_required", "notes")
SELECT "Recipes"."id", "Ingredients"."id", "Temp"."amount", "Temp"."quantity", "Temp"."is_required", "Temp"."notes"
FROM
(
	VALUES
	('Banana Bread', 'Sugar', 3, 'Cups', TRUE, ''),
	('Banana Bread', 'All-Purose Flour', 3, 'Cups', TRUE, ''),
	('Banana Bread', 'Salted Butter', 1, 'Cup Melted', TRUE, ''),
	('Banana Bread', 'Eggs', 4, 'Large', TRUE, ''),
	('Banana Bread', 'Banana', 2, 'Cups Mashed', TRUE, ''),
	('Banana Bread', 'Butter Milk', 0, '½ Cup', TRUE, ''),
	('Banana Bread', 'Baking Soda', 2, 'Teaspoons', TRUE, ''),
	('Banana Bread', 'Vanilla Extract', 2, 'Teaspoons', TRUE, ''),
	('Banana Bread', 'Pecans', 2, 'Cups Chopped', FALSE, ''),
	('Banana Bread', 'Chocolate Chips', 2, 'Cups', FALSE, '')
) AS "Temp"("Recipes.name", "Ingredients.name", "amount", "quantity", "is_required", "notes")
JOIN "Recipes" ON "Temp"."Recipes.name" = "Recipes"."name"
JOIN "Ingredients" ON "Temp"."Ingredients.name" = "Ingredients"."name";
