$(document).ready(function(){

   localStorage.setItem("UsuarioLogado","0")
   localStorage.setItem("EnigmaAtual","0")

   $.mobile.loading().hide();

   $("#btProx").click(function() {
      carregaEnigma('P' + localStorage.getItem("EnigmaAtual"));
   });

   $("#btAnt").click(function() {
      carregaEnigma('A' + localStorage.getItem("EnigmaAtual"));
   });

   $("#btLista").click(function() {
      listaEnigmas();
   });

   $("#btLoginfb").click(function() {
      localStorage.setItem("UsuarioLogado","1");
      carregaEnigma('U');

   });

   $("#btAnonimo").click(function() {
      localStorage.setItem("UsuarioLogado","0");
      carregaEnigma('P0');
   });

   function listaEnigmas() {
      var nUrl = "http://www.w3ideias.com.br/enigma/listaEnigmas.asp?" + "us=" + localStorage.getItem("UsuarioLogado")
      $.get(nUrl, {}, function(data) {
         $("#divEnigma").html(data);
         $(".titEnigma").click(function() {
            var nId = $(this).attr('id').substring(10)
            carregaEnigma('I' + nId)
         });
      })
   }

   function carregaEnigma(nId) {
      $("#divEnigma").html("Carregando...");
      var nUrl
      nUrl = "http://www.w3ideias.com.br/enigma/carregaEnigma.asp?id=" + nId + "&us=" + localStorage.getItem("UsuarioLogado")
      $.get(nUrl, {}, function(data) {
         $("#divEnigma").html(data);
         localStorage.setItem("EnigmaAtual",$("#enigmaAtual").val());
         $(".btVerResposta").click(function() {
            $(".respEnigma").show();
            $('html,body').animate({
               scrollTop: $(window).scrollTop() + 100
            })
            // Grava a informação que a resposta deste enigma foi vista
            nUrl = "http://www.w3ideias.com.br/enigma/gravaVerEnigma.asp?en=" + localStorage.getItem("EnigmaAtual") + "&us=" + localStorage.getItem("UsuarioLogado")
            $.get(nUrl, {}, function(data) {})
         });
      })
   };

});


