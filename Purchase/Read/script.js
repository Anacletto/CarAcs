const Submit = document.querySelector("#Submit")

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

const Container = document.querySelector("#Container")

Submit.addEventListener("click",()=>{
    const Req = makeRequest("GET",`http://localhost:8080/tests_read?id=${document.querySelector("#ID").value}`)
    
    Req.catch((error)=>{
        const err = JSON.parse(error) 
        alert(err['Message'])
    })
    Req.then((response)=>{
            const User = JSON.parse(response)[0][0]
            console.log(User)
            Container.innerHTML =  `<h1>Carro</h1> <li>ID: ${User['id']}</li>  <li>Id carro: ${User['idcarro']}</li> <li>Id cliente :${User['idcliente']}</li> <li>  Hora do teste: ${User['horaTeste']}</li><li> Data do teste: ${User['dataTeste']}</li> `

    


    })
        
})