$(document).ready(function () {
  $("#uploadfile").uploadFile({
    url:"/upload",
    allowedTypes:"xlsx,xls",
    fileName:"birthdayFile"
  });
});
