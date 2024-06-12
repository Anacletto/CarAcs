const Submit = document.querySelector("#Submit")

let idClient = document.querySelector("#idClient")
let idCar = document.querySelector("#idCar")

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

    const Req = makeRequest("POST",`http://localhost:8080/tests_create?idcliente=${idClient.value}&idcarro=${idCar.value}`)
    Req.catch((error)=>{
        const err = JSON.parse(error)
        alert(err['Message'])
    })
    Req.then((response)=>{
        const res = JSON.parse(response)
        alert(res['Message'])
    })
    
})