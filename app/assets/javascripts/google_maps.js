google.charts.load('current', {
  'packages':['geochart'],
  // Note: you will need to get a mapsApiKey for your project.
  // See: https://developers.google.com/chart/interactive/docs/basic_load_libs#load-settings
  'mapsApiKey': 'AIzaSyBGpTNEZljilRtSfoZzlqWJEPS3yNM-XYw'
});
google.charts.setOnLoadCallback(drawRegionsMap);

function drawRegionsMap() {
  var data = google.visualization.arrayToDataTable(chart_data);
    [
    ['Country', 'Popularity'],
    ['Germany', 200],
    ['United States', 300],
    ['Brazil', 400],
    ['Canada', 500],
    ['France', 600],
    ['RU', 700]
  ]

  var options = {
    region: '002', // Africa
    colorAxis: {colors: ['#00853f', 'black', '#e31b23']},
    backgroundColor: '#81d4fa',
    datalessRegionColor: '#f8bbd0',
    defaultColor: '#f5f5f5',
  };

  var chart = new google.visualization.GeoChart(document.getElementById('regions_div'));

  chart.draw(data, options);
}
