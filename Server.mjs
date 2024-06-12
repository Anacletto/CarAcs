import { Query} from "./DB.mjs"
import express  from "express"
import {join} from "path"

const Port = 8080
const app = express()
const Root = "/home/anacletto/Projects/CarAcs/"

app.use(express.static(join(Root,"Test")))

// API endpoints

// Clients
app.post('/clients_create/', (req, res) => {
    console.log(req.query)
    const { primeironome, sobrenome, anonascimento, bairro, provincia, cidade, telefone } = req.query
    const query = Query('CALL InsertCliente(?, ?, ?, ?, ?, ?)',[primeironome, sobrenome, anonascimento, bairro, provincia, cidade])
    query.catch((error)=>{
        res.send(JSON.stringify({Message:error}))
    })
    query.then((QueryResult)=>{
        if(QueryResult.affectedRows >= 1){
            res.send(JSON.stringify({Message:"Sucess"}))
        }else{
            res.send(JSON.stringify({Message:"Falha"}))
        }
    }) 
  
})


app.get('/clients_read/', (req, res) => {  
  const { id } = req.query
  const query = Query('CALL GetCliente(?)', [id])
    query.catch((error)=>{
        res.send(JSON.stringify({Message:error}))
        console.log(error)
    })
    query.then((QueryResult)=>{
        console.log(QueryResult)
        res.send(JSON.stringify(QueryResult))
    }) 
})


app.put('/clients_update/', (req, res) => {
  const { primeiroNome,id } = req.query
  const query = Query('CALL UpdateCliente(?, ?)', [id, primeiroNome])
  query.catch((error)=>{
    res.send(JSON.stringify({Message:error}))
    })
    query.then((QueryResult)=>{
        if(QueryResult.affectedRows >= 1){
            res.send(JSON.stringify({Message:"Sucess"}))
        }else{
            res.send(JSON.stringify({Message:"Falha"}))
        }
    }) 

})
app.delete('/clients_delete/', (req, res) => {
  const { id } = req.query
  const query = Query('CALL DeleteCliente(?)', [id])
  query.catch((error)=>{
    res.send(JSON.stringify({Message:error}))
})
query.then((QueryResult)=>{
    if(QueryResult.affectedRows >= 1){
        res.send(JSON.stringify({Message:"Sucess"}))
    }else{
        res.send(JSON.stringify({Message:"Falha"}))
    }
}) 

})


// Employees
app.post('/employee_create', (req, res) => {
  const { primeironome, sobrenome, provincia, cidade, bairro, telefone } = req.query
  const query = Query('CALL InsertFuncionario(?, ?, ?, ?, ?, ?)', [primeironome, sobrenome, provincia, cidade, bairro, telefone])
  query.catch((error)=>{
    res.send(JSON.stringify({Message:error}))
})
query.then((QueryResult)=>{
    if(QueryResult.affectedRows >= 1){
        res.send(JSON.stringify({Message:"Sucess"}))
    }else{
        res.send(JSON.stringify({Message:"Falha"}))
    }
}) 

})
app.get('/employee_read/', (req, res) => {
    const {employeeid} = req.query
    const query = Query('CALL GetFuncionario(?)', [employeeid])
    query.catch((error)=>{
        res.send(JSON.stringify({Message:error}))
    })
    query.then((QueryResult)=>{
        res.send(JSON.stringify(QueryResult))
    }) 
})
app.put('/employee_update/', (req, res) => {
    const { primeironome,employeeid } = req.query;
    const query = Query('CALL UpdateFuncionario(?, ?)', [employeeid, primeironome])
    query.catch((error)=>{
        res.send(JSON.stringify({Message:error}))
    })
    query.then((QueryResult)=>{
        if(QueryResult.affectedRows >= 1){
            res.send(JSON.stringify({Message:"Sucess"}))
        }else{
            res.send(JSON.stringify({Message:"Falha"}))
        }
    }) 
  
})
  // Delete an employee
