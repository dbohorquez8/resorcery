$(function (){
  function resetMasonry() {
    var chart = $('.js-workspace-chart');
    if (chart.data('masonry')) {
      chart.masonry('destroy');
    }
  }

  function insertHTML() {
    $('.js-workspace-chart').html("");

    _.forEach(Resorcery.workspace.children, function (child) {
      var resourceGroup = $(ich["js-resources-group-template"](child));

      _.forEach(child.children, function (resource) {
        return resourceGroup.append(ich["js-resource-template"](resource));
      });

      $('.js-workspace-chart').append(resourceGroup);
    });
  }

  function drawGroups() {
    var resourceSize = 50,
    margin = 5,
    radius;

      $('.js-workspace-chart-group').each(function (){
        var ringIndex = 1, maxResources = $(this).find('.js-workspace-chart-resource').length + 1;

        $(this).find('.js-workspace-chart-resource').each(function (index){
          var index = index + 1;
          var resource = $(this);
          var delta = maxResourcesPerRingIndex(ringIndex) > maxResources - 1 ? (maxResources - 1) - maxResourcesPerRingIndex(ringIndex - 1) : 6 * ringIndex;

          radius = (resourceSize + margin) * (ringIndex);
          var angle = 360 / delta;

          if(index == maxResourcesPerRingIndex(ringIndex)){
            ringIndex++;           
          }
        }


          var x = 0 - resourceSize / 2 - radius * Math.sin(angle * index * Math.PI / 180);
          var y = 0 - resourceSize / 2 - radius * Math.cos(angle * index * Math.PI / 180);
          resource.css('top', y)
          .css('left', x);
        });

        var size = 2 * radius + resourceSize;
        $(this).width(size);
        $(this).height(size);
        $(this).find('.js-workspace-chart-resource, .js-group-title').css('transform', 'translate('+ size / 2 +'px, '+ size / 2 +'px)');
    });

      var size = 2 * radius + resourceSize;
      $(this).width(size);
      $(this).height(size);
      $(this).find('.js-workspace-chart-resource').css('transform', 'translate('+ size / 2 +'px, '+ size / 2 +'px)');
    });

    $('.js-workspace-chart').masonry({
      itemSelector: '.js-workspace-chart-group',
      columnWidth: 70,
      gutter: 0
    });
  }

  Resorcery.render = function () {
    insertHTML();
    resetMasonry();
    drawGroups();
  }
});
