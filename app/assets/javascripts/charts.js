StatisticChart = {
  draw: function (data) {
      var statistic = data;
      var colors = d3.scale.ordinal()
          .range(['#1FCE6F', '#FF5862', '#BE0404','#000000']);
      var keyColor = function(d, i) {return colors(d.key)};
      var chart;
      var self = this;

      nv.addGraph(function() {
          chart = nv.models.stackedAreaChart()
              .useInteractiveGuideline(true)
              .x(function(d) { return d[0] })
              .y(function(d) { return d[1] })
              .color(keyColor)
              .transitionDuration(300);

          chart.stacked.scatter.clipVoronoi(false);

          chart.xAxis
              .tickFormat(function(d) { return d3.time.format('%x')(new Date(d)) });

          chart.yAxis
              .tickFormat(d3.format("d"));

          d3.select('#statistic-chart')
              .datum(statistic)
              .transition().duration(1000)
              .call(chart)
              .transition().duration(0);

          self.hideLegend('nv-controlsWrap');

          nv.utils.windowResize(chart.update);

          return chart;
      });
  },

  hideLegend: function (legendName) {
      d3.select('.' + legendName)
          .selectAll('.nv-series')
          .style('visibility',  'hidden');
  }
};