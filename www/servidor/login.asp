<!-- #Include File="Conexao.asp" -->

<%

nEmail = request.form("email")
nSenha = request.form("senha")

StrSql = "Select idUsuario From tbEnigmasUsuarios Where email = '" + nEmail + "' And Senha = '" + nSenha + "'"
Set Rst = Server.CreateObject("ADODB.RecordSet")
Rst.Open StrSql, Conexao

if Not Rst.Eof then
   nIdUsuario = Rst("idUsuario")
else
   nIdUsuario = -1
end if

Rst.Close
Set Rst = Nothing

if nIdUsuario = -1 then
   Response.write "Usuario ou Senha Inválidos !!!"
else
   Response.write nIdUsuario
end if

Conexao.Close
Set Conexao = Nothing

%>