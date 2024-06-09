import { Query} from "./DB.mjs"
import express  from "express"

const Port = 8080
const app = express()

app.use(express.json())

// API endpoints

// Clients
app.post('/clients/create/', (req, res) => {
  const { primeiroNome, sobrenome, anoNascimento, bairro, provincia, cidade } = req.body
  const query = Query('CALL InsertCliente(?, ?, ?, ?, ?, ?)',[primeiroNome, sobrenome, anoNascimento, bairro, provincia, cidade])
    query.catch(()=>{})
    query.then(()=>{}) 
  
})


app.get('/clients/read/:id', (req, res) => {
  const { id } = req.params
  const query = Query('CALL GetCliente(?)', [id])
    query.catch(()=>{})
    query.then(()=>{}) 
})


app.put('/clients/update/:id', (req, res) => {
  const { id } = req.params
  const { primeiroNome, sobrenome, anoNascimento, bairro, provincia, cidade } = req.body
  const query = Query('CALL UpdateCliente(?, ?, ?, ?, ?, ?, ?)', [id, primeiroNome, sobrenome, anoNascimento, bairro, provincia, cidade])
    query.catch(()=>{})
    query.then(()=>{}) 
})


app.delete('/clients/delete/:id', (req, res) => {
  const { id } = req.params
  const query = Query('CALL DeleteCliente(?)', [id])
    query.catch(()=>{})
    query.then(()=>{}) 
})


// Employees
app.post('/employee/create', (req, res) => {
  const { primeiroNome, sobrenome, provincia, cidade, bairro, telefone } = req.body
  const query = Query('CALL InsertFuncionario(?, ?, ?, ?, ?, ?)', [primeiroNome, sobrenome, provincia, cidade, bairro, telefone])
    query.catch(()=>{})
    query.then(()=>{}) 
})


app.get('/employee/read/:id', (req, res) => {
    const employeeId = req.params.id;
    const query = Query('CALL GetFuncionario(?)', [employeeId])
    query.catch(()=>{})
    query.then(()=>{})     
})

app.put('/employee/update/:id', (req, res) => {
    const employeeId = req.params.id;
    const { primeiroNome, sobrenome, provincia, cidade, bairro, telefone } = req.body;
    const query = Query('CALL UpdateFuncionario(?, ?, ?, ?, ?, ?, ?)', [employeeId, primeiroNome, sobrenome, provincia, cidade, bairro, telefone])
    query.catch(()=>{})
    query.then(()=>{})     
})

  // Delete an employee
app.delete('/employee/delete/:id', (req, res) => {
    const employeeId = req.params.id;
    const query = Query('CALL DeleteFuncionario(?)', [employeeId])
    query.catch(()=>{})
    query.then(()=>{}) 
})


// Cars
app.post('/cars/create/', (req, res) => {
    const { preco, anoFabrico, cor, marca, modelo, garantia, quantidadeDisponivel } = req.body
    const query = Query('CALL InsertCarro(?, ?, ?, ?, ?, ?, ?)', [preco, anoFabrico, cor, marca, modelo, garantia, quantidadeDisponivel])
    query.catch(()=>{})
    query.then(()=>{})     
})

  
app.get('/cars/read/:id', (req, res) => {
    const { id } = req.params
    const query = Query('CALL GetCarro(?)', [id])
    query.catch(()=>{})
    query.then(()=>{}) 
})

app.put('/cars/update/:id', (req, res) => {
    const { id } = req.params
    const { preco, anoFabrico, cor, marca, modelo, garantia, quantidadeDisponivel } = req.body
    const query = Query('CALL UpdateCarro(?, ?, ?, ?, ?, ?, ?, ?)', [id, preco, anoFabrico, cor, marca, modelo, garantia, quantidadeDisponivel])
    query.catch(()=>{})
    query.then(()=>{}) 
})

app.delete('/cars/delete/:id', (req, res) => {
    const { id } = req.params
    const query = Query('CALL DeleteCarro(?)', [id])
    query.catch(()=>{})
    query.then(()=>{}) 
})


// Tests
app.post('/tests/create', (req, res) => {
    const { id, dataTeste, horaTeste, idcliente, idcarro } = req.body
    const query = Query('CALL InsertTeste(?, ?, ?, ?, ?)', [id, dataTeste, horaTeste, idcliente, idcarro])
    query.catch(()=>{})
    query.then(()=>{}) 
})


