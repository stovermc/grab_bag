
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
    new dimple.color("#a48ae6", "#5c2cd2", 1), // purple
    new dimple.color("#f6db6f", "#f2c926", 1), // yellow
    new dimple.color("#C2E587", "#ABC879", 1), // green
    new dimple.color("#f6b959", "#f39c12", 1), // orange
    new dimple.color("#A4DCD2", "#91C1B8", 1), // turquoise
    new dimple.color("#FC998E", "#DB897F", 1) // red
  ];
  var x = chart.addCategoryAxis("x", "Month");
  x.fontSize = 12;
  var y = chart.addMeasureAxis("y", "Total Number of Users");
  y.showGridlines = false;
  y.fontSize = 12;
  var s = chart.addSeries(null, dimple.plot.area);
  s.interpolation = "cardinal";
  chart.draw(1500);
}

var loadLoginsByWeekdayData = function(){
                $.ajax({
                  type: 'GET',
                  contentType: 'application/json; charset=utf-8',
                  url: '/api/v1/log_ins_by_weekday',
                  dataType: 'json',
                  success: function(data){
                    drawLoginsByWeekdayPlot(data);
                  },
                  failure: function(result){
                    error();
                  }
                });
              };

function drawLoginsByWeekdayPlot(data) {
  var svg = dimple.newSvg('#log_ins_by_weekday', "100%", "100%");
  var chart = new dimple.chart(svg, data);
  chart.defaultColors = [
    new dimple.color("#a48ae6", "#5c2cd2", 1), // purple
    new dimple.color("#f6db6f", "#f2c926", 1), // yellow
    new dimple.color("#C2E587", "#ABC879", 1), // green
    new dimple.color("#f6b959", "#f39c12", 1), // orange
    new dimple.color("#4ca4ec", "#007ee5", 1), // blue
    new dimple.color("#A4DCD2", "#91C1B8", 1), // turquoise
    new dimple.color("#FC998E", "#DB897F", 1) // red
  ];
  var x = chart.addCategoryAxis("x", "Weekday");
  x.fontSize = 12;
  x.addOrderRule(["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"])
  var y = chart.addMeasureAxis("y", "Number of Logins");
  y.showGridlines = false;
  y.fontSize = 12;
  var s = chart.addSeries("Weekday", dimple.plot.bar);
  // var lines = chart.addSeries(null, dimple.plot.bar);
  // lines.lineWeight = 3;
  chart.draw(1500);
}

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
  var svg = dimple.newSvg('#binary_downloads_by_date_plot', "100%", "100%");
  var chart = new dimple.chart(svg, data);
  chart.defaultColors = [
    new dimple.color("#4ca4ec", "#007ee5", 1), // blue
    new dimple.color("#a48ae6", "#5c2cd2", 1), // purple
    new dimple.color("#f6db6f", "#f2c926", 1), // yellow
    new dimple.color("#C2E587", "#ABC879", 1), // green
    new dimple.color("#f6b959", "#f39c12", 1), // orange
    new dimple.color("#A4DCD2", "#91C1B8", 1), // turquoise
    new dimple.color("#FC998E", "#DB897F", 1) // red
  ];
  // chart.setBounds(60, 20, 770, 300);

  var x = chart.addTimeAxis("x", "Date", "%Y-%m-%d", "%b %Y");
  x.fontSize = 12;
  var y = chart.addMeasureAxis("y", "Number of Downloads", null, 'Date');
  y.showGridlines = false;
  y.fontSize = 12;
  // var lines = chart.addSeries(null, dimple.plot.line);
  // lines.lineWeight = 3;
  var s = chart.addSeries(null, dimple.plot.bubble);
  // s.interpolation = "cardinal";

  chart.draw(1500);
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
    new dimple.color("#f6b959", "#f39c12", 1), // orange
    new dimple.color("#a48ae6", "#5c2cd2", 1), // purple
    new dimple.color("#f6db6f", "#f2c926", 1), // yellow
    new dimple.color("#C2E587", "#ABC879", 1), // green
    new dimple.color("#A4DCD2", "#91C1B8", 1), // turquoise
    new dimple.color("#FC998E", "#DB897F", 1) // red
  ];
  chart.addMeasureAxis("p", "downloads");
  chart.addSeries('permission', dimple.plot.pie);
  myLegend = chart.addLegend("90%", "2%", "15%", "15%", "right");
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
    new dimple.color("#a48ae6", "#5c2cd2", 1), // purple
    new dimple.color("#f6db6f", "#f2c926", 1), // yellow
    new dimple.color("#C2E587", "#ABC879", 1), // green
    new dimple.color("#f6b959", "#f39c12", 1), // orange
    new dimple.color("#A4DCD2", "#91C1B8", 1), // turquoise
    new dimple.color("#FC998E", "#DB897F", 1) // red
  ];
  chart.addMeasureAxis("p", "Total");
  var s = chart.addSeries('File Type', dimple.plot.pie);
  var myLegend = chart.addLegend("78%", "15%", "10%", "100%", "left");
  myLegend.fontSize = "1.5em";
  chart.draw();
}

$('#accumulated_users_by_month').load(loadUsersByMonthData())

$('#users-tab').on('click', function() {
  $('#accumulated_users_by_month').empty()
  $('#accumulated_users_by_month').load(loadUsersByMonthData())
})
$('#logins-tab').on('click', function() {
  $('#log_ins_by_weekday').empty()
  $('#log_ins_by_weekday').load(loadLoginsByWeekdayData())
})
$('#file_downloads-tab').on('click', function() {
  $('#binary_downloads_public_v_private_plot').empty()
  $('#binary_downloads_by_date_plot').empty()
  $('#binary_downloads_public_v_private_plot').load(loadBinaryDownloadsPubPrivData())
  $('#binary_downloads_by_date_plot').load(loadBinaryDownloadsData())
})
$('#files-tab').on('click', function() {
  $('#binaries_by_type_plot').empty()
  $('#binaries_by_type_plot').load(loadBinariesByTypeData())
})
