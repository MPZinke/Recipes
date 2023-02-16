

DROP TABLE IF EXISTS "Recipes" CASCADE;
CREATE TABLE "Recipes"
(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"is_deleted" BOOLEAN DEFAULT FALSE,
	"name" VARCHAR(64) NOT NULL UNIQUE,
	"instructions" JSON NOT NULL,
	"notes" TEXT NOT NULL DEFAULT '',
	"rating" SMALLINT NOT NULL,
	"servings" SMALLINT DEFAULT 1,
	"total_time" INTERVAL NOT NULL DEFAULT INTERVAL '0 HOURS',
	"prep_time" INTERVAL NOT NULL DEFAULT INTERVAL '0 HOURS',
	"cook_time" INTERVAL NOT NULL DEFAULT INTERVAL '0 HOURS',
	"url" TEXT NOT NULL DEFAULT ''
);


DROP TABLE IF EXISTS "Ingredients" CASCADE;
CREATE TABLE "Ingredients"
(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"is_deleted" BOOLEAN DEFAULT FALSE,
	"brand" VARCHAR(64) NOT NULL DEFAULT '',
	"names" VARCHAR(64)[2] NOT NULL,
	"description" TEXT NOT NULL DEFAULT '',
	UNIQUE ("names", "brand")
);


DROP TABLE IF EXISTS "RecipesIngredients" CASCADE;
CREATE TABLE "RecipesIngredients"
(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"is_deleted" BOOLEAN DEFAULT FALSE,
	"group" VARCHAR(64) NOT NULL DEFAULT '',
	"amount" NUMERIC(16,8) DEFAULT 0,
	"units" VARCHAR(64)[2] DEFAULT ARRAY['', ''],
	"quality" VARCHAR(64) DEFAULT '',
	"is_required" BOOLEAN DEFAULT TRUE,
	"notes" TEXT NOT NULL DEFAULT '',
	"Recipes.id" INT NOT NULL,
	FOREIGN KEY ("Recipes.id") REFERENCES "Recipes"("id"),
	"Ingredients.id" INT NOT NULL,
	FOREIGN KEY ("Ingredients.id") REFERENCES "Ingredients"("id")
);


DROP TABLE IF EXISTS "RecipesHistory" CASCADE;
CREATE TABLE "RecipesHistory"
(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"is_deleted" BOOLEAN DEFAULT FALSE,
	"Recipes.id" INT NOT NULL,
	FOREIGN KEY ("Recipes.id") REFERENCES "Recipes"("id"),
	"time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE RULE "UpdateDeleteRecipe" AS ON UPDATE TO "Recipes"
WHERE NEW."is_deleted" = TRUE
DO (
	UPDATE "RecipesIngredients"
	SET "is_deleted" = TRUE
	WHERE "Recipes.id" = NEW."id";

	UPDATE "RecipesHistory"
	SET "is_deleted" = TRUE
	WHERE "Recipes.id" = NEW."id";
);


CREATE RULE "UpdateDeleteIngredient" AS ON UPDATE TO "Ingredients"
WHERE NEW."is_deleted" = TRUE
DO (
	UPDATE "RecipesIngredients"
	SET "is_deleted" = TRUE
	WHERE "Recipes.id" = NEW."id";
);

