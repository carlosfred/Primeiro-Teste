<!-- #Include File="Conexao.asp" -->

<%

nUsuario = Request("us")

StrSql = "Select DesafiosRealizados From tbEnigmasUsuarios Where idUsuario = " + nUsuario
Set Rst = Server.CreateObject("adodb.Recordset")
Rst.Open StrSql, Conexao

if Not Rst.Eof then
   nEnigmasRealizados = Rst("DesafiosRealizados")
end if

Rst.Close
Set Rst = Nothing

StrSql = "Select * From tbEnigmas Where idEnigma Not in (0" + nEnigmasRealizados + "0) Order By idEnigma"
Set Rst = server.CreateObject("adodb.Recordset")
Rst.Open StrSql, Conexao

While Not rst.Eof %>
   <div class='titEnigma' id='titEnigma_<% = Rst("idEnigma") %>'><% = Server.HtmlEncode(Rst("Titulo")) %></div>
   <%
   Rst.MoveNext
Wend
Rst.Close
Set Rst = Nothing

StrSql = "Select * From tbEnigmas Where idEnigma in (0" + nEnigmasRealizados + "0) Order By Titulo"
Set Rst = server.CreateObject("adodb.Recordset")
Rst.Open StrSql, Conexao

While Not rst.Eof %>
   <div class='titEnigma' id='titEnigma_<% = Rst("idEnigma") %>'><% = Server.HtmlEncode(Rst("Titulo")) %><img class="ui-btn-icon-left" src="img/ok.jpg"></div>
   <%
   Rst.MoveNext
Wend
Rst.Close
Set Rst = Nothing

Conexao.Close
Set Conexao = Nothing
%>

