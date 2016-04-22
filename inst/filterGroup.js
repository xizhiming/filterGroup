$(document).ready(function(){
  $('body').delegate('.datepicker', 'focusin', function(){
    $(this).datepicker({
      format:'yyyy/mm/dd',
      autoclose: true,
      language: 'zh-CN',
      todayHighlight: true,
      orientation:'bottom auto'
    });
  });
});

function checkField(ob,val){
  var c1=$(ob).parent().find('.condition_value_1');
  var c2=$(ob).parent().find('.condition_value_2');
  var c3=$(ob).parent().find('.condition_value_3');
  c1.val("");
  c2.val("");
  c3.val("");
  if(val=="date"){
    c1.hide();
    c2.show();
    c3.show();
  }else{
    c1.show();
    c2.hide();
    c3.hide();
  }
}

function deleteFun(ob){$(ob).parent().remove();}

function addFun(ob){$('.filterGroupClass').append($('.filterMember').first().clone(true).show());}

var filterGroupBinding = new Shiny.InputBinding();
$.extend(filterGroupBinding, {
  find: function(scope) {return $(scope).find(".filterGroupClass");},
  getValue: function(el) {
    return {
    select: $.makeArray($(el).find(".select_type option:selected").map(function(i, e) {
      return e.value; })),
    dimension: $.makeArray($(el).find(".dimension_value option:selected").map(function(i, e) {
      return e.value; })),
    match: $.makeArray($(el).find(".match_type option:selected").map(function(i, e) {
      return e.value; })),
    value: $.makeArray($(el).find(".condition_value_1").map(function(i, e) {
      return e.value; })),
    start_date: $.makeArray($(el).find(".condition_value_2").map(function(i, e) {
      return e.value; })),
    end_date: $.makeArray($(el).find(".condition_value_3").map(function(i, e) {
      return e.value; })),
    };
  },
  setValue: function(el, value) {el.value = value;},
  subscribe: function(el, callback) {
    $(el).on('input.filterGroupBinding click.filterGroupBinding keyup.filterGroupBinding',
    function(event) {callback(true);});
    $(el).on('.filterGroupBinding', function(event) {callback(false);});
  },
  unsubscribe: function(el) {$(el).off('.filterGroupBinding');},
});
Shiny.inputBindings.register(filterGroupBinding, 'shiny.filterGroupInput');
