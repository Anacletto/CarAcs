from mysql import connector

db = connector.connect(
    host="localhost",
    user="root",
    password="CoderLife",
   database="carAcsDB"
)

def ToQuery(query,args):
    db.cursor().execute(query, args)
    db.commit()
    print("Query completed\n")

def AddCliente():
    NumeroBi = str(input("Digite o número do seu BI: "))
    PrimeiroNome = str(input("Primeiro nome: "))
    Sobrenome = str(input("Sobrenome: "))
    anoNascimento = int(input("Digite o ano de nascimento: "))
    Provincia = str(input("Provincia: "))
    Bairro = str(input("Bairro: "))
    Cidade = str(input("Cidade: "))

def RemoveCliente():
    Bi = str(input("Digite o número de BI: "))
    ToQuery(query="delete from clientes where bi like ?",args=[Bi])

def UpdateInformacoesClientes():
    Choose = int(input(": "))
    print("""
    
    """)

    Bi = str(input("Digite o número de BI: "))
    ToQuery(query="update from clientes where bi like ?",args=[Bi])

def