const Submit = document.querySelector("#Submit")

let primeiroNome = document.querySelector("#FirstName")
let sobrenome = document.querySelector("#LastName")
let telefone = document.querySelector("#Phone")
let bairro = document.querySelector("#Neighborhood")
let provincia = document.querySelector("#Province")
let cidade = document.querySelector("#City")

const XHR = new XMLHttpRequest()

const makeRequest  = function makeRequest(method, Url){
    return new Promise((res,rej) => {
        XHR.open(method,Url)
        XHR.send()
        XHR.onload = () =>{
            if(XHR.response){
                res(XHR.response)
            }else{

                rej(XHR.response)
            }
        } 

    })
}

Submit.addEventListener("click",()=>{

    const Req = makeRequest("POST",`http://localhost:8080/employee_create?primeironome=${primeiroNome.value}&sobrenome=${sobrenome.value}&bairro=${bairro.value}&provincia=${provincia.value}&cidade=${cidade.value}&telefone=${telefone.value}`)
    Req.catch((error)=>{
        const err = JSON.parse(error)
        console.log(err)
        alert(err['Message'])
    })
    Req.then((response)=>{
        const res = JSON.parse(response)
        alert(res['Message'])
    })
    
})