#!/bin/bash


source /usr/local/JSBach/conf/variables.conf


echo "Content-type: text/html; charset=utf-8"
echo ""

/bin/cat << EOM
<html>
<head>
  <meta charset="utf-8">
  <title>Hola mundo CGI</title>
</head>
<body>
EOM

echo "<h2>Guardando la configuración</h2>"

mode=$(echo "$QUERY_STRING" | sed -n 's/^.*mode=\([^&]*\).*$/\1/p')
int=$(echo "$QUERY_STRING" | sed -n 's/^.*int=\([^&]*\).*$/\1/p')
if [[ "$mode" == "manual" ]] then
	ip=$(echo "$QUERY_STRING" | sed -n 's/^.*ip=\([^&]*\).*$/\1/p')
	masc=$(echo "$QUERY_STRING" | sed -n 's/^.*masc=\([^&]*\).*$/\1/p')
	pe=$(echo "$QUERY_STRING" | sed -n 's/^.*pe=\([^&]*\).*$/\1/p')
	dns=$(echo "$QUERY_STRING" | sed -n 's/^.*dns=\([^&]*\).*$/\1/p')
fi

if [[ ! -z $ip ]] then
	ipmas=$ip/$masc
fi

ordre="ifwan.sh configurar $mode $int $ipmas $pe $dns"

echo "<br>"
echo "$mode $int $ipmas $pe $dns"
echo "<br>"

echo "$("$DIR"/"$PROJECTE"/"$DIR_SCRIPTS"/client_srv_cli.sh $ordre) <br>"

/bin/cat << EOM
</body>
</html>
EOM
