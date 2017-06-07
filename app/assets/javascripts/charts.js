var loadBinaryDownloadsData = function(){
                $.ajax({
                  type: 'GET',
                  contentType: 'application/json; charset=utf-8',
                  url: '/api/v1/binary_downloads_by_date',
                  dataType: 'json',
                  success: function(data){
                    drawBinaryDownloadsPlot(data);
                  },
                  failure: function(result){
                    error();
                  }
                });
              };

function drawBinaryDownloadsPlot(data) {
  var svg = dimple.newSvg('#binary_downloads_by_date_plot', "90%", "100%");
  var chart = new dimple.chart(svg, data);
  chart.defaultColors = [
    new dimple.color("#4ca4ec", "#007ee5", 1), // blue
    new dimple.color("#FDC381", "#DDAC75", 1), // orange
    new dimple.color("#C2E587", "#ABC879", 1), // green
    new dimple.color("#A4DCD2", "#91C1B8", 1), // turquoise
    new dimple.color("#FC998E", "#DB897F", 1), // red
    new dimple.color("#C999CA", "#B189B1", 1) // purple
  ];
  // chart.setBounds(60, 20, 770, 300);
  
  chart.addTimeAxis("x", "Date", "%Y-%m-%d", "%b %Y");
  var y = chart.addMeasureAxis("y", "Accumulated Downloads", null, 'Date');
  y.showGridlines = false;
  y.fontSize = 12;
  var s = chart.addSeries(null, dimple.plot.area);
  s.interpolation = "cardinal";
  // var lines = chart.addSeries(null, dimple.plot.line);
  // lines.lineWeight = 3;

  chart.draw();
}

var loadBinaryDownloadsPubPrivData = function(){
                $.ajax({
                  type: 'GET',
                  contentType: 'application/json; charset=utf-8',
                  url: '/api/v1/binary_downloads_public_v_private',
                  dataType: 'json',
                  success: function(data){
                    drawBinaryDownloadsPubPrivPlot(data);
                  },
                  failure: function(result){
                    error();
                  }
                });
              };

function drawBinaryDownloadsPubPrivPlot(data) {
  var svg = dimple.newSvg('#binary_downloads_public_v_private_plot', "100%", "100%");
  var chart = new dimple.chart(svg, data);
  chart.defaultColors = [
    new dimple.color("#4ca4ec", "#007ee5", 1), // blue
    new dimple.color("#FDC381", "#DDAC75", 1), // orange
    new dimple.color("#C2E587", "#ABC879", 1), // green
    new dimple.color("#A4DCD2", "#91C1B8", 1), // turquoise
    new dimple.color("#FC998E", "#DB897F", 1), // red
    new dimple.color("#C999CA", "#B189B1", 1) // purple
  ];
  chart.addMeasureAxis("p", "downloads");
  chart.addSeries('permission', dimple.plot.pie);
  myLegend = chart.addLegend("75%", "15%", "10%", "20%", "left");
  myLegend.fontSize = "1.5em";
  chart.draw();
}

var loadBinariesByTypeData = function(){
                $.ajax({
                  type: 'GET',
                  contentType: 'application/json; charset=utf-8',
                  url: '/api/v1/binaries_by_type',
                  dataType: 'json',
                  success: function(data){
                    drawBinariesByTypePlot(data);
                  },
                  failure: function(result){
                    error();
                  }
                });
              };

function drawBinariesByTypePlot(data) {
  var svg = dimple.newSvg('#binaries_by_type_plot', "100%", "100%");
  var chart = new dimple.chart(svg, data);
  chart.defaultColors = [
    new dimple.color("#4ca4ec", "#007ee5", 1), // blue
    new dimple.color("#FDC381", "#DDAC75", 1), // orange
    new dimple.color("#C2E587", "#ABC879", 1), // green
    new dimple.color("#A4DCD2", "#91C1B8", 1), // turquoise
    new dimple.color("#FC998E", "#DB897F", 1), // red
    new dimple.color("#C999CA", "#B189B1", 1) // purple
  ];
  chart.addMeasureAxis("p", "Total");
  var s = chart.addSeries('File Type', dimple.plot.pie);
  var myLegend = chart.addLegend("75%", "15%", "10%", "20%", "left");
  myLegend.fontSize = "1.5em";
  chart.draw();
  // s.style("stroke-width", 4);
  // s.shapes.each(function(d) {
  //   .style("fill", shape.style("stroke"))
  // })
  // svg.attr("style", "outline: solid black;")
}

var loadUsersByMonthData = function(){
                $.ajax({
                  type: 'GET',
                  contentType: 'application/json; charset=utf-8',
                  url: '/api/v1/accumulated_users_by_month',
                  dataType: 'json',
                  success: function(data){
                    drawUsersByMonthPlot(data);
                  },
                  failure: function(result){
                    error();
                  }
                });
              };
              
function drawUsersByMonthPlot(data) {
  var svg = dimple.newSvg('#accumulated_users_by_month', "100%", "100%");
  var chart = new dimple.chart(svg, data);
  chart.defaultColors = [
    new dimple.color("#4ca4ec", "#007ee5", 1), // blue
    new dimple.color("#FDC381", "#DDAC75", 1), // orange
    new dimple.color("#C2E587", "#ABC879", 1), // green
    new dimple.color("#A4DCD2", "#91C1B8", 1), // turquoise
    new dimple.color("#FC998E", "#DB897F", 1), // red
    new dimple.color("#C999CA", "#B189B1", 1) // purple
  ];
  chart.setBounds(60, 20, 800, 300);
  var x = chart.addCategoryAxis("x", "Month");
  x.fontSize = 12;
  x.title
  var y = chart.addMeasureAxis("y", "Total Number of Users");
  y.showGridlines = false;
  y.fontSize = 12;
  var s = chart.addSeries(null, dimple.plot.area);
  s.interpolation = "cardinal";
  var lines = chart.addSeries(null, dimple.plot.line);
  lines.lineWeight = 3;
  chart.draw();

 // svg.append('g')
 //   .attr('class', 'y axis')
 //   .attr('transform', 'translate(' + [margins.left, margins.top] + ')');
 //   .call(yAxis);
}

$('#binary_downloads_by_date_plot').append(loadBinaryDownloadsData())
$('#binary_downloads_public_v_private_plot').append(loadBinaryDownloadsPubPrivData())
$('#binaries_by_type_plot').append(loadBinariesByTypeData())
$('#accumulated_users_by_month').append(loadUsersByMonthData())
