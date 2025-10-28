#!/bin/bash
echo "Content-type: text/html; charset=UTF-8"
echo ""
/bin/cat << EOM
<html>
<head><title>Modelo CGI</title></head>
<body>
<h1>IFWAN</h1>
EOM

while IFS = read -r line; do
    if [[$line == "exit"]]; then
        break
    fi
    echo "<pre>$line</pre>"
done < <((echo "enrutar iniciar") | nc 127.0.0.1 1234)


/bin/cat << EOM
</body>
</html>
EOM