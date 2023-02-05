
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


INSERT INTO "Recipes" ("name", "rating", "servings", "total_time", "cook_time", "prep_time", "instructions") VALUES
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
(ARRAY['Sugar', 'Sugar'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['All-Purose Flour', 'All-Purose Flour'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Salted Butter', 'Salted Butter'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Egg', 'Eggs'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Banana', 'Bananas'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Butter Milk', 'Butter Milk'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Baking Soda', 'Baking Soda'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Sour Cream', 'Sour Cream'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Vanilla Extract', 'Vanilla Extract'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Pecan', 'Pecans'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Chocolate Chips', 'Chocolate Chips'])
ON CONFLICT ("names", "brand") DO NOTHING;


INSERT INTO "RecipesIngredients" ("Recipes.id", "Ingredients.id", "amount", "units", "quality", "is_required", "notes")
SELECT "Recipes"."id", "Ingredients"."id", "Temp"."amount", "Temp"."units", "Temp"."quality", "Temp"."is_required",
  "Temp"."notes"
FROM
(
	VALUES
	(
		ARRAY['Sugar', 'Sugar']::VARCHAR(64)[2], 
		ARRAY['Cup', 'Cups'],
		3.0, '', TRUE, ''
	),
	(
		ARRAY['All-Purose Flour', 'All-Purose Flour']::VARCHAR(64)[2], 
		ARRAY['Cup', 'Cups'],
		3.0, '', TRUE, ''
	),
	(
		ARRAY['Salted Butter', 'Salted Butter']::VARCHAR(64)[2], 
		ARRAY['Cup', 'Cups'],
		1.0, 'Melted', TRUE, 'Melted'
	),
	(
		ARRAY['Egg', 'Eggs']::VARCHAR(64)[2], 
		ARRAY['', ''],
		4.0, 'Large', TRUE, ''
	),
	(
		ARRAY['Banana', 'Bananas']::VARCHAR(64)[2], 
		ARRAY['Cup', 'Cups'],
		2.0, 'Mashed', TRUE, ''
	),
	(
		ARRAY['Butter Milk', 'Butter Milk']::VARCHAR(64)[2], 
		ARRAY['Cup', 'Cups'],
		0.5, '', TRUE, ''
	),
	(
		ARRAY['Baking Soda', 'Baking Soda']::VARCHAR(64)[2], 
		ARRAY['Teaspoon', 'Teaspoons'],
		2.0, '', TRUE, ''
	),
	(
		ARRAY['Vanilla Extract', 'Vanilla Extract']::VARCHAR(64)[2], 
		ARRAY['Teaspoon', 'Teaspoons'],
		2.0, '', TRUE, ''
	),
	(
		ARRAY['Pecan', 'Pecans']::VARCHAR(64)[2], 
		ARRAY['Cup', 'Cups'],
		2.0, 'Chopped', FALSE, ''
	),
	(
		ARRAY['Chocolate Chips', 'Chocolate Chips']::VARCHAR(64)[2], 
		ARRAY['Cup', 'Cups'],
		2.0, '', FALSE, ''
	)
) AS "Temp"("Ingredients.names", "units", "amount", "quality", "is_required", "notes")
JOIN "Recipes" ON "Recipes"."name" = 'Banana Bread'
LEFT JOIN "Ingredients" ON "Temp"."Ingredients.names" = "Ingredients"."names";
