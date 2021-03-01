old_time_stamp = pm.environment.get("TTIME_STAMP")

time_diff = Math.floor((new Date() - new Date(old_time_stamp)) / 3600000)

if (time_diff < 11) {
    return
}

pm.sendRequest({
    url: pm.environment.get("URL") + '/auth/login',
    method: 'POST',
    header: {
        'content-type': 'application/json',
    },
    body: {
        mode: 'raw',
        raw: JSON.stringify({
            "email": "scho@texadasoftware.com",
            "password": "TEST1",
            "clientID": "test_client_id",
            "companyID": 1,
        })
    }
}, function (err, res) {
    pm.environment.set("TOKEN", res.json().authToken);
    pm.environment.set("TTIME_STAMP", new Date())
});
