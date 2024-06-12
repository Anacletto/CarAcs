const Submit = document.querySelector("#Submit")

let Price = document.querySelector("#Price")
let MakeYear = document.querySelector("#MakeYear")
let Color = document.querySelector("#Color")
let Maker = document.querySelector("#Maker")
let Model = document.querySelector("#Model")
let Warranty = document.querySelector("#Warranty")
let Quantity = document.querySelector("#Quantity")

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

    const Req = makeRequest("POST",`http://localhost:8080/cars_create?preco=${Price.value}&anofabrico=${MakeYear.value}&cor=${Color.value}&marca=${Maker.value}&modelo=${Model.value}&garantia=${Warranty.value}&quantidade=${Quantity.value}`)
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