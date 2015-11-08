$(function(){
  Resorcery.parser = function (data) {
    var parsed_data = {}, workspace = data.response;

    parsed_data.name = workspace.name;
    parsed_data.bg_color = workspace.metadata.background_color;

    parsed_data.children = _.map(workspace.resource_groups, function(resource_group){
      var child = {};
      child.name = resource_group.name;
      child.bg_color = resource_group.metadata.background_color;
      child.size = 1;

      var allocations = _.filter(workspace.allocations, {
        resource_group_id: resource_group.id
      });

      child.name = resource_group.name + " " + allocations.length;

      child.children = _.map(allocations, function(alloca){
        var resource = _.filter(workspace.resources, {id: alloca.resource_id})[0];
        return {
          name: resource.name,
          size: 1,
          color: "#" + resource.metadata.background_color
        }
      });

      return child;
    });

    return parsed_data;
  };
});
