#!/bin/bash
echo "Content-type: text/html; charset=UTF-8"
echo ""
/bin/cat << EOM
<html>
<head><title>Modelo CGI</title></head>
<body>
<h1>Modelo CGI Ejecutado</h1>
<p>Este es un ejemplo de un script CGI en Bash.</p>
EOM

echo "<b>"
ls -l
echo "</b>"

/bin/cat << EOM
</body>
</html>
EOM