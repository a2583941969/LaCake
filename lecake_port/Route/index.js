const express = require("express");
const router = express.Router();
const pool = require("../pool.js");

// 首页商品查询接口
// router.get('/pro', (req, res) => {
//     var sql = "SELECT * FROM slr_product where index_rex=1";
//     pool.query(sql, (err, result) => {
//         if (err) throw err;
//         res.send(result);
//     });
// });


// 首页轮播图接口
router.get('/banner', (req, res) => {
	var sql = "SELECT * FROM lecake_index_carousel"
	pool.query(sql, (err, result) => {
		if (err) throw err;
		res.send(result);
	})
})



module.exports = router;