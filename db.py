from mysql import connector

db = connector.connect(
    host="localhost",
    user="root",
    password="CoderLife",
   database="caracs"
)

def ToQuery(query,args):
    db.cursor().execute(query, args)
    db.commit()
    print("Query completed\n")

