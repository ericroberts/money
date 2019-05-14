document.addEventListener("DOMContentLoaded", function() {
  document
    .querySelectorAll(".category-picker")
    .forEach(function(picker) {
      var select = picker.querySelector("select");
      var input = picker.querySelector("input");
      select.addEventListener("change", function() {
        if (this.value == "custom") {
          select.style.display = "none";
          input.style.display = "block";
          input.focus();
        }
      });
    });
});
