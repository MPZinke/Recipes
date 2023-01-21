

CREATE TABLE "Recipes"
(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"name" VARCHAR(64) NOT NULL UNIQUE,
	"instructions" TEXT,
	"rating" INT NOT NULL,
	"serving_size" SMALLINT DEFAULT 1,
	"time" INTERVAL NOT NULL  -- TODO
);


CREATE TABLE "Ingredients"
(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"brand" VARCHAR(64) NOT NULL DEFAULT '',
	"name" VARCHAR(64) NOT NULL UNIQUE,
	"description" TEXT,
	UNIQUE ("name", "band")
);


CREATE TABLE "RecipesIngredients"
(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"Recipes.id" INT NOT NULL,
	FOREIGN KEY ("Recipes.id") REFERENCES "Recipes"("id"),
	"Ingredients.id" INT NOT NULL,
	FOREIGN KEY ("Ingredients.id") REFERENCES "Ingredients"("id"),
	"amount" INT NOT NULL DEFAULT 1,  -- TWO 16oz cans
	"quantity" NUMERIC(6, 2)  -- 2 SIXTEEN OZ cans
);
