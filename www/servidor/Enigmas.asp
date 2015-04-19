<!-- #Include File="Conexao.asp" -->

<!DOCTYPE html>
<html>
<head>

   <style type="text/css">

      .titEnigma {
         text-align:center;
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

   </style>

   <!-- Include the jQuery library -->

</head>
<body>

<%

StrSql = "Select * From tbEnigmas order By Titulo"
Set Rst = server.CreateObject("adodb.Recordset")
Rst.Open StrSql, Conexao

While Not rst.Eof %>
   <div class='titEnigma'><% = Rst("Titulo") %></div>
   <%
   Rst.MoveNext
Wend
Rst.Close
Set Rst = Nothing

Conexao.Close
Set Conexao = Nothing
%>

