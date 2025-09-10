library(DBI)
library(RPostgres)

con <- dbConnect(
  RPostgres::Postgres(),
  dbname = "postgres",
  host = "localhost",
  port = 5432,
  user = "postgres",
  password = getPass::getPass(),
  client_encoding = "utf8"
)

print(dbListTables(con))
print(dbIsValid(con))
