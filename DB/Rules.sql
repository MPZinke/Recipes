

CREATE RULE UpdateDeleteRecipe AS ON UPDATE TO "Recipes"
WHERE NEW."is_deleted" = TRUE
DO (
	UPDATE "RecipesIngredients"
	SET "is_deleted" = TRUE
	WHERE "Recipes.id" = NEW."id";

	UPDATE "RecipesHistory"
	SET "is_deleted" = TRUE
	WHERE "Recipes.id" = NEW."id";
);


CREATE RULE UpdateDeleteIngredient AS ON UPDATE TO "Ingredients"
WHERE NEW."is_deleted" = TRUE
DO (
	UPDATE "RecipesIngredients"
	SET "is_deleted" = TRUE
	WHERE "Recipes.id" = NEW."id";
);
