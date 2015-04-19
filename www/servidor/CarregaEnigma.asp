<!-- #Include File="Conexao.asp" -->

<%
nId = Request("id")
nDir = Request("dir")

if nId = "" Then
   nId = "0"
   nDir = ">"
else
   if nDir = "P" then
      nDir = ">"
      nProxEnigma = "999999"
   elseif nDir = "A" then
      nDir = "<"
      nProxEnigma = "0"
   else
      nDir = "="
      nProxEnigma = nId
   end if
end if

StrSql = "Select Top 1 idEnigma, Titulo, Enigma, Resposta From tbEnigmas Where idEnigma " + nDir + " " + nId + " Order By idEnigma "

if nDir = "<" Then
   StrSql = StrSql + " Desc"
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