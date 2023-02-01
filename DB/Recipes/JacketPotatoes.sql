
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


INSERT INTO "Recipes" ("name", "rating", "serving_size", "total_time", "instructions") VALUES
('Jacket Potatoes', 4, 1, INTERVAL '4 HOURS', 
	'[
		"Slice a cross shape about 1/4-inch thick into each potato. This helps them release some steam, makes the interior more fluffy, and also makes them easier to slice into when they''re piping hot.",
		"Bake at 400°F for ${timer::02:00:00}. The potatoes won''t burn at this temperature and the long bake means the skin will be so crisp that it''s practically cracker-like.",
		"After the two hours are up, remove the potatoes and carefully cut deeper into the slices you made initially. Then put the potatoes back in the oven for ${timer::00:10:00}. This helps to dry out the flesh further and makes it extra fluffy."
	]'
);


INSERT INTO "Ingredients" ("name") VALUES
(ARRAY['Russet Potatoes', 'Russet Potatoes']);
INSERT INTO "Ingredients" ("name") VALUES
(ARRAY['Sea Salt', 'Sea Salt']);
INSERT INTO "Ingredients" ("name") VALUES
(ARRAY['Black Pepper', 'Black Pepper']);
INSERT INTO "Ingredients" ("name") VALUES
(ARRAY['Chives', 'Chives']);
INSERT INTO "Ingredients" ("name") VALUES
(ARRAY['Salted Butter', 'Salted Butter']);
INSERT INTO "Ingredients" ("name") VALUES
(ARRAY['Sour Cream', 'Sour Cream']);


INSERT INTO "RecipesIngredients" ("Recipes.id", "Ingredients.id", "amount", "units", "quality", "is_required", "notes")
SELECT "Recipes"."id", "Ingredients"."id", "Temp"."amount", "Temp"."units", "Temp"."quality", "Temp"."is_required",
  "Temp"."notes"
FROM
(
	VALUES
	(
		'Jacket Potatoes', ARRAY['Russet Potato', 'Russet Potatoes']::VARCHAR(64)[2],
		1.0, ARRAY['', ''],
		'Medium', TRUE, ''
	),
	(
		'Jacket Potatoes', ARRAY['Sea Salt', 'Sea Salt']::VARCHAR(64)[2],
		0.0, ARRAY['', ''],
		'Course', FALSE, ''
	),
	(
		'Jacket Potatoes', ARRAY['Black Pepper', 'Black Pepper']::VARCHAR(64)[2],
		0.0, ARRAY['', ''],
		'Ground', FALSE, ''
	),
	(
		'Jacket Potatoes', ARRAY['Chives', 'Chives']::VARCHAR(64)[2],
		0.0, ARRAY['', ''],
		'', FALSE, 'For garnish'
	),
	(
		'Jacket Potatoes', ARRAY['Salted Butter', 'Salted Butter']::VARCHAR(64)[2],
		0.0, ARRAY['', ''],
		'', FALSE, ''
	),
	(
		'Jacket Potatoes', ARRAY['Sour Cream', 'Sour Cream']::VARCHAR(64)[2],
		0.0, ARRAY['', ''],
		'', FALSE, ''
	)
) AS "Temp"("Recipes.name", "Ingredients.name", "amount", "units", "quality", "is_required", "notes")
JOIN "Recipes" ON "Temp"."Recipes.name" = "Recipes"."name"
JOIN "Ingredients" ON "Temp"."Ingredients.name" = "Ingredients"."name";
