#!/bin/bash
echo "Content-type: text/html; charset=UTF-8"
echo ""
cat <<EOF
<html>
<head><title>Modelo CGI</title></head>
<body>
<h1>Modelo CGI Ejecutado</h1>
<p>Este es un ejemplo de un script CGI en Bash.</p>
</body>
</html>
EOF

ls -l