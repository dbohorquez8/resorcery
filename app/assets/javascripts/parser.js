// $(function(){
//   Resorcery.parser = function (data) {
//     var parsed_data = {}, workspace = data.response;

//     parsed_data.name = "";//workspace.name;
//     parsed_data.bg_color = workspace.metadata.background_color;

//     parsed_data.children = _.map(workspace.resource_groups, function (resource_group) {
//       return {
//         name: resource_group.name,
//         bg_color: "#" + resource_group.metadata.background_color,

//         children: _.map(workspace.allocations, function (allocation) {
//           var resource = _.find(workspace.resources, function (resource) {
//             return resource.id == allocation.resource_id;
//           });

//           return {
//             name: resource.name,
//             color: "#" + resource.metadata.background_color,
//             size: 1
//           }
//         })
//       }
//     });


//     console.log(parsed_data);
//     return parsed_data;
//   };
// });

$(function(){
  Resorcery.parser = function (data) {
    var parsed_data = {}, workspace = data.response;

    parsed_data.name = "";//workspace.name;
    parsed_data.bg_color = workspace.metadata.background_color;

    parsed_data.children = _.map(workspace.resource_groups, function(resource_group){
      var child = {};
      child.name = resource_group.name;
      child.bg_color = resource_group.metadata.background_color;
      child.size = 1;

      var allocations = _.filter(workspace.allocations, {resource_group_id: resource_group.id});

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



    console.log(parsed_data);
    return parsed_data;
  };
});



// _.map(workspace.resource_groups, function(n){
//   var child = {};
//   child.name = n.name;
//   child.bg_color = n.metadata.background_color;

//   var allocations = _.filter(workspace.allocations, {resource_group_id: n.id});

//   child.children = _.map(allocations, function(alloca){
//     return {
//       name: "algo",
//       size: 1,
//       color: "#000"
//     }
//   });

//   return child;
// });

