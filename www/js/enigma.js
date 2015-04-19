$(document).ready(function(){

   localStorage.setItem("UsuarioLogado","0")
   localStorage.setItem("EnigmaAtual","0")
   $.mobile.loading().hide();
   carregaEnigma('-1');

   $("#btProx").click(function() {
      carregaEnigma('P');
   });

   $("#btAnt").click(function() {
      carregaEnigma('A');
   });

   $("#btLista").click(function() {
      listaEnigmas();
   });

   $("#btLoginfb").click(function() {
      localStorage.setItem("UsuarioLogado","1");
   });

   $("#btAnonimo").click(function() {
      localStorage.setItem("UsuarioLogado","0");
   });

   function listaEnigmas() {
      var nUrl = "http://www.w3ideias.com.br/enigma/listaEnigmas.asp?" + "us=" + localStorage.getItem("UsuarioLogado")
      $.get(nUrl, {}, function(data) {
         $("#divEnigma").html(data);
         $(".titEnigma").click(function() {
            var nId = $(this).attr('id').substring(10)
            carregaEnigma(nId)
         });
      })
   }

   function carregaEnigma(nId) {
      $("#divEnigma").html("Carregando...");
      var nUrl
      if (nId == "P" || nId == "A") {
         nUrl = "http://www.w3ideias.com.br/enigma/carregaEnigma.asp?id=" + localStorage.getItem("EnigmaAtual") + "&dir=" + nId + "&us=" + localStorage.getItem("UsuarioLogado")
      } else {
         nUrl = "http://www.w3ideias.com.br/enigma/carregaEnigma.asp?id=" + nId
      }
      $.get(nUrl, {}, function(data) {
         $("#divEnigma").html(data);
         localStorage.setItem("EnigmaAtual",$("#enigmaAtual").val());
         $(".btVerResposta").click(function() {
            $(".respEnigma").show();
            $('html,body').animate({
               scrollTop: $(window).scrollTop() + 100
            })
            // Grava a informação que a resposta deste enigma foi vista
            nUrl = "http://www.w3ideias.com.br/enigma/gravaVerEnigma.asp?en=" + nEnigmaAtual + "&us=" + localStorage.getItem("UsuarioLogado")
            $.get(nUrl, {}, function(data) {})
         });
      })
   };

});


