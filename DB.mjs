import {createConnection} from "mysql2"

const Connection = createConnection({
    host: 'localhost',
    user: 'root',
    password: 'CoderLife',
    database: 'caracs',
    port:3306
})

export function  Query (query,args){
    return new Promise((res,rej)=>{
        Connection.query(query,args,(error,Result)=>{
            if(error){
                rej(error)
            }else{
                res(Result)
            }
        })
    })
}
