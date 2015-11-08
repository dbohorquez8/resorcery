$(function(){
  Resorcery.parser = function (data) {
    var parsed_data = {}, workspace = data.response;

    parsed_data.allocations = [];
    parsed_data.name = workspace.name;
    parsed_data.bg_color = workspace.metadata.background_color;

    parsed_data.children = _.map(workspace.resource_groups, function(resource_group){
      var child = {};
      child.name = resource_group.name;
      child.bg_color = "#" + resource_group.metadata.background_color;
      child.size = 1;
      child.id = resource_group.id;

      var allocations = _.filter(workspace.allocations, {
        resource_group_id: resource_group.id
      });

      child.children = _.map(allocations, function(alloca){
        var resource = _.filter(workspace.resources, {id: alloca.resource_id})[0];
        var allocation = {
          name: resource.name,
          resourceGroupName: resource_group.name,
          size: 1,
          color: "#" + resource.metadata.background_color,
          startDate: alloca.start_date,
          endDate: alloca.end_date,
          resourceId: alloca.resource_id,
          resourceGroupId: alloca.resource_group_id,
          allocationId: alloca.id
        };

        parsed_data.allocations[allocation.allocationId] = allocation;
        return allocation;
      });

      return child;
    });

    return parsed_data;
  };
});
