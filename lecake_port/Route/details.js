const express = require("express");
const router = express.Router();
const pool = require("../pool.js");
router.get('/pro', (req, res) => {
  // 页数
  let page = req.query.page;
  // 每页商品的数量
  let pageSize = 12;
  // 开始查询的值
  let start = (page - 1) * pageSize;
  // console.log(req.query.kw)
  // 判断是否请求是否包含参数 是-->false   否-->true
  if (req.query.kw === undefined) {
    let sql = `SELECT COUNT(pid) AS count FROM slr_product`;
    pool.query(sql, (err, s) => {
      if (err) throw err;
      // 商品总数据
      let count = s[0].count;
      // 商品页数
      let totalpage = Math.ceil(s[0].count / pageSize);
      sql = `SELECT pid,brand,pname,price,discount,idx_img FROM slr_product limit ${start},${pageSize}`
      pool.query(sql, (err, result) => {
        if (err) throw err;
        res.send({
          "code": 1,
          totalpage,
          count,
          result
        });
      });
    })
  } else if (page === undefined) {
    let kw = req.query.kw;
    sql = `SELECT pid, pname FROM slr_product WHERE pname LIKE '%${kw}%' limit 0,4`;
    pool.query(sql, (err, result) => {
      if (err) throw err;
      res.send(result);
    });
  } else {
    let kw = req.query.kw;
    // 模糊查找数据总数
    let sql = `
                SELECT COUNT(pid) AS count FROM slr_product WHERE pname LIKE '%${kw}%'
                `;
    pool.query(sql, (err, s) => {
      if (err) throw err;
      // 商品总数据
      let count = s[0].count;
      // 商品的总页数 
      let totalpage = Math.ceil(s[0].count / pageSize);
      sql = `SELECT pid, brand, pname, price, discount, idx_img FROM slr_product WHERE pname LIKE '%${kw}%' limit ${start}, ${pageSize}`;
      pool.query(sql, (error, result) => {
        if (error) throw err;
        res.send({
          "code": 1,
          totalpage,
          count,
          result
        });
      })
    })
  }
});

router.get('/del', (req, res) => {
  let pid = req.query.pid;
  let color = req.query.color;
  // 外键查询
  // console.log(color, 1);
  if (color == undefined) {
    let sql = `SELECT * FROM slr_product WHERE pid=${pid}`;
    pool.query(sql, (err, result) => {
      if (err) throw err;
      res.send(result);
    });
  }
  else if(color==""){
    let sql = `SELECT * FROM slr_product_img WHERE pro_id=${pid}`;
    pool.query(sql, (err, result) => {
      if (err) throw err;
      res.send(result);
    });
  }else {
    let sql = `SELECT * FROM slr_product_img WHERE pro_id=${pid} and color='${color}'`;
    pool.query(sql, (err, result) => {
      if (err) throw err;
      res.send(result);
    });
  }
});



// 请求购物车数据接口
router.get('/shop',(req,res)=>{
  let uid=req.query.uid;
  let sql = 'SELECT s.scount,s.pro_id,s.pro_color,s.is_checked,p.brand,p.pname,p.spec,p.price,p.discount,p.idx_img FROM slr_product AS p,slr_shopping_car AS s WHERE p.pid = s.pro_id AND s.use_id = ?';
  pool.query(sql,[uid],(err,result)=>{
    if(err)throw err;
    res.send(result)
  })
});


// 添加购物车接口
router.post('/addpro',(req,res)=>{
  // 接受到的数据中的必有数据
  // 用户ID   uid  购物车字段名 user_id
  // 商品ID   pid           pro_id
  // 商品数量  count        scount
  // 可能包含的数据
  // 商品颜色  pcolor       pro_color
  let obj=req.data;
  console.log(obj)
  if(obj.pcolor==undefined || obj.pcolor==""){
    let sql=`INSERT INTO slr_shopping_car VALUE(null,?,DEFAULT,?,?,DEFAULT)`
    pool.query(sql,[obj.count,obj.uid,obj.pid],(err,result)=>{
      if(err)throw err;
      res.send(result);
    });
  }
});


module.exports = router;