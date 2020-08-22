const express = require("express");
const router = express.Router();
const pool = require("../pool.js");
const { throws } = require("assert");

// 用户注册路由
router.post('/reg', (req, res) => {
  let uphone = req.body.phoneNum;
  let upwd = req.body.upwd;
  if (upwd == undefined || upwd == '') {
    let sql = "SELECT * FROM slr_user WHERE phoneNum=?"
    pool.query(sql, [uphone], (err, result) => {
      if (err) throw err;
      if (result.length >= 1) {
        res.send({ 'code': 0, 'msg': '号码已被占用' });
      } else {
        res.send({ 'code': 1, 'msg': '可注册' });
      }
    })
  } else {
    let sql = 'INSERT INTO slr_user VALUES(null,null,?,?,null,null,null,null)';
    pool.query(sql, [uphone, upwd], (err, result) => {
      if (err) throw err;
      if (result.affectedRows == 1) {
        res.send({ "code": 1, "msg": "注册成功" });
      } else {
        res.send({ "code": 0, "msg": "注册失败" });
      }
    })
  }
});

// 用户登录路由

router.post('/login', (req, res) => {
  let phone = req.body.phoneNum;
  let upwd = req.body.upwd;
  console.log(req.body)
  let sql = 'SELECT * FROM slr_user WHERE phoneNum=? AND upwd=?';
  pool.query(sql,[phone,upwd],(err,result)=>{
    console.log(result,45646);
    if(err)throw err;
    res.send(result)
  })
});


module.exports = router;