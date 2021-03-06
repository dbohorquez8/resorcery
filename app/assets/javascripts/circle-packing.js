$(function (){
  Resorcery.render = function () {
    var margin = 20,
      diameter = $(".js-workspace-chart").height();
      width = $(".js-workspace-chart").width();

    var color = d3.scale.linear()
        .domain([-1, 5])
        .range(["hsl(152,80%,80%)", "hsl(228,30%,40%)"])
        .interpolate(d3.interpolateHcl);

    var pack = d3.layout.pack()
        .padding(15)
        .size([diameter - margin, diameter - margin])
        .value(function(d) { return d.size; })

    var svg = d3.select(".js-workspace-chart").append("svg")
        .attr("class", "circle-packing")
        .attr("width", width)
        .attr("height", diameter)
      .append("g")
        .attr("transform", "translate(" + width / 2 + "," + diameter / 2 + ")");

    d3.json(Resorcery.routes.workspacePath.replace(/:wid/, Resorcery.workspace_id), function(error, workspaceJSON) {
      var root = Resorcery.parser(workspaceJSON);
      if (error) throw error;

      var focus = root,
          nodes = pack.nodes(root),
          view;

      var circle = svg.selectAll("circle")
          .data(nodes)
        .enter().append("circle")
          .attr("class", function(d) { return d.parent ? d.children ? "circle-packing__node" : "circle-packing__node circle-packing__node--leaf" : "circle-packing__node circle-packing__node--root"; })
          .attr("style", function(d){
            // var stroke =  d.color ? "stroke:" + d.color : '';
            var stroke =  d.color ? "stroke:" + d.color : '';
            if(d.parent && d.children){
              stroke = "stroke: " + d.bg_color ;
              var background_color = "fill: " + d.bg_color;
              return stroke + "; " + background_color;
            }
            return stroke ;
          })
          .on("click", function(d) { if (focus !== d) zoom(d), d3.event.stopPropagation(); });

      var text = svg.selectAll("text")
          .data(nodes)
        .enter().append("text")
          .attr("class", "circle-packing__label")
          .text(function(d) { return d.name; });

      var node = svg.selectAll("circle,text");

      d3.select(".js-workspace-chart")
        .on("click", function() { zoom(root); });

      zoomTo([root.x, root.y, root.r * 2 + margin]);

      function zoom(d) {
        var focus0 = focus; focus = d;

        var transition = d3.transition()
            .duration(d3.event.altKey ? 7500 : 750)
            .tween("zoom", function(d) {
              var i = d3.interpolateZoom(view, [focus.x, focus.y, focus.r * 2 + margin]);
              return function(t) { zoomTo(i(t)); };
            });

        transition.selectAll("text")
          .filter(function(d) { return d.parent === focus || this.style.display === "inline"; })
            .style("fill-opacity", function(d) { return d.parent === focus ? 1 : 0; })
            .each("start", function(d) { if (d.parent === focus) this.style.display = "inline"; })
            .each("end", function(d) { if (d.parent !== focus) this.style.display = "none"; });
      }

      function zoomTo(v) {
        var k = diameter / v[2]; view = v;
        node.attr("transform", function(d) { return "translate(" + (d.x - v[0]) * k + "," + (d.y - v[1]) * k + ")"; });
        circle.attr("r", function(d) { return d.r * k; });
      }
    });

    d3.select(self.frameElement).style("height", diameter + "px");
  }
});
