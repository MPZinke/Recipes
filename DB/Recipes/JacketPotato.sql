
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


INSERT INTO "Recipes" ("name", "rating", "serving_size", "time", "instructions") VALUES
('Jacket Potatoes', 4, 1, INTERVAL '4 HOURS', 
'[
	"Slice a cross shape about 1/4-inch thick into each potato. This helps them release some steam, makes the interior more fluffy, and also makes them easier to slice into when they''re piping hot.",
	"Bake at 400°F for ${timer::02:00:00}. The potatoes won''t burn at this temperature and the long bake means the skin will be so crisp that it''s practically cracker-like.",
	"After the two hours are up, remove the potatoes and carefully cut deeper into the slices you made initially. Then put the potatoes back in the oven for ${timer::00:10:00}. This helps to dry out the flesh further and makes it extra fluffy."
]');



INSERT INTO "Ingredients" ("brand", "name", "description") VALUES
('', 'Russet Potatoes', ''),
('', 'Sea Salt', ''),
('', 'Black Pepper', ''),
('', 'Chives', ''),
('', 'Salted Butter', ''),
('', 'Sour Cream', '');


INSERT INTO "RecipesIngredients" ("Recipes.id", "Ingredients.id", "amount", "quantity", "is_required", "notes")
SELECT "Recipes"."id", "Ingredients"."id", "Temp"."amount", "Temp"."quantity", "Temp"."is_required", "Temp"."notes"
FROM
(
	VALUES
	('Jacket Potatoes', 'Russet Potatoes', 1, 'Medium', TRUE, ''),
	('Jacket Potatoes', 'Sea Salt', 0, 'Course', FALSE, ''),
	('Jacket Potatoes', 'Black Pepper', 0, 'Ground', FALSE, ''),
	('Jacket Potatoes', 'Chives', 0, '', FALSE, 'for garnish'),
	('Jacket Potatoes', 'Salted Butter', 0, '', FALSE, ''),
	('Jacket Potatoes', 'Sour Cream', 0, '', FALSE, '')
) AS "Temp"("Recipes.name", "Ingredients.name", "amount", "quantity", "is_required", "notes")
JOIN "Recipes" ON "Temp"."Recipes.name" = "Recipes"."name"
JOIN "Ingredients" ON "Temp"."Ingredients.name" = "Ingredients"."name";
