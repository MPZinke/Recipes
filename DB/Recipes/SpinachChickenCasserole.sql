
/***********************************************************************************************************************
*                                                                                                                      *
*   created by: Morgan Pothoff                                                                                         *
*   on 2023.03.19                                                                                                      *
*                                                                                                                      *
*   DESCRIPTION: TEMPLATE                                                                                              *
*   BUGS:                                                                                                              *
*   FUTURE:                                                                                                            *
*                                                                                                                      *
***********************************************************************************************************************/


INSERT INTO "Recipes" ("name", "rating", "servings", "total_time", "prep_time", "cook_time", "instructions") VALUES
('Spinach Chicken Casserole', 5, 4, INTERVAL '35 MINUTES', INTERVAL '15 MINUTES', INTERVAL '20 MINUTES',  
	'{
		"Preparation":
		[
			"Add olive oil, garlic, Italian seasoning, and red pepper flakes into a Ziplock bag along with 1/2 teaspoon of salt and 1/2 teaspoon black pepper.",
			"Seal the bag and shake until mixed.",
			"Add the chicken breasts, seal, and massage so the chicken breasts are covered in the marinade.",
			"Set aside for 10-15 minutes on the counter while you prep the remaining ingredients.",
			"Position a rack in the center of the oven and preheat the oven to 400ºF."
		],
		"Dish":
		[
			"Quickly wilt the spinach in a skillet with 1 tablespoon olive oil and set aside.",
			"Arrange chicken breasts drained from the marinade in a baking dish.",
			"Spread the softened cream cheese over the chicken breasts and lay spinach on top of the cream cheese.",
			"Sprinkle mozzarella over the top.",
			"Bake for 20-30 minutes or until chicken''s internal temperature reaches 165˚F.",
			"Enjoy!"
		]
	}'
);


INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Skinless Chicken Breast', 'Skinless Chicken Breasts'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Cream Cheese', 'Cream Cheese'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Spinach', 'Spinach'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Olive Oil', 'Olive Oil'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Mozzarella Cheese', 'Mozzarella Cheese'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Garlic', 'Garlic'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Red Pepper Flakes', 'Red Pepper Flakes'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Salt', 'Salt'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Pepper', 'Pepper'])
ON CONFLICT ("names", "brand") DO NOTHING;

INSERT INTO "Ingredients" ("names") VALUES
(ARRAY['Italian Seasoning', 'Italian Seasoning'])
ON CONFLICT ("names", "brand") DO NOTHING;


INSERT INTO "RecipesIngredients" ("Recipes.id", "Ingredients.id", "amount", "units", "quality", "is_required", "notes")
SELECT "Recipes"."id", "Ingredients"."id", "Temp"."amount", "Temp"."units", "Temp"."quality", "Temp"."is_required", "Temp"."notes"
FROM
(
	VALUES
	(
		ARRAY['Skinless Chicken Breast', 'Skinless Chicken Breasts']::VARCHAR(64)[2],
		ARRAY['', ''],
		2.0, '', TRUE, 'Cut horizontally'
	),
	(
		ARRAY['Cream Cheese', 'Cream Cheese']::VARCHAR(64)[2],
		ARRAY['Ounce', 'Ounces],
		8.0, '', TRUE, ''
	),
	(
		ARRAY['Spinach', 'Spinach']::VARCHAR(64)[2],
		ARRAY['Cup', 'Cups'],
		2.0, '', TRUE, ''
	),
	(
		ARRAY['Olive Oil', 'Olive Oil']::VARCHAR(64)[2],
		ARRAY['Tablespoon', 'Tablespoons'],
		2.0, '', TRUE, ''
	),
	(
		ARRAY['Mozzarella Cheese', 'Mozzarella Cheese']::VARCHAR(64)[2],
		ARRAY['Ounce', 'Ounces'],
		4.0, '', TRUE, ''
	),
	(
		ARRAY['Garlic', 'Garlic']::VARCHAR(64)[2],
		ARRAY['Clove', 'Cloves'],
		3.0, 'Minced', TRUE, ''
	),
	(
		ARRAY['Red Pepper Flakes', 'Red Pepper Flakes']::VARCHAR(64)[2],
		ARRAY['Teaspoon', 'Teaspoons'],
		0.5, '', TRUE, ''
	),
	(
		ARRAY['Salt', 'Salt']::VARCHAR(64)[2],
		ARRAY['Teaspoon', 'Teaspoons'],
		0.5, '', TRUE, ''
	),
	(
		ARRAY['Pepper', 'Pepper']::VARCHAR(64)[2],
		ARRAY['Teaspoon', 'Teaspoons'],
		0.5, '', TRUE, ''
	),
	(
		ARRAY['Italian Seasoning', 'Italian Seasoning']::VARCHAR(64)[2],
		ARRAY['Teaspoon', 'Teaspoons'],
		0.5, '', TRUE, ''
	)
) AS "Temp"("Ingredients.names", "units", "amount", "quality", "is_required", "notes")
JOIN "Recipes" ON "Recipes"."name" = 'Spinach Chicken Casserole'
LEFT JOIN "Ingredients" ON "Temp"."Ingredients.names" = "Ingredients"."names";
