var ext = $('#myfile').val().split('.').pop().toLowerCase();
if($.inArray(ext, ['xls']) == -1) {
    alert('invalid extension!');
}