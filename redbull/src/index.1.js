
var gridHeight = 500;
var gridWidth = 500;

var gridColumns = 4
var gridRows = 4

$(document).ready(function () {
    console.log("document ready");
    // $("#frame").html("anything");
    var canvas = $("#canvas");
    
    var grid = [];
    for (var index = 0; index < gridColumns; index++) {
            console.log(index);
            grid.push({
                strokeStyle: 'white',
                fillStyle: 'black',
                y: 0,
                x: index * (gridWidth / gridColumns),
                width: gridWidth / gridColumns,
                height: gridWidth / gridColumns,
                fromCenter: false
    
            });
    
            console.log(grid[index]);
        }
    for (var index = 0; index < gridColumns; index++) {
        canvas.drawRect(grid[index]);
    }

    var grid = [];
    for (var index = 0; index < gridColumns; index++) {
        console.log(index);
        grid.push({
            strokeStyle: 'white',
            fillStyle: 'black',
            y: 128,
            x: index * (gridWidth / gridColumns),
            width: gridWidth / gridColumns,
            height: gridWidth / gridColumns,
            fromCenter: false

        });

        console.log(grid[index]);
    }
for (var index = 0; index < gridColumns; index++) {
    canvas.drawRect(grid[index]);
}

var grid = [];
for (var index = 0; index < gridColumns; index++) {
    console.log(index);
    grid.push({
        strokeStyle: 'white',
        fillStyle: 'black',
        y: 256,
        x: index * (gridWidth / gridColumns),
        width: gridWidth / gridColumns,
        height: gridWidth / gridColumns,
        fromCenter: false

    });

    console.log(grid[index]);
}
for (var index = 0; index < gridColumns; index++) {
canvas.drawRect(grid[index]);
}

var grid = [];
for (var index = 0; index < gridColumns; index++) {
    console.log(index);
    grid.push({
        strokeStyle: 'white',
        fillStyle: 'black',
        y: 384,
        x: index * (gridWidth / gridColumns),
        width: gridWidth / gridColumns,
        height: gridWidth / gridColumns,
        fromCenter: false

    });

    console.log(grid[index]);
}
for (var index = 0; index < gridColumns; index++) {
canvas.drawRect(grid[index]);
}

draw(); 
var counter = 0;
function draw(){
    var canvas = $("#canvas");
    canvas.clearCanvas()
    counter++;
    canvas.drawRect({
        strokeStyle: 'white',
        fillStyle: 'red',
        y: 0,
        x: counter,
        width: 10,
        height: 10,
        fromCenter: false

    });
    window.requestAnimationFrame(draw);
}
canvas.drawRect( );

});
// console.log("hello planet");
// console.log(getPosition());
function getPosition() {
    return {
        x: 6,
        y: 7
    }
}