$(function (){
  Resorcery.render = function () {
    var resourceSize = 50,
        margin = 10,
        radius;

    function maxResourcesPerRingIndex(ringIndex) {
      return 3 * ringIndex * (ringIndex + 1);
    }

    $('.js-workspace-chart-group').each(function (){
      var ringIndex = 1, maxResources = $(this).find('.resource').length;
        
      $(this).find('.js-workspace-chart-resource').each(function (index){
        var resource = $(this);
        var delta = maxResourcesPerRingIndex(ringIndex) > maxResources - 1 ? (maxResources - 1) - maxResourcesPerRingIndex(ringIndex - 1) : 6 * ringIndex;
        
        if(index == 0){
          resource.css('top', 0 - resourceSize / 2)
            .css('left', 0 - resourceSize / 2);
          radius = (resourceSize) / 2;
        }else{
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
        $(this).find('.js-workspace-chart-resource').css('transform', 'translate('+ size / 2 +'px, '+ size / 2 +'px)');
    });

    $('.js-workspace-chart').masonry({
      itemSelector: '.js-workspace-chart-group',
      columnWidth: 70,
      gutter: 0
    });
});
