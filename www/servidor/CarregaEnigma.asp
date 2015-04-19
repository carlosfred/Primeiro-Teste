<!-- #Include File="Conexao.asp" -->

<%
nId = Request("id")
nUsuario = Request("us")

if nId = "" Then
   nId = "P0"
end if

Operacao = Mid(nId,1,1)

nId = Mid(nId,2)

if Operacao = "U" Then

   StrSql = "Select DesafiosRealizados From tbEnigmasUsuarios Where idUsuario = " + nUsuario
   Set Rst = Server.CreateObject("adodb.Recordset")
   Rst.Open StrSql, Conexao

   if Not Rst.Eof then
      nEnigmasRealizados = Rst("DesafiosRealizados")
   end if

   Rst.Close
   Set Rst = Nothing

   StrSql = "Select Top 1 idEnigma, Titulo, Enigma, Resposta From tbEnigmas Where idEnigma Not in (0" + nEnigmasRealizados + "0) Order By idEnigma"

else

   if Operacao = "P" Then
      Sinal = ">"
      nProxEnigma = "99999"
   elseif Operacao = "A" then
      Sinal = "<"
      nProxEnigma = "0"
   elseif Operacao = "I" then
      Sinal = "="
   end if

   StrSql = "Select Top 1 idEnigma, Titulo, Enigma, Resposta From tbEnigmas Where idEnigma " + Sinal + " " + nId + " Order By idEnigma "
   if Operacao = "A" Then
      StrSql = StrSql + " Desc"
   end if

end if

Set Rst = Server.CreateObject("adodb.Recordset")
Rst.Open StrSql, conexao

if Rst.Eof Then
   Response.write "Aguarde, em breve novos enigmas !!!"
   Response.write "<input id='enigmaAtual' style='display:none' value='" + nProxEnigma + "'>"
   Rst.Close
   Set Rst = Nothing
   Conexao.Close
   Set Conexao = Nothing
   Response.end
end if

nTitulo = Server.HtmlEncode(Rst("Titulo"))
nEnunciado = Server.HtmlEncode(Rst("Enigma"))
nEnunciado = Replace(nEnunciado,chr(13),"<br />")
nResposta = Server.HtmlEncode(Rst("Resposta"))
nResposta = Replace(nResposta,chr(13),"<br />")

Response.write "<div class='titEnigma'>" + nTitulo + "</div>"
Response.write "<div class='enumEnigma'>" +  nEnunciado + "</div>"
Response.write "<div class='btVerResposta'><a href='' class='ui-btn ui-btn-inline'>Ver Resposta</a></div>"
Response.write "<div class='respEnigma' style='display:none'>" + nResposta + "</div>"
Response.write "<input id='enigmaAtual' style='display:none' value='" + cStr(Rst("idEnigma")) + "'>"

Rst.close
Set Rst = Nothing

Conexao.Close
Set Consexao = Nothing
%>