
from oscpy.client import OSCClient
from time import sleep


#Seteo de puerto
OSC_HOST = "127.0.0.1"
OSC_PORT = 57120
OSC_CLIENT = OSCClient(OSC_HOST,OSC_PORT)

def send_osc(list_data):
    ruta = "/data".encode()
    OSC_CLIENT.send_message(ruta,list_data)
    #print('enviando',ruta)
    return

#lectura de archivo
nombre_archivo = "cuencas_separadas/texcoco.txt"
file = open(nombre_archivo, 'rt')
tabla = []
lines = file.readlines()

for l in lines:
    row = [v for v in l.strip().split(',')]
    tabla.append(row)
print("numero de filas en la tabla", len(tabla))
print("numero de columnas por fila", len(row))
# imprime archivo
print ("La tabla del archivo es:")
print ("------------------------")
for row in tabla:
    for col in row:
        print(col, '\t', end=''), 
    print('')
print ('------------------------')

#loop

i = 0
while (True):
    in_line = tabla[i]
    # print(in_line)
    valores = [0,0,0]
    try:    
        valores = [i, int(in_line[0]), float(in_line[2]), float(in_line[3])]
        
    except:
        i=i+1
        continue

    #Envio de valores
    send_osc(valores)
    print(">> ", valores)

    if i < (len(tabla)-1):
        i = i+1
    else:
        i = 0
    
    sleep(0.5)

