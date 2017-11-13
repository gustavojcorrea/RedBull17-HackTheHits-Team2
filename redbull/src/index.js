var gridHeight = 500;
var gridWidth = 375;

var gridColumns = 4
var gridRows = 3

var kinectPeople = [];

$(document).ready(function () {

    console.log("document ready");
    // $("#frame").html("anything");
    var canvas = $("#canvas");

    var grid = [];
    for (var index = 0; index < gridColumns; index++) {

        console.log(index);
        grid.push({
            strokeStyle: 'black',
            fillStyle: 'white',
            strokeWidth: 2,
            y: 0,
            x: index * (gridHeight / gridColumns),
            width: gridWidth / gridRows,
            height: gridHeight / gridColumns,
            fromCenter: false
        });

        console.log(grid[index]);
    }

    var soundMode = 0;
    if (soundMode == 0) {
        var Snd1Col1 = 'bassDrumTriplets.wav';
        var Snd2Col1 = 'bassDrumDoub.wav';
        var Snd3Col1 = 'BD3.wav';
        var Snd1Col2 = 'HH1.wav';
        var Snd2Col2 = 'hhTrip.wav';
        var Snd3Col2 = 'HH3.wav';
        var Snd1Col3 = 'snare1.wav';
        var Snd2Col3 = 'snareDoub.wav';
        var Snd3Col3 = 'snareUpbeat.wav';
        var Snd1Col4 = 'quartz.wav';
        var Snd2Col4 = 'redBullCan.wav';
        var Snd3Col4 = 'sciFi.wav';
    } else {
        var Snd1Col1 = 'BSound.wav';
        var Snd2Col1 = 'CSound.wav';
        var Snd3Col1 = 'CsharpSound.wav';
        var Snd1Col2 = 'EflatSound.wav';
        var Snd2Col2 = 'ESound.wav';
        var Snd3Col2 = 'FSound.wav';
        var Snd1Col3 = 'GflatSound.wav';
        var Snd2Col3 = 'GSound.wav';
        var Snd3Col3 = 'GsharpSound.wav';
        var Snd1Col4 = 'BflatSound.wav';
        var Snd2Col4 = 'BhighSound.wav';
        var Snd3Col4 = 'ChighSound.wav';
    }

    //group 1
    var synthSound1Col1 = new Howl({
        urls: [Snd1Col1],
        volume: 0.5,
        onend: function () {
            console.log('Finished!');
        }
    });
    var synthSound2Col1 = new Howl({
        urls: [Snd2Col1],
        volume: 0.5,
        onend: function () {
            console.log('Finished!');
        }
    });
    var synthSound3Col1 = new Howl({
        urls: [Snd3Col1],
        volume: 0.5,
        onend: function () {
            console.log('Finished!');
        }
    });

    //group 2
    var synthSound1Col2 = new Howl({
        urls: [Snd1Col2],
        volume: 0.5,
        onend: function () {
            console.log('Finished!');
        }
    });
    var synthSound2Col2 = new Howl({
        urls: [Snd2Col2],
        volume: 0.5,
        onend: function () {
            console.log('Finished!');
        }
    });
    var synthSound3Col2 = new Howl({
        urls: [Snd3Col2],
        volume: 0.5,
        onend: function () {
            console.log('Finished!');
        }
    });

    //group 3
    var synthSound1Col3 = new Howl({
        urls: [Snd1Col3],
        volume: 0.5,
        onend: function () {
            console.log('Finished!');
        }
    });
    var synthSound2Col3 = new Howl({
        urls: [Snd2Col3],
        volume: 0.5,
        onend: function () {
            console.log('Finished!');
        }
    });
    var synthSound3Col3 = new Howl({
        urls: [Snd3Col3],
        volume: 0.5,
        onend: function () {
            console.log('Finished!');
        }
    });

    //group 4
    var synthSound1Col4 = new Howl({
        urls: [Snd1Col4],
        volume: 0.5,
        onend: function () {
            console.log('Finished!');
        }
    });
    var synthSound2Col4 = new Howl({
        urls: [Snd2Col4],
        volume: 0.5,
        onend: function () {
            console.log('Finished!');
        }
    });
    var synthSound3Col4 = new Howl({
        urls: [Snd3Col4],
        volume: 0.5,
        onend: function () {
            console.log('Finished!');
        }
    });

    var highlightPos = 0

    function draw() {
        var canvas = $("#canvas");
        canvas.clearCanvas()
        for (var index = 0; index < gridColumns; index++) {
            for (var r = 0; r < gridRows; r++) {
                grid[index].y = r * (gridHeight / gridColumns);
                canvas.drawRect(grid[index]);
            }
        }
        for (var index = 0; index < kinectPeople.length; index++) {
            canvas.drawRect({
                strokeStyle: 'white',
                fillStyle: 'red',
                y: kinectPeople[index].y * (gridWidth / gridRows) - (gridWidth / gridRows) / 2,
                x: kinectPeople[index].x * (gridHeight / gridColumns) - (gridHeight / gridColumns) / 2,
                width: 50,
                height: 50
            });
        }
        play();
        canvas.drawRect({
            fillStyle: 'rgba(255, 0, 0, .2)',
            x: highlightPos,
            y: 0,
            width: 500 / gridColumns,
            height: 375,
            fromCenter: false
        });
        window.requestAnimationFrame(draw);
    }
    var counter = 0;

    function play() {
        if (counter == 0 * 30 || counter == 1 * 30 || counter == 2 * 30 || counter == 3 * 30) {
            console.log("Beat", counter / 30 + 1);
        }

        switch (counter) {
            case 0 * 30:
                break;
            case 1 * 30:
                break;
            case 2 * 30:
                break;
            case 3 * 30:
                break;
        }

        if (counter % 30 == 0) {
            highlightPos = (500 / gridColumns) * Math.round(counter / 30)
            loadData();
            findRow();
        }

        counter += 1; // 1 / 30 * 30

        if (counter >= 4 * 30) {
            counter = 0
        }

        function findRow() {
            var beat = counter / 30 + 1;
            console.log(beat);
            for (var i = 0; i < kinectPeople.length; i++) {
                if (kinectPeople[i].x == beat) {
                    playSound(beat, kinectPeople[i].y);
                }
            }
        }

        function playSound(beat, number) {
            //col 1
            if (number == 1 && beat == 1) {
                synthSound1Col1.play();
            }
            if (number == 2 && beat == 1) {
                synthSound2Col1.play();
            }
            if (number == 3 && beat == 1) {
                synthSound3Col1.play();
            }

            //col2
            if (number == 1 && beat == 2) {
                synthSound1Col2.play();
            }
            if (number == 2 && beat == 2) {
                synthSound2Col2.play();
            }
            if (number == 3 && beat == 2) {
                synthSound3Col2.play();
            }

            //col3
            if (number == 1 && beat == 3) {
                synthSound1Col3.play();
            }
            if (number == 2 && beat == 3) {
                synthSound2Col3.play();
            }
            if (number == 3 && beat == 3) {
                synthSound3Col3.play();
            }

            //col4
            if (number == 1 && beat == 4) {
                synthSound1Col4.play();
            }
            if (number == 2 && beat == 4) {
                synthSound2Col4.play();
            }
            if (number == 3 && beat == 4) {
                synthSound3Col4.play();
            }
        }
    }
    draw();

});

//getting postion from kinect coordinates
function getPosition() {
    return [{
            x: 6,
            y: 7
    }, {
            x: 50,
            y: 70
    }, {
            x: 100,
            y: 100
    }, {
            x: 200,
            y: 200
    }
    ]
}

function getPeople() {
    return kinectPeople;
}
var counter = 0;

function loadData() {
    $.get('http://localhost:3000/data' + '?id=' + counter, {}, function (res) {
        console.log(res);
        kinectPeople = res;
    });
    counter++;
}
