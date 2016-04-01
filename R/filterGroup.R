selectOptions <- function(choices) {
  html <- mapply(choices, names(choices), FUN = function(choice, label) {
    if (is.list(choices)) {
      # If sub-list, create an optgroup and recurse into the sublist
      sprintf(
        '<optgroup label="%s">\n%s\n</optgroup>',
        htmlEscape(label, TRUE),
        selectOptions(choice)
      )

    } else {
      # If single item, just return option string
      sprintf(
        '<option value="%s">%s</option>',
        htmlEscape(choice, TRUE),
        htmlEscape(label)
      )
    }
  })

  HTML(paste(html, collapse = '\n'))
}

filterGroupInput <- function(inputId,dimension_value) {
  attachDependencies(
    tagList(
      tags$script("$('.condition_value_2').hide();$('.condition_value_3').hide();$('.filterMember').first().hide();"),
      div(id=inputId,class="filterGroupClass",
          div(class="filterMember",
              tags$button(type="button",
                          class="btn btn-default",
                          onclick="deleteFun(this)","移除"),
              tags$select(class = "select_type selectize-control selectize-input",
                          style="width:15%;margin:0px 1.5% 10px 0px;",
                          tags$option("value"="include","包含"),
                          tags$option("value"="remove","排除")),
              tags$select(class = "dimension_value selectize-control selectize-input",
                          style="width:15%;margin:0px 1.5% 10px 0px;",
                          selectOptions(dimension_value)),
              tags$select(class = "match_type selectize-control selectize-input",
                          style="width:15%;margin:0px 1.5% 10px 0px;",
                          onchange="checkField(this,this.value)",
                          tags$option("value"="equal","等于"),
                          tags$option("value"="regex","正则"),
                          tags$option("value"="date","日期")),
              tags$input(type="text",value="",
                         class="condition_value_1",
                         style="width:18%;margin:0px 1.5% 10px 0px;"),
              tags$input(class="condition_value_2 datepicker",type="text",value="",
                         style="width:18%;margin:0px 1.5% 10px 0px;",
                         onclick="datepicker_active(this)"),
              tags$input(class="condition_value_3 datepicker",type="text",value="",
                         style="width:18%;margin:0px 1.5% 10px 0px;")
              )
          ),
      tags$button(type="button",class="btn btn-default","增加",onclick="addFun(this)")
      ),
    htmlDependency("filterGroup",
                   as.character(utils::packageVersion("filterGroup")),
                   c(file = system.file(package = "filterGroup")),
                   script = list("filterGroup.js",
                                 "bootstrap-datepicker.min.js",
                                 "bootstrap-datepicker.zh-CN.min.js"),
                   stylesheet = "bootstrap-datepicker.min.css"
                   )
    )
}
