// 引入模块
const express = require("express");
const querystring = require("querystring");
const bodyParser = require("body-parser");
const cors = require('cors');
const app = express();
// 解决跨域问题
app.use(cors({
    origin: [
        'http://127.0.0.1:8080',
        'http://localhost:8080',
        'http://127.0.0.1:8081',
        'http://localhost:8081',
        'http://127.0.0.1:8082',
        'http://localhost:8082',
        'http://127.0.0.1:8083',
        'http://localhost:8083',
    ]
}))
app.listen(3000, () => { console.log("running.....") });

app.use(bodyParser.urlencoded({
    extended: false
}));

app.use("/public", express.static('public'));


const userRouter = require("./Route/user.js");
app.use("/user", userRouter);
const indexRouter = require("./Route/index.js");
app.use("/index", indexRouter);
const detailRouter = require("./Route/details.js");
app.use("/detail", detailRouter);