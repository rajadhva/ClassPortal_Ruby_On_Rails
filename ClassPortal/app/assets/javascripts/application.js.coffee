$(document).ready ->

  $(".ui-datepicker").each ->

    $(@).datepicker

      dateFormat: "mm/dd/yy"


  $("#communications").on "cocoon:after-insert", ->

    $(".ui-datepicker").datepicker

      dateFormat: "mm/dd/yy"
