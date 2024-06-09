import {express} from "express"
import { createConnection } from "mysql2"

const App = express();
const port = 8080;

// Create DB connection
const DB = createConnection({
    host: 'localhost',
    user: 'root',
    password: 'CoderLife',
    database: 'carAcsDB',
    port:3306
});

// Middleware to parse JSON bodies
App.use(express.json());

// Clients CRUD operations
App.post('/clients', (req, res) => {
    const { primeiroNome, sobrenome, anoNascimento, bairro, provincia, cidade } = req.body;
   DB.query('CALL CreateClient(?, ?, ?, ?, ?, ?)', [primeiroNome, sobrenome, anoNascimento, bairro, provincia, cidade], (error, results) => {
        if (error) throw error;
        res.json(results);
    });
});

App.get('/clients/:id', (req, res) => {
    const clientId = req.params.id;
   DB.query('CALL ReadClient(?)', [clientId], (error, results) => {
        if (error) throw error;
        res.json(results[0]);
    });
});

App.delete('/clients/:id', (req, res) => {
    const clientId = req.params.id;
   DB.query('CALL DeleteClient(?)', [clientId], (error, results) => {
        if (error) throw error;
        res.json({ message: 'Client deleted successfully' });
    });
});

// Add routes for other clients CRUD operations like updating first name, last name, etc.

// Employees CRUD operations
App.post('/employees', (req, res) => {
    const { primeiroNome, sobrenome, anoNascimento, bairro, provincia, cidade, telefone } = req.body;
   DB.query('CALL CreateEmployee(?, ?, ?, ?, ?, ?, ?)', [primeiroNome, sobrenome, anoNascimento, bairro, provincia, cidade, telefone], (error, results) => {
        if (error) throw error;
        res.json(results);
    });
});

App.get('/employees/:id', (req, res) => {
    const employeeId = req.params.id;
   DB.query('CALL ReadEmployee(?)', [employeeId], (error, results) => {
        if (error) throw error;
        res.json(results[0]);
    });
});

// Add routes for other employees CRUD operations like updating first name, last name, etc.

// Credit cards CRUD operations
App.post('/creditcards', (req, res) => {
    const { numeroCartao, dataValidade, codigoSeguranca, idCliente } = req.body;
   DB.query('CALL InsertCartaoCredito(?, ?, ?, ?)', [numeroCartao, dataValidade, codigoSeguranca, idCliente], (error, results) => {
        if (error) throw error;
        res.json(results);
    });
});

App.get('/creditcards/:numeroCartao', (req, res) => {
    const numeroCartao = req.params.numeroCartao;
   DB.query('CALL GetCartaoCreditoById(?)', [numeroCartao], (error, results) => {
        if (error) throw error;
        res.json(results[0]);
    });
});

// Add routes for other credit cards CRUD operations like updating data, deleting, etc.

// Tests CRUD operations
App.post('/tests', (req, res) => {
    const { dataTeste, horaTeste } = req.body;
   DB.query('CALL InsertTeste(?, ?)', [dataTeste, horaTeste], (error, results) => {
        if (error) throw error;
        res.json(results);
    });
});

App.get('/tests/:id', (req, res) => {
    const testId = req.params.id;
   DB.query('CALL SelectTestes()', [testId], (error, results) => {
        if (error) throw error;
        res.json(results[0]);
    });
});

// Add routes for other tests CRUD operations like updating data, deleting, etc.

App.listen(port, () => {
    console.log(`Server is listening at http://localhost:${port}`);
});