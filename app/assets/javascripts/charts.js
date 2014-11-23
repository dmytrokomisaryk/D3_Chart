StatisticChart = {
  draw: function (data) {
    var self = this;
    var margin = {top: 20, right: 60, bottom: 60, left: 40},
    width = 1100 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;

    var x = d3.scale.ordinal()
        .rangeRoundBands([0, width], .1);

    var y = d3.scale.linear()
        .rangeRound([height, 0]);

    var color = d3.scale.ordinal()
        .range(['#1FCE6F', '#FF5862', '#E84033']);

    var xAxis = d3.svg.axis()
        .scale(x)
        .orient('bottom')
        .ticks(5);

    var yAxis = d3.svg.axis()
        .scale(y)
        .orient('left')
        .tickFormat(d3.format('.2s'));

    var chart = d3.select('#statistic-chart')
        .append('svg')
        .attr('class', '.tests-chart')
        .attr('width', width + margin.left + margin.right)
        .attr('height', height + margin.top + margin.bottom)
        .append('g')
        .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');
      

    color.domain(d3.keys(data[0]).filter(function(key) {
    return _.contains(['passed_tests_count', 'failed_tests_count', 'error_tests_count'], key);
    }));
      
    data.forEach(function(d) {
        var y0 = 0;
        d.columnsNames = color.domain().map(function(name) { return {name: name, y0: y0, y1: y0 += +d[name]}; });
        d.total = d.columnsNames[d.columnsNames.length - 1].y1;
    });
      
    x.domain(data.map(function(d) { return self.formatDate(d.created_at); }));
    y.domain([0, d3.max(data, function(d) { return d.total; })]);

    chart.append('g')
        .attr('class', 'x axis')
        .attr('transform', 'translate(0,' + height + ')')
        .call(xAxis)
        .selectAll('text').style('text-anchor', 'end')
        .attr('transform', function(d) {
            return 'rotate(-25)'
        });

    chart.append('g')
        .attr('class', 'y axis')
        .call(yAxis)
        .append('text')
        .attr('y', -9)
        .attr('x', 23)
        .attr('dy', '.71em')
        .style('text-anchor', 'end')
        .text('Tests count');

    var state = chart.selectAll('.state')
        .data(data)
        .enter().append('g')
            .attr('class', 'g')
            .attr('transform', function(d) { return 'translate(' + x(self.formatDate(d.created_at)) + ',0)'; });
      
    state.selectAll('rect')
    .data(function(d) { return d.columnsNames; })
    .enter().append('rect')
        .attr('width', x.rangeBand())
        .attr('y', function(d) { return y(d.y1); })
        .attr('height', function(d) { return y(d.y0) - y(d.y1); })
        .style('fill', function(d) { return color(d.name); });

    var legend = chart.selectAll('.legend')
        .data(color.domain().slice().reverse())
        .enter().append('g')
        .attr('class', 'legend')
        .attr('transform', function(d, i) { return 'translate(0,' + i * 20 + ')'; });
    legend.append('rect')
        .attr('x', width + 45)
        .attr('width', 18)
        .attr('height', 18)
        .style('fill', color);
    legend.append('text')
        .attr('x', width + 40)
        .attr('y', 9)
        .attr('dy', '.35em')
        .style('text-anchor', 'end')
        .style('text-transform', 'capitalize')
        .text(function(d) { return self.lable(d); });
  },
    
  formatDate: function(date) {
      var date = new Date(date);

      var formatedDate = moment(date).format('MMM, Do, hA');
      return formatedDate;
  },

  lable: function (data) {
      return data.split("_").shift();
  }
};