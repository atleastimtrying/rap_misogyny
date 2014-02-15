window.rm.App = function(){
  var test_keyup = function(event){
    if(event.keyCode === 13) submit_name();
  };

  var present = function(string){
    return string.length > 0;
  };

  var submit_name = function(event){
    if(event) event.preventDefault();
    var name = $('.rapper_name').val();
    if(present(name)){
      print_result('thinking...');
      $.get('/rating.json', {name:name}, print_result);
    }else{
      print_result('please enter a name');
    }
  };

  var print_result = function(message){
    $('.result').html(message);
  };

  var bindUI = function(){
    $('.rapper_name').keyup(test_keyup);
    $('.get_rating').click(submit_name);
  };

  var init = function(){
    bindUI();
  };

  init();
};

$(function(){
  window.app = new rm.App();
});