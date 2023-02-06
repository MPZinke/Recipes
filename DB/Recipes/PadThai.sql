
/***********************************************************************************************************************
*                                                                                                                      *
*   created by: Morgan Pothoff                                                                                         *
*   on 2023.01.27                                                                                                      *
*                                                                                                                      *
*   DESCRIPTION: TEMPLATE                                                                                              *
*   BUGS:                                                                                                              *
*   FUTURE:                                                                                                            *
*                                                                                                                      *
***********************************************************************************************************************/


INSERT INTO "Recipes" ("name", "rating", "servings", "total_time", "prep_time", "cook_time", "instructions") VALUES
('Pad Thai', 5, 4, INTERVAL '30 MINUTES', INTERVAL '15 MINUTES', INTERVAL '15 MINUTES',  
	'[
		"Make sauce by combining sauce ingredients in a bowl. Set aside.",
		"Cook noodles according to package instructions, just until tender. When done, rinse under cold water.",
		"Stir Fry: Heat 1½ tablespoons of oil in a large saucepan over medium-high heat. Add the shrimp, chicken or tofu, garlic and bell pepper. The shrimp will cook quickly, about 1-2 minutes on each side, or until pink. If using chicken, cook until just cooked through, about 3-4 minutes, flipping only once.",
		"Push everything to the side of the pan. Add a little oil and add the beaten eggs. Scramble the eggs, breaking them into small pieces with a spatula as they cook.",
		"Add noodles, sauce, bean sprouts and peanuts to the pan (reserving some peanuts for topping at the end). Toss everything to combine.",
		"Garnish the top with green onions, extra peanuts, cilantro and lime wedges."
	]'
);


INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Flat Rice Noodles', 'Flat Rice Noodles'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Oil', 'Oil'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Garlic', 'Garlic'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Chicken Breast', 'Chicken Breasts'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Egg', 'Eggs'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Bean Sprout', 'Bean Sprouts'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Red Bell Pepper', 'Red Bell Peppers'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Green Onion', 'Green Onions'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Roasted Peanuts', 'Roasted Peanuts'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Lime', 'Limes'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Cilantro', 'Cilantro'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Fish Sauce', 'Fish Sauce'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Low-Sodium Soy Sauce', 'Low-Sodium Soy Sauce'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Light Brown Sugar', 'Light Brown Sugar'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Rice Vinegar', 'Rice Vinegar'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Sriracha Sauce', 'Sriracha Sauce'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Creamy Peanut Butter', 'Creamy Peanut Butter'])
ON CONFLICT ("names", "brand") DO NOTHING;



INSERT INTO "RecipesIngredients" ("Recipes.id", "Ingredients.id", "amount", "units", "quality", "is_required", "notes")
SELECT "Recipes"."id", "Ingredients"."id", "Temp"."amount", "Temp"."units", "Temp"."quality", "Temp"."is_required",
  "Temp"."notes"
FROM
(
	VALUES
	-- For Noodles
	(
		ARRAY['Flat Rice Noodles', 'Flat Rice Noodles']::VARCHAR(64)[2],
		ARRAY['Ounce', 'Ounces'],
		8.0, 'Softened', TRUE, ''
	),
	(
		ARRAY['Oil', 'Oil']::VARCHAR(64)[2],
		ARRAY['Tablespoon', 'Tablespoons'],
		3.0, '', TRUE, ''
	),
	(
		ARRAY['Garlic', 'Garlic']::VARCHAR(64)[2],
		ARRAY['Clove', 'Cloves'],
		3.0, 'Minced', TRUE, ''
	),
	(
		ARRAY['Chicken Breast', 'Chicken Breasts']::VARCHAR(64)[2],
		ARRAY['', ''],
		8.0, '', TRUE, 'Or shrimp or extra-firm tofu. Cut into small pieces'
	),
	(
		ARRAY['Egg', 'Eggs']::VARCHAR(64)[2],
		ARRAY['', ''],
		2.0, '', TRUE, 'Scrambled'
	),
	(
		ARRAY['Bean Sprout', 'Bean Sprouts']::VARCHAR(64)[2],
		ARRAY['Cup', 'Cups'],
		1.0, 'Fresh', TRUE, ''
	),
	(
		ARRAY['Red Bell Pepper', 'Red Bell Peppers']::VARCHAR(64)[2],
		ARRAY['', ''],
		1.0, 'Thinly sliced', TRUE, ''
	),
	(
		ARRAY['Green Onion', 'Green Onions']::VARCHAR(64)[2],
		ARRAY['', ''],
		3.0, 'Chopped', TRUE, ''
	),
	(
		ARRAY['Roasted Peanuts', 'Roasted Peanuts']::VARCHAR(64)[2],
		ARRAY['Cup', 'Cups'],
		1.5, 'Dry', TRUE, ''
	),
	(
		ARRAY['Lime', 'Limes']::VARCHAR(64)[2],
		ARRAY['', ''],
		2.0, '', TRUE, 'Cut into wedges'
	),
	(
		ARRAY['Cilantro', 'Cilantro']::VARCHAR(64)[2],
		ARRAY['Cup', 'Cups'],
		1.5, 'Fresh, chopped', TRUE, ''
	),
	-- For Sauce
	(
		ARRAY['Fish Sauce', 'Fish Sauce']::VARCHAR(64)[2],
		ARRAY['Tablespoon', 'Tablespoons'],
		3.0, '', TRUE, ''
	),
	(
		ARRAY['Low-Sodium Soy Sauce', 'Low-Sodium Soy Sauce']::VARCHAR(64)[2],
		ARRAY['Tablespoon', 'Tablespoons'],
		1.0, '', TRUE, ''
	),
	(
		ARRAY['Light Brown Sugar', 'Light Brown Sugar']::VARCHAR(64)[2],
		ARRAY['Tablespoon', 'Tablespoons'],
		5.0, '', TRUE, ''
	),
	(
		ARRAY['Rice Vinegar', 'Rice Vinegar']::VARCHAR(64)[2],
		ARRAY['Tablespoon', 'Tablespoons'],
		2.0, '', TRUE, 'Or Tamarind Paste'
	),
	(
		ARRAY['Sriracha Sauce', 'Sriracha Sauce']::VARCHAR(64)[2],
		ARRAY['Tablespoon', 'Tablespoons'],
		1.0, '', TRUE, 'Or more to taste'
	),
	(
		ARRAY['Creamy Peanut Butter', 'Creamy Peanut Butter']::VARCHAR(64)[2],
		ARRAY['Tablespoon', 'Tablespoons'],
		2.0, '', FALSE, ''
	)
) AS "Temp"("Ingredients.names", "units", "amount", "quality", "is_required", "notes")
JOIN "Recipes" ON "Recipes"."name" = 'Pad Thai'
LEFT JOIN "Ingredients" ON "Temp"."Ingredients.names" = "Ingredients"."names";
