const Submit = document.querySelector("#Submit")

Submit.addEventListener("click",()=>{
    const Req = fetch(`http://localhost:8080/cars_update?id=${document.querySelector("#ID").value}&preco=${document.querySelector("#Price").value}`,{
        method:"PUT"
    })
    Req.catch((error)=>{
        const err = JSON.parse(error) 
        alert(err['Message'])
    })
    Req.then((response)=>{
        alert("Sucesso")
        //const res = JSON.parse(response)
        //alert(res['Message'])
    })
          
})