app.delete('/employee_delete/', (req, res) => {
    const {employeeid} = req.query
    const query = Query('CALL DeleteFuncionario(?)', [employeeid])
    query.catch((error)=>{
        res.send(JSON.stringify({Message:error}))
    })
    query.then((QueryResult)=>{
        if(QueryResult.affectedRows >= 1){
            res.send(JSON.stringify({Message:"Sucess"}))
        }else{
            res.send(JSON.stringify({Message:"Falha"}))
        }
    }) 
  
})
// Cars
app.post('/cars_create/', (req, res) => {
    const { preco, anofabrico, cor, marca, modelo, garantia, quantidade } = req.query
    const query = Query('CALL InsertCarro(?, ?, ?, ?, ?, ?, ?)', [parseFloat(preco), anofabrico, cor, marca, modelo, Number(garantia), Number(quantidade)])
    query.catch((error)=>{
        res.send(JSON.stringify({Message:error}))
    })
    query.then((QueryResult)=>{
        if(QueryResult.affectedRows >= 1){
            res.send(JSON.stringify({Message:"Sucess"}))
        }else{
            res.send(JSON.stringify({Message:"Falha"}))
        }
    }) 
  
})

  
app.get('/cars_read/', (req, res) => {
    const { id } = req.query
    const query = Query('CALL GetCarro(?)', [id])
    query.catch((error)=>{
        res.send(JSON.stringify({Message:error}))
    })
    query.then((QueryResult)=>{
        res.send(JSON.stringify(QueryResult))
    }) 
})

app.put('/cars_update/', (req, res) => {
    const { id, preco} = req.query
    const query = Query('CALL UpdateCarro(?, ?)', [id, parseFloat(preco)])
    query.catch((error)=>{
        res.send(JSON.stringify({Message:error}))
    })
    query.then((QueryResult)=>{
        if(QueryResult.affectedRows >= 1){
            res.send(JSON.stringify({Message:"Sucess"}))
        }else{
            res.send(JSON.stringify({Message:"Falha"}))
        }
    }) 
  
})

app.delete('/cars_delete/', (req, res) => {
    const { id } = req.query
    const query = Query('CALL DeleteCarro(?)', [id])
    query.catch((error)=>{
        res.send(JSON.stringify({Message:error}))
    })
    query.then((QueryResult)=>{
        if(QueryResult.affectedRows >= 1){
            res.send(JSON.stringify({Message:"Sucess"}))
        }else{
            res.send(JSON.stringify({Message:"Falha"}))
        }
    }) 
  
})
// Tests
app.post('/tests_create', (req, res) => {
    const { idcliente, idcarro } = req.query
    const query = Query('CALL InsertTeste(?, ?)', [idcliente, idcarro])
    query.catch((error)=>{
        res.send(JSON.stringify({Message:error}))
    })
    query.then((QueryResult)=>{
        if(QueryResult.affectedRows >= 1){
            res.send(JSON.stringify({Message:"Sucess"}))
        }else{
            res.send(JSON.stringify({Message:"Falha"}))
        }
    }) 
  
})

app.get('/tests_read/', (req, res) => {
    const { id } = req.query
    const query = Query('CALL GetTeste(?)', [id])
    query.catch((error)=>{
        res.send(JSON.stringify({Message:error}))
    })
    query.then((QueryResult)=>{
        res.send(JSON.stringify(QueryResult))
    }) 
})


app.delete('/tests_delete/', (req, res) => {
    const { id } = req.query
    const query = Query('CALL DeleteTeste(?)', [id])
    query.catch((error)=>{
        res.send(JSON.stringify({Message:error}))
    })
    query.then((QueryResult)=>{
        if(QueryResult.affectedRows >= 1){
            res.send(JSON.stringify({Message:"Sucess"}))
        }else{
            res.send(JSON.stringify({Message:"Falha"}))
        }
    }) 
  
})
// Purchases
app.post('/purchases_create', (req, res) => {
    const { datacompra, horacompra, quantidade, valorcompra, idcliente, idcarro } = req.query
    const query = Query('CALL InsertCompra(?, ?, ?, ?, ?, ?)', [datacompra, horacompra, quantidade, valorcompra, idcliente, idcarro])
    query.catch((error)=>{
        res.send(JSON.stringify({Message:error}))
    })
    query.then((QueryResult)=>{
        if(QueryResult.affectedRows >= 1){
            res.send(JSON.stringify({Message:"Sucess"}))
        }else{
            res.send(JSON.stringify({Message:"Falha"}))
        }
    }) 
  
})

