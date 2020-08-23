const express = require("express");
const router = express.Router();
const pool = require("../pool.js");

router.get('/prolist',(req,res)=>{
  let taste=req.query.taste;
  let iscake=req.query.iscake;
  if(taste==undefined){
    let sql = "SELECT pid,pname,ptext,img_show,pspecs FROM lecake_product WHERE iscake=?"
    pool.query(sql,[iscake],(err,result)=>{
      if(err)throw err;
      res.send(result);
    })
  }else{
    let sql=`SELECT pid,pname,ptext,img_show,pspecs FROM lecake_product WHERE iscake=? AND pedible LIKE '%${taste}%'`;
    pool.query(sql,[iscake],(err,result)=>{
      if(err)throw err;
      res.send(result);
    })
  }
})

module.exports = router;