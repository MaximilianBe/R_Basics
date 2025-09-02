{
  // Place your snippets for R here. Each snippet is defined under a snippet name and has a prefix, body and
  // description. The prefix is what is used to trigger the snippet and the body will be expanded and inserted. Possible variables are:
  // $1, $2 for tab stops, $0 for the final cursor position, and ${1:label}, ${2:another} for placeholders. Placeholders with the
  // same ids are connected.
  // Example:
  // "switch": {
  //  "prefix": "switch",
  //  "body": [
  //    "switch(${1:object},",
  //    "\t${2:case} = ${3:action}",
  //    ")"
  //  ],
  //  "description": "Define a switch statement"
  //
 
  "Heading": {
    "prefix": "tmp_heading",
    "body": [
      "################################################################################-",
      "# ----- ${1:heading} -----"
    ],
    "description": "Create a main heading with divider"
  },
 
  "Second Heading": {
    "prefix": "tmp_heading_second",
    "body": [
      "## ----- ${1:heading} -----"
    ],
    "description": "Create a second level heading"
  },
 
  "Third Heading": {
    "prefix": "tmp_heading_third",
    "body": [
      "### ----- ${1:heading} -----"
    ],
    "description": "Create a third level heading"
  },
 
  "Fourth Heading": {
    "prefix": "tmp_heading_fourth",
    "body": [
      "#### ----- ${1:heading} -----"
    ],
    "description": "Create a fourth level heading"
  },
 
  "Divider": {
    "prefix": "tmp_divider",
    "body": [
      "################################################################################-"
    ],
    "description": "Create a divider line"
  },
 
  "Function Description Block": {
    "prefix": "tmp_description_function",
    "body": [
      "################################################################################-",
      "# ----- Description -------------------------------------------------------------",
      "#",
      "# ${1:description}",
      "#",
      "",
      "################################################################################-",
      "# ----- Start -------------------------------------------------------------------"
    ],
    "description": "Create a description block for functions"
  },
 
  "R Function Template": {
    "prefix": "tmp_function",
    "body": [
      "#' ${3:function_description}",
      "#'",
      "#' @param ${2:input_argument} ${4:input_argument_description}",
      "#' @return ${5:return_value_description}",
      "${1:function_name} <- function(${2:input_argument}) {",
      "  # ---- start ---- #",
      "  $0",
      "}"
    ],
    "description": "Create a documented R function template"
  },
 
  "Full R Script Header": {
    "prefix": "tmp_full_header",
    "body": [
      "################################################################################-",
      "# ----- Description -------------------------------------------------------------",
      "#",
      "# ${1:description}",
      "#",
      "# ------------------------------------------------------------------ #",
      "# Authors@R: ${2:author}",
      "# Date: ${3:year}/${4:month}",
      "#",
      "",
      "################################################################################-",
      "# ----- Settings ----------------------------------------------------------------",
      "",
      "rm(list = ls())",
      "",
      "## ----- libraries -----",
      "",
      "## ----- functions/scripts -----",
      "",
      "## ----- constants -----",
      "",
      "## ----- data -----",
      "",
      "################################################################################-",
      "# ----- Start -------------------------------------------------------------------",
      "$0"
    ],
    "description": "Create a complete R script header with all sections"
  },
 
  "Shiny App Template": {
    "prefix": "tmp_shiny_app",
    "body": [
      "## ----- define UI Structure -----",
      "",
      "# Defines the ui structure of the shiny app",
      "ui <- function(req){",
      "  $1",
      "}",
      "",
      "# wrap UI with secure_app",
      "ui <- secure_app(ui, enable_admin = TRUE)",
      "",
      "## ----- define Server Function -----",
      "",
      "# Defines all content to be placed inside the placeholders of the ui",
      "server <- function(input, output, session) {",
      "",
      "  # check_credentials returns a function to authenticate users",
      "  res_auth <- secure_server(",
      "    check_credentials = check_credentials(",
      "      path_to_user_db",
      "    )",
      "  )",
      "",
      "### ----- Funcionality -----",
      "  $2",
      "}",
      "",
      "################################################################################-",
      "# ----- Render Shiny Webpage ----------------------------------------------------",
      "",
      "shinyApp(ui, server)"
    ],
    "description": "Create a complete Shiny app template with authentication"
  },
 
  "Shiny Module Template": {
    "prefix": "tmp_module",
    "body": [
      "################################################################################-",
      "# ----- Description -------------------------------------------------------------",
      "#",
      "# ${2:description}",
      "#",
      "# ------------------------------------------------------------------ #",
      "# Authors@R: ${3:author}",
      "# Date: ${4:year}/${5:month}",
      "#",
      "",
      "################################################################################-",
      "# ----- Libraries ---------------------------------------------------------------",
      "",
      "$6",
      "",
      "################################################################################-",
      "# ----- Module UI -----",
      "",
      "module_${1:module_function}_ui <- function(id) {",
      "  ns <- NS(id)",
      "",
      "  $7",
      "}",
      "",
      "################################################################################-",
      "# ----- Module Server -----",
      "",
      "module_${1:module_function}_server <- function(id, data, external_input) {",
      "  moduleServer(id, function(input, output, session) {",
      "    ns <- session\\$ns",
      "    help_func <- module_${1:module_function}_functions",
      "",
      "    $8",
      "  })",
      "}",
      "",
      "################################################################################-",
      "# ----- Generate Testdata -----",
      "",
      "module_${1:module_function}_testdata <- list(",
      "",
      "    last_location = \"\",",
      "    encrypted_with = \"\",",
      "    data = structure(list())",
      "",
      ")",
      "",
      "################################################################################-",
      "# ----- Helping Functions -----",
      "",
      "module_${1:module_function}_functions <- list(",
      "",
      "  $9",
      ")"
    ],
    "description": "Create a complete Shiny module template with UI, server, testdata, and helper functions"
  }
}