$("select").chosen({search_contains: true, display_disabled_options: false})

$(".projects-select").each(function(){
  var $this = $(this);
  var $taskSelect = $('[data-task-id=' + $this.data('task-target') + ']');
  var persistedId = $this.val();


  var enableTasks = function(projectId) {
    $taskSelect.children().each(function(){
      var $child = $(this);
      $child.attr("disabled", $child.data("projectId") != projectId);
    })
  }

  enableTasks(persistedId)
  $taskSelect.trigger("chosen:updated");

  $this.change(function(){
    var projectId = $this.val();
    enableTasks(projectId)

    $taskSelect.children().not(':disabled').first().attr("selected", true)

    $taskSelect.trigger("chosen:updated");
  })
})
