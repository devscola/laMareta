$(document).ready(function () {
  $("#singleupload2").uploadFile({
    url:"/upload",
    allowedTypes:"xlsx,xls",
    fileName:"myfile"
  });
});
