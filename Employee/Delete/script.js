const Submit = document.querySelector("#Submit")

Submit.addEventListener("click",()=>{
    const Req = fetch(`http://localhost:8080/employee_delete?employeeid=${document.querySelector("#ID").value}`,{
        method:"DELETE"
    })
    Req.catch((error)=>{
        const err = JSON.parse(error) 
        alert(err['Message'])
    })
    Req.then((response)=>{
        // const res = JSON.parse(response)
        // alert(res['Message'])
        alert("Sucesso")
    })
    
        
})