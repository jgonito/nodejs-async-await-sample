const http = require('http');
const mysql = require('mysql');
const router = require('routes')();
const config = require('./config.json');

function getConnection() {
    return new Promise((resolve, reject)=>{
        let pool = mysql.createPool(config.db.mysql);
        pool.getConnection((err, conn)=>{
            if (err) {
                reject(err);
            } else {
                resolve(conn);
            }
        });
    });
}

function getEmployeeInfo(empID) {
    return new Promise((resolve, reject)=>{
        getConnection()
            .then((conn)=>{
                let sql = `SELECT
                                a.emp_id,
                                a.date_hired,
                                a.department_id,
                                b.name AS department,
                                a.designation_id,
                                c.name AS designation,
                                a.schedule_id,
                                d.type AS schedule_type
                            FROM
                                employee_info AS a
                                LEFT OUTER JOIN department AS b ON b.id = a.department_id
                                LEFT OUTER JOIN designation AS c ON c.id = a.designation_id
                                LEFT OUTER JOIN schedule AS d ON d.id = a.schedule_id
                            WHERE a.emp_id=?`
                conn.query(sql, [empID], (err, result)=>{
                    if (err) {
                        reject(err);
                    } else {
                        let r = null;
                        if (result && result.length > 0) {
                            r = result[0];
                        }
                        resolve(r);
                    }
                });
            })
            .catch(reject);
    });
}

function getPersonalInfo(empID) {
    return new Promise((resolve, reject)=>{
        getConnection()
            .then((conn)=>{
                let sql = `SELECT * FROM personal_info WHERE emp_id=?`
                conn.query(sql, [empID], (err, result)=>{
                    if (err) {
                        reject(err);
                    } else {
                        let r = null;
                        if (result && result.length > 0) {
                            r = result[0];
                        }
                        resolve(r);
                    }
                });
            })
            .catch(reject);
    });
}

function getSchedule(scheduleID) {
    return new Promise((resolve, reject)=>{
        getConnection()
            .then((conn)=>{
                let sql = `SELECT
                                day,
                                time_in,
                                time_out,
                                is_restday
                            FROM working_days
                            WHERE schedule_id=?`
                conn.query(sql, [scheduleID], (err, result)=>{
                    if (err) {
                        reject(err);
                    } else {
                        resolve(result);
                    }
                });
            })
            .catch(reject);
    });
}

router.addRoute('/info/:id/?', async (req, res, params)=>{
    let method = req.method.toUpperCase();
    let response = {
            status: '',
            message: '',
            data: null
        };
    
    switch (method) {
        case 'GET':
            let data = await (async (info)=>{
                    let employee = info[0];
                    let personal = info[1];
                    let schedule = (employee && 'schedule_id' in employee)
                                 ? await getSchedule(employee.schedule_id)
                                 : null;

                    return {
                        employee: employee,
                        personal: personal,
                        schedule: schedule
                    };
                })(await Promise.all([
                    getEmployeeInfo(params.id),
                    getPersonalInfo(params.id)
                ]));

            response.status = 'OK';
            response.message = 'Success';
            response.data = data;
            break;
        default:
            response.status = 'ERROR';
            response.message = `Method '${method}' is not supported`;
    }

    res.writeHead(200, {'Content-type':'application/json'});
    res.write(JSON.stringify(response));
    res.end();
});

http.createServer((req, res)=>{
    let route = router.match(req.url);
    if (route) {
        route.fn(req, res, route.params);
    } else {
        res.writeHead(404, {'Content-type':'text/html'});
        res.write('Invalid endpoint');
        res.end();
    }
}).listen(config.port, ()=>{
    console.log(`Server started @localhost:${config.port}`);
});