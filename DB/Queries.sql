
-- Get a recipe by name
SELECT *
FROM "Recipes"
WHERE "name" = %s
  AND "is_deleted" = FALSE;


-- Get the ingredients for a recipe
SELECT *
FROM "RecipesIngredients"
JOIN "Ingredients" ON "RecipesIngredients"."Ingredients.id" = "Ingredients"."id"
WHERE "Recipes"."id" = %s
  AND "is_deleted" = FALSE;
