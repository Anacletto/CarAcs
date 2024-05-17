from mysql import connector

db = connector.connect(
    host="localhost",
    user="root",
    password="CoderLife",
   database="caracs"
)

def Insert(query,args):
    db.cursor().execute(query, args)
    db.commit()
    print("Query completed\n")

def Delete(query,args):
    db.cursor().execute()