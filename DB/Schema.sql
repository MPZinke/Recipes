

CREATE TABLE "Recipes"
(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"is_deleted" BOOLEAN DEFAULT FALSE,
	"name" VARCHAR(64) NOT NULL UNIQUE,
	"instructions" JSON NOT NULL,
	"rating" SMALLINT NOT NULL,
	"serving_size" SMALLINT DEFAULT 1,
	"time" INTERVAL NOT NULL  -- TODO
);


CREATE TABLE "Ingredients"
(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"is_deleted" BOOLEAN DEFAULT FALSE,
	"brand" VARCHAR(64) NOT NULL DEFAULT '',
	"name" VARCHAR(64) NOT NULL UNIQUE,
	"description" TEXT NOT NULL DEFAULT '',
	UNIQUE ("name", "brand")
);


CREATE TABLE "RecipesIngredients"
(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"is_deleted" BOOLEAN DEFAULT FALSE,
	"amount" INT DEFAULT 0,  -- 'TWO' 16oz cans; 0 means there is an unspecified amount
	"quantity" VARCHAR(64) DEFAULT '',  -- 2 'SIXTEEN OZ' cans
	"is_required" BOOLEAN DEFAULT TRUE,
	"notes" TEXT NOT NULL DEFAULT '',
	"Recipes.id" INT NOT NULL,
	FOREIGN KEY ("Recipes.id") REFERENCES "Recipes"("id"),
	"Ingredients.id" INT NOT NULL,
	FOREIGN KEY ("Ingredients.id") REFERENCES "Ingredients"("id")
);
