$(function(){
    $("#test").css("color","red")
    $(".hoge").css("color","#00ff7f")

    $('tr[data-href]').addClass('clickable');
    $('.clickable').click(function(e) {
  
            //e.targetはクリックした要素自体、それがa要素以外であれば
            if(!$(e.target).is('a')){
            
              //その要素の先祖要素で一番近いtrの
              //data-href属性の値に書かれているURLに遷移する
              window.location = $(e.target).closest('tr').data('href');}

  });
});