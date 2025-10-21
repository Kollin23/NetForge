#!/bin/bash
echo "Content-type: text/html; charset=UTF-8"
echo ""
/bin/cat << EOM
<html>
<head><title>Modelo CGI</title></head>
<body>
<h1>IFWAN</h1>
EOM

/usr/local/NetForge/scripts/ifwan.sh estado

/bin/cat << EOM
</body>
</html>
EOM