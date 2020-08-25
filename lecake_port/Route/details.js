const express = require("express");
const router = express.Router();
const pool = require("../pool.js");

// 获取商品列表信息
router.get('/prolist',(req,res)=>{
  let taste=req.query.taste;
  let iscake=req.query.iscake;
  if(taste == ""){
    let sql = "SELECT pid,pname,ptext,img_show,pspecs FROM lecake_product WHERE iscake=?"
    pool.query(sql,[iscake],(err,result)=>{
      if(err)throw err;
      res.send(result);
    })
  }else{
    let sql=`SELECT pid,pname,ptext,img_show,pspecs FROM lecake_product WHERE f_id=(SELECT fid FROM lecake_product_family WHERE fname='${taste}')`;
    pool.query(sql,[iscake],(err,result)=>{
      if(err)throw err;
      res.send(result);
    })
  }
});
// 获取商品详情信息
router.get("/info",(req,res)=>{
  let pid=req.query.pid;

  let sql=`SELECT * FROM lecake_product WHERE pid=${pid}`;
  pool.query(sql,(err,result)=>{
    if(err)throw err;
    res.send(result);
  })
});
router.get('/rec',(req,res)=>{
  let pid=req.query.pid;
  let iscake=req.query.iscake;
  let sql = `SELECT pid,pname,ptext,img_show,pspecs FROM lecake_product WHERE iscake=${iscake} AND pid!=${pid} `;
  pool.query(sql,(err,result)=>{
    if(err)throw err;
    res.send(result);
  })
})



module.exports = router;