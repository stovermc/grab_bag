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

  var svg = dimple.newSvg('#binary_downloads_by_date_plot', 1200, 600);
  var chart = new dimple.chart(svg, data);
  chart.addCategoryAxis("x", "Date");
  chart.addMeasureAxis("y", "Accumulated Downloads");
  chart.addSeries(null, dimple.plot.area);
  chart.draw();
  svg.append("text")
   .attr("x", 600)
   .attr("y", 30)
   .attr("text-anchor", 'middle')
   .style("font-size", "30px")
   .style("font-family", "sans-serif")
   .style("font-weight", "bold")
   .text("Accumulated Binary Downloads Per Day");
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
  chart.addMeasureAxis("p", "downloads");
  chart.addSeries('permission', dimple.plot.pie);
  chart.addLegend(450, 20, 90, 300, "left");
  chart.draw();
  svg.append("text")
   .attr("x", 295)
   .attr("y", 30)
   .attr("text-anchor", 'middle')
   .style("font-size", "30px")
   .style("font-family", "sans-serif")
   .style("font-weight", "bold")
   .text("Public vs Private Binary Downloads");
}

var loadBinariesByTypeData() = function(){
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
              
// function drawBinariesByTypePlot(data) {
// 
//   var svg = dimple.newSvg('#binaries_by_type_plot', "100%", "100%");
//   var chart = new dimple.chart(svg, data);
//   chart.addMeasureAxis("p", "total");
//   chart.addSeries('file_type', dimple.plot.pie);
//   chart.addLegend(450, 20, 90, 300, "left");
//   chart.draw();
//   svg.append("text")
//    .attr("x", 295)
//    .attr("y", 30)
//    .attr("text-anchor", 'middle')
//    .style("font-size", "30px")
//    .style("font-family", "sans-serif")
//    .style("font-weight", "bold")
//    .text("Binaries By File Type");
// }

$('#binary_downloads_by_date_plot').append(loadBinaryDownloadsData())
$('#binary_downloads_public_v_private_plot').append(loadBinaryDownloadsPubPrivData())
$('#binaries_by_type_plot').append(loadBinariesByTypeData())
