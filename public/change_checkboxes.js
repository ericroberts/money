function checkTableCheckboxes(input, checked) {
  input
    .closest("table")
    .querySelectorAll("tbody input[type='checkbox']")
    .forEach(function(input) {
      input.checked = checked;
    });
}

document.addEventListener("DOMContentLoaded", function() {
  document
    .querySelectorAll("thead input[type='checkbox']")
    .forEach(function(input) {
      input.addEventListener("change", function() {
        checkTableCheckboxes(this, this.checked);
      });
    });
});