app.get('/purchases_read/', (req, res) => {
    const { id } = req.query
    const query = Query('CALL GetCompra(?)', [id])
    query.catch((error)=>{
        res.send(JSON.stringify({Message:error}))
    })
    query.then((QueryResult)=>{
        res.send(JSON.stringify(QueryResult))
    }) 
})


app.delete('/purchases_delete/', (req, res) => {
    const { id } = req.query
    const query = Query('CALL DeleteCompra(?)', [id])
    query.catch((error)=>{
        res.send(JSON.stringify({Message:error}))
    })
    query.then((QueryResult)=>{
        if(QueryResult.affectedRows >= 1){
            res.send(JSON.stringify({Message:"Sucess"}))
        }else{
            res.send(JSON.stringify({Message:"Falha"}))
        }
    }) 
  
})


// Credit Cards
app.post('/credit-cards_create', (req, res) => {
    const { numerocartao, datacalidade, codigoseguranca, idcliente } = req.query
    const query = Query('CALL InsertCartaoCredito(?, ?, ?, ?)', [numerocartao, datavalidade, codigoseguranca, idcliente])
    query.catch((error)=>{
        res.send(JSON.stringify({Message:error}))
    })
    query.then((QueryResult)=>{
        if(QueryResult.affectedRows >= 1){
            res.send(JSON.stringify({Message:"Sucess"}))
        }else{
            res.send(JSON.stringify({Message:"Falha"}))
        }
    }) 
  
})

app.get('/credit-cards_read/', (req, res) => {
    const { numero } = req.query
    const query = Query('CALL GetCartaoCredito(?)', [numero])
    query.catch((error)=>{
        res.send(JSON.stringify({Message:error}))
    })
    query.then((QueryResult)=>{
        res.send(JSON.stringify(QueryResult))
    }) 
})

app.put('/credit-cards_update/', (req, res) => {
    const { numero } = req.query
    const { datavalidade } = req.query
    const query = Query('CALL UpdateCartaoCredito(?, ?)', [numero, datavalidade])
    query.catch((error)=>{
        res.send(JSON.stringify({Message:error}))
    })
    query.then((QueryResult)=>{
        if(QueryResult.affectedRows >= 1){
            res.send(JSON.stringify({Message:"Sucess"}))
        }else{
            res.send(JSON.stringify({Message:"Falha"}))
        }
    }) 
  
})

app.delete('/credit-cards_delete/', (req, res) => {
    const { numero } = req.query
    const query = Query('CALL DeleteCartaoCredito(?)', [numero])
    query.catch((error)=>{
        res.send(JSON.stringify({Message:error}))
    })
    query.then((QueryResult)=>{
        if(QueryResult.affectedRows >= 1){
            res.send(JSON.stringify({Message:"Sucess"}))
        }else{
            res.send(JSON.stringify({Message:"Falha"}))
        }
    }) 
  
})

// Client-Employee Relationships
app.post('/call_create', (req, res) => {
    const { idfuncionario, idcliente } = req.query
    const query = Query('CALL InsertLigacao(?, ?)', [idfuncionario, idcliente])
    query.catch((error)=>{
        res.send(JSON.stringify({Message:error}))
    })
    query.then((QueryResult)=>{
        if(QueryResult.affectedRows >= 1){
            res.send(JSON.stringify({Message:"Sucess"}))
        }else{
            res.send(JSON.stringify({Message:"Falha"}))
        }
    }) 
  
})

app.get('/call_read/', (req, res) => {
    const { id } = req.query
    const query = Query('CALL GetLigacao(?)', [id])
    query.catch((error)=>{
        res.send(JSON.stringify({Message:error}))
    })
    query.then((QueryResult)=>{
        res.send(JSON.stringify(QueryResult))
    }) 
})


app.delete('/call_delete/', (req, res) => {
    const { id } = req.query
    const query = Query('CALL DeleteLigacao(?)', [id])
    query.catch((error)=>{
        res.send(JSON.stringify({Message:error}))
    })
    query.then((QueryResult)=>{
        if(QueryResult.affectedRows >= 1){
            res.send(JSON.stringify({Message:"Sucess"}))
        }else{
            res.send(JSON.stringify({Message:"Falha"}))
        }
    }) 
  
})


// Start the server
app.listen(Port, () => {
console.log(`Server is running on http://localhost:${Port}`)
})
