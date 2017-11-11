var express = require("express");
const request = require('request');

var path = require("path");
var app = express();
app.use('/', express.static(path.join(__dirname, "../", "/src")));

app.use('/bower_components', express.static(path.join(__dirname, "../", "/bower_components")));
app.use('/data', (req, res) => {
    request('http://localhost:8000/kinect', { json: true }, (err, response, body) => {
        if (err) { return console.log(err); }
        console.log(response.body.kinect);
        var numbers = response.body.kinect.split(',');
        var people = [];
        // console.log("yooo");
        for(var i = 0; i < numbers.length; i +=2){         
                people.push({
                    x: numbers[i],
                    y: numbers[i+1]
                });
                // console.log(" in here" + numbers[i] + " " + numbers[i + 1]);
        }
        
        res.send(people);        
      });
});



app.listen(3000, appOnListen);

function appOnListen() {
    console.log("Example listening on 3000")
}