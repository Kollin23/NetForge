#!/usr/bin/expect -f

# Configuración de timeout
set timeout 10

# Iniciar la conexión al servidor CLI
spawn nc 127.0.0.1 1234

# Esperar el prompt inicial
expect "cli> "

# Enviar el comando para ejecutar el script exp_model.sh con argumentos
send "ifwan.sh estado\r"

# Esperar la salida del comando y el siguiente prompt
expect {
    -re {cli> } {
        # Capturar la salida antes del prompt
        set output $expect_out(buffer)
    }
    timeout {
        puts "Error: Tiempo de espera agotado al esperar la salida del comando."
        exit 1
    }
}

# Enviar el comando para salir
send "exit\r"
# Esperar la confirmación de salida
expect "Saliendo..."
# Cerrar la conexión
close
puts "Conexión cerrada."
exit 0
