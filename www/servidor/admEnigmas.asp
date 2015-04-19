<!-- #Include File="Conexao.asp" -->

<%

nId = Request.form("id")
nTitulo = Request.form("Titulo")
nEnigma = Request.Form("Enigma")
nResposta = Request.Form("Resposta")

if nId <> "" Then

   if nId = "0" Then
      StrSql = "Insert into tbEnigmas(Titulo, Enigma, Resposta) Values('" + nTitulo + "','" + nEnigma + "','" + nResposta + "')"
   else
      StrSql = "Update tbEnigmas set Titulo = '" + nTitulo + "', Enigma = '" + nEnigma + "', Resposta = '" + nResposta + "' Where idEnigma = " + nId
   end if

   conexao.execute StrSql

End if


%>

<!DOCTYPE html>
<html>
<head>

   <style type="text/css">

      .titEnigma {
         text-align:left;
         font-size:16px;
         background-color:#ffffff;
         color:#4E9EC7;
         margin: 20px 5px 5px 5px;
         padding:10px;
         border-radius: 25px;
         border: 2px solid #4E9EC7;
         font-weight:bold;
         cursor:pointer;
      }

      .input {
         font-size:14px;
         border: 2px solid #4E9EC7;
      }

   </style>

   <!-- Include the jQuery library -->
   <script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>

   <script>

   $(document).ready(function(){

      $(".titEnigma").click(function() {
         var nId = $(this).attr('id').substring(10)
         $("#editaEnigma_" + nId).show();;
      });

   });

   </script>

</head>
<body>

<div class='titEnigma' id='titEnigma_0'>Novo Enigma
   <div id='editaEnigma_0' style="display:none">
      <br><br>
      <form action="admEnigmas.asp" method="post">
      <input type="hidden" name="id" value="0">
      Título<br>
      <input type="text" name="titulo" value="" size="40" maxlength="50"><br><br>
      Enigma<br>
      <textarea name="enigma" rows="5" cols="40"></textarea><br><br>
      Resposta<br>
      <textarea name="resposta" rows="5" cols="40"></textarea><br><br>
      <input type="submit" value="Gravar">
      </form>
   </div>
</div>

<%

StrSql = "Select * From tbEnigmas order By Titulo"
Set Rst = server.CreateObject("adodb.Recordset")
Rst.Open StrSql, Conexao

While Not rst.Eof %>
   <div class='titEnigma' id='titEnigma_<% = Rst("idEnigma") %>'><% = Rst("Titulo") %>
      <div id='editaEnigma_<% = Rst("idEnigma") %>' style="display:none">
         <br><br>
         <form action="admEnigmas.asp" method="post">
         <input type="hidden" name="id" value="<% =Rst("idEnigma") %>">
         Título<br>
         <input type="text" name="titulo" value="<% =Rst("Titulo") %>" size="40" maxlength="50"><br><br>
         Enigma<br>
         <textarea name="enigma" rows="5" cols="40"><% =Rst("Enigma") %></textarea><br><br>
         Resposta<br>
         <textarea name="resposta" rows="5" cols="40"><% =Rst("Resposta") %></textarea><br><br>
         <input type="submit" value="Gravar">
         </form>
      </div>
   </div>
   <%
   Rst.MoveNext
Wend
Rst.Close
Set Rst = Nothing

Conexao.Close
Set Conexao = Nothing
%>

