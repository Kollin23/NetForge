#!/bin/bash
echo "Content-type: text/html; charset=utf-8"
echo ""

/bin/cat << EOM
<html>
<head>
  <meta charset="utf-8">
  <title>Hola món CGI</title>
</head>
<body>
EOM

comand=$(echo "$QUERY_STRING" | sed -n 's/^.*comand=\([^&]*\).*$/\1/p')


<<<<<<< HEAD
echo "$(/usr/local/JSBach/scripts/client_srv_cli.sh enrutar $comand) <br>"
=======
echo "$(/usr/local/NetForge/scripts/client_srv_cli enrutar.sh $comand) <br>"
>>>>>>> origin/main


/bin/cat << EOM
</body>
</html>
EOM

