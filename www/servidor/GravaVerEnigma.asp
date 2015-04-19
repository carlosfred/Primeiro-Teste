<%
nEnigma = Request("en")
nUsuario = Request("us")

if nUsuario = "" or nUsuario = "0" then
   Response.end
end if
%>

<!-- #Include File="Conexao.asp" -->

<%

StrSql = "Select DesafiosRealizados From tbEnigmasUsuarios Where idUsuario = " + nUsuario
Set Rst = Server.CreateObject("adodb.Recordset")
Rst.Open StrSql, Conexao

if Not Rst.Eof then
   nEnigmasRealizados = Rst("DesafiosRealizados")
end if

Rst.Close
Set Rst = Nothing

if isNull(nEnigmasRealizados) Then     '' Nenhum enigma até o momento
   nValorGravar = "," + nEnigma + ","
else
   nPesquisa = "," + nEnigma + ","
   if inStr(nEnigmasRealizados,nPesquisa) =  0 then
      nValorGravar = nEnigmasRealizados + nEnigma + ","
   else
      nValorGravar = ""
   end if
end if

if nValorGravar <> "" Then
   StrSql = "Update tbEnigmasUsuarios Set DesafiosRealizados = '" + nValorGravar + "'"
   Conexao.Execute StrSql
End if

Conexao.Close
Set Conexao = Nothing
%>



