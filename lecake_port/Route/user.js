const express = require("express");
const router = express.Router();
const pool = require("../pool.js");


// 用户验证码路由
router.get('/code',(req,res)=>{
  let c=Math.floor(Math.random()*1000000).toString();
  res.send(c);
});

// 用户手机注册登录路由
router.post('/login',(req,res)=>{
  let phoneNum=req.body.phoneNum;
  pool.query("SELECT * FROM lecake_user WHERE phoneNum=?",[phoneNum],(err,result)=>{
    if(err)throw err;
    if(result.length==0){
      pool.query("INSERT INTO lecake_user VALUES(NULL,?,NULL,NULL,NULL,DEFAULT)",[phoneNum],(err,result)=>{
        if(err)throw err;
        console.log(result);
        res.send({"code":1,"msg":"登录成功"});
      })
    }else{
      res.send({"code":1,"msg":"登录成功"});
    }
  })
});

// 用户登录

router.post('/log',(req,res)=>{
  let account=req.body.account;
  let pwd=req.body.pwd;
  let sql = `SELECT * FROM lecake_user WHERE phoneNum=${account} AND upwd='${pwd}'`;
  pool.query(sql,(err,result)=>{
    if(err)throw err;
    if(result.length==0){
      res.send({"code":0,"msg":"登录失败"})
    }else{
      res.send({"code":1,"msg":"登录成功"});
    }
  })
});

// 用户设置密码的接口
router.post('/pwd',(req,res)=>{
  let phone=req.body.account;
  let pwd=req.body.pwd;
  let sql=`UPDATE lecake_user SET upwd='${pwd}' WHERE phoneNum=${phone}`;
  pool.query(sql,(err,result)=>{
    if(err)throw err;
    if(result.affectedRows==1){
      console.log(11)
      res.send({"code":1,"msg":"修改成功"});
    }else{
      console.log(22)
      res.send({"code":0,"msg":"修改失败"});
    }
  })
});

module.exports = router;