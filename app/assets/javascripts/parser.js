$(function(){
  Resorcery.parser = function (data) {
    var parsed_data = {}, workspace = data.response;

    parsed_data.name = "";//workspace.name;
    parsed_data.bg_color = workspace.metadata.background_color;
    parsed_data.children = _.map(workspace.resource_groups, function (resource_group) {
      return {
        name: resource_group.name,
        bg_color: "#" + resource_group.metadata.background_color,

        children: _.map(workspace.allocations, function (allocation) {
          var resource = _.find(workspace.resources, function (resource) {
            return resource.id == allocation.resource_id;
          });

          return {
            name: resource.name,
            color: "#" + resource.metadata.background_color,
            size: 1
          }
        })
      }
    });


    console.log(parsed_data);
    return parsed_data;
  };
});
