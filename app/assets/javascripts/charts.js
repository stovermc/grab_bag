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

  var svg = dimple.newSvg("body", 800, 600);
  var chart = new dimple.chart(svg, data);
  chart.addCategoryAxis("x", "date");
  chart.addMeasureAxis("y", "accumulated_downloads");
  chart.addSeries(null, dimple.plot.area);
  chart.draw();
}

$('#binary_downloads_plot').append(loadBinaryDownloadsData())
