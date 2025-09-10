library(DBI)
library(RPostgres)
library(Billomatics)
library(tibble)
library(dplyr)
library(shiny)

con <- Billomatics::postgres_connect(
  needed_tables = c("raw.billomat_invoices"),

  postgres_keys = keys$postgresql,
  local_password_is_product = TRUE,
  update_local_tables = TRUE,
  ssh_key_path = "C:/Users/maxep/.ssh/id_rsa"
) # Falls anders)

onStop(function() {
  poolClose(con)
}) # pool wird automatisch nach App-Laufzeit geschlossen
tasks_comments <- tbl(con, I("raw.billomat_invoices")) %>% collect()