app.get('/tests/read/:id', (req, res) => {
    const { id } = req.params
    const query = Query('CALL GetTeste(?)', [id])
    query.catch(()=>{})
    query.then(()=>{}) 
})


app.put('/tests/update/:id', (req, res) => {
    const { id } = req.params
    const { dataTeste, horaTeste, idcliente, idcarro } = req.body
    const query = Query('CALL UpdateTeste(?, ?, ?, ?, ?)', [id, dataTeste, horaTeste, idcliente, idcarro])
    query.catch(()=>{})
    query.then(()=>{}) 
})


app.delete('/tests/delete/:id', (req, res) => {
    const { id } = req.params
    const query = Query('CALL DeleteTeste(?)', [id])
    query.catch(()=>{})
    query.then(()=>{}) 
})

// Purchases
app.post('/purchases/create', (req, res) => {
    const { dataCompra, horaCompra, quantidade, valorCompra, idcliente, idcarro } = req.body
    const query = Query('CALL InsertCompra(?, ?, ?, ?, ?, ?)', [dataCompra, horaCompra, quantidade, valorCompra, idcliente, idcarro])
    query.catch(()=>{})
    query.then(()=>{}) 
})


app.get('/purchases/read/:id', (req, res) => {
    const { id } = req.params
    const query = Query('CALL GetCompra(?)', [id])
    query.catch(()=>{})
    query.then(()=>{}) 
})


app.put('/purchases/update/:id', (req, res) => {
    const { id } = req.params
    const { dataCompra, horaCompra, quantidade, valorCompra, idcliente, idcarro } = req.body
    const query = Query('CALL UpdateCompra(?, ?, ?, ?, ?, ?, ?)', [id, dataCompra, horaCompra, quantidade, valorCompra, idcliente, idcarro])
    query.catch(()=>{})
    query.then(()=>{}) 
})


app.delete('/purchases/delete/:id', (req, res) => {
    const { id } = req.params
    const query = Query('CALL DeleteCompra(?)', [id])
    query.catch(()=>{})
    query.then(()=>{}) 
})


// Client-Employee Relationships
app.post('/client-employee', (req, res) => {
    const { idfuncionario, idcliente } = req.body
    const query = Query('CALL InsertLigacao(?, ?)', [idfuncionario, idcliente])
    query.catch(()=>{})
    query.then(()=>{}) 
})


app.get('/client-employee/:id', (req, res) => {
    const { id } = req.params
    const query = Query('CALL GetLigacao(?)', [id])
    query.catch(()=>{})
    query.then(()=>{}) 
})

  
// Credit Cards
app.post('/credit-cards/create', (req, res) => {
    const { numeroCartao, dataValidade, codigoSeguranca, idCliente } = req.body
    const query = Query('CALL InsertCartaoCredito(?, ?, ?, ?)', [numeroCartao, dataValidade, codigoSeguranca, idCliente])
    query.catch(()=>{})
    query.then(()=>{}) 
})

app.get('/credit-cards/read/:numero', (req, res) => {
    const { numero } = req.params
    const query = Query('CALL GetCartaoCredito(?)', [numero])
    query.catch(()=>{})
    query.then(()=>{}) 
})


app.put('/credit-cards/update/:numero', (req, res) => {
    const { numero } = req.params
    const { dataValidade, codigoSeguranca, idCliente } = req.body
    const query = Query('CALL UpdateCartaoCredito(?, ?, ?, ?)', [numero, dataValidade, codigoSeguranca, idCliente])
    query.catch(()=>{})
    query.then(()=>{}) 
})

app.delete('/credit-cards/delete/:numero', (req, res) => {
    const { numero } = req.params
    const query = Query('CALL DeleteCartaoCredito(?)', [numero])
    query.catch(()=>{})
    query.then(()=>{}) 
})


app.put('/client-employee/:cliente/:funcionario', (req, res) => {
    const { cliente, funcionario } = req.params
    const { novo_idcliente, novo_idfuncionario } = req.body
    const query = Query('CALL UpdateLigacao(?, ?, ?, ?)', [cliente, funcionario, novo_idcliente, novo_idfuncionario])
    query.catch(()=>{})
    query.then(()=>{}) 
})


app.delete('/client-employee/:cliente/:funcionario', (req, res) => {
    const { cliente, funcionario } = req.params
    const query = Query('CALL DeleteClienteLigaFuncionario(?, ?)', [cliente, funcionario])
    query.catch(()=>{})
    query.then(()=>{}) 
})



// Start the server
app.listen(Port, () => {
console.log(`Server is running on http://localhost/${Port}`)
})
