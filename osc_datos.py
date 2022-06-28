
from oscpy.client import OSCClient
from time import sleep


#Seteo de puerto
OSC_HOST = "127.0.0.1"
OSC_PORT = 57120
OSC_CLIENT = OSCClient(OSC_HOST,OSC_PORT)

def send_osc(list_data):
    ruta = "/data".encode()
    OSC_CLIENT.send_message(ruta)
    print('enviando',ruta)
    return

#lectura de archivo
nombre_archivo = "datos_cuenca/cuencas_limpio.txt"
file = open(nombre_archivo, 'rt')
tabla = []
lines = file.readlines()

for l in lines:
    row = [v for v in l.strip().split(',')]
    tabla.append(row)
print("numero de filas en la tabla", len(tabla))
print("numero de columnas por fila", len(row))


