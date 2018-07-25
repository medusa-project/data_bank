// work-around turbo links to trigger ready function stuff on every page.

var datasets_ready;
var thefile = null;
var reader = null;
var firstProgress = true;

datasets_ready = function () {

    $.ajaxSetup({
        headers: {
            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        }
    });

    initFileUpload();

}

function initFileUpload() {
    var bHaveFileAPI = (window.File && window.FileReader);

    if (!bHaveFileAPI) {
        $(".fileselect").html("<p class='notice'>This browser does not support the HTML 5 File API required to upload files. Current versions of Chrome do, as do most modern browsers.</p>")
        return;
    }

    console.log("inside initFileUpload");

    $("#selectedFiles").on("change", onFileChanged);
}

function onFileChanged(theEvt) {
    var files = theEvt.target.files;

    console.log("inside onFileChanged");

    $('#divFiles').html('');
    for (var i = 0; i < files.length; i++) { //Progress bar and status label's for each file genarate dynamically
        var fileId = i;
        $("#divFiles").append('<div class="col-md-12">' +
            '<div class="progress-bar progress-bar-striped active" id="progressbar_' + fileId + '" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="width:0%"></div>' +
            '</div>' +
            '<div class="col-md-12">' +
            '<div class="col-md-6">' +
            '<input type="button" class="btn btn-danger" style="display:none;line-height:6px;height:25px" id="cancel_' + fileId + '" value="cancel">' +
            '</div>' +
            '<div class="col-md-6">' +
            '<p class="progress-status" style="text-align: right;margin-right:-15px;font-weight:bold;color:saddlebrown" id="status_' + fileId + '"></p>' +
            '</div>' +
            '</div>' +
            '<div class="col-md-12">' +
            '<p id="notify_' + fileId + '" style="text-align: right;"></p>' +
            '</div>');
    }

    for (var i = 0; i < files.length; i++) {
        uploadSingleFile(files[i], i);
    }

}

function uploadSingleFile(file, i) {

    console.log("inside uploadSingleFile");

    var fileId = i;
    var ajax = new XMLHttpRequest();
    //Progress Listener
    ajax.upload.addEventListener("progress", function (e) {
        var percent = (e.loaded / e.total) * 100;
        $("#status_" + fileId).text(Math.round(percent) + "% uploaded, please wait...");
        $('#progressbar_' + fileId).css("width", percent + "%")
        $("#notify_" + fileId).text("Uploaded " + (e.loaded / 1048576).toFixed(2) + " MB of " + (e.total / 1048576).toFixed(2) + " MB ");
    }, false);
    //Load Listener
    ajax.addEventListener("load", function (e) {

        console.log(event.target.responseText);

        $("#status_" + fileId).text("placeholder");

        // $("#status_" + fileId).text(event.target.responseText);
        $('#progressbar_' + fileId).css("width", "100%")

        //Hide cancel button
        var _cancel = $('#cancel_' + fileId);
        _cancel.hide();
    }, false);
    //Error Listener
    ajax.addEventListener("error", function (e) {
        $("#status_" + fileId).text("Upload Failed");
    }, false);
    //Abort Listener
    ajax.addEventListener("abort", function (e) {
        $("#status_" + fileId).text("Upload Aborted");
    }, false);

    ajax.open("POST", "/datafiles");

    var uploaderForm = new FormData();

    uploaderForm.append('datafile[dataset_id]', dataset_id);
    uploaderForm.append('datafile[upload]', file);

    var csrfToken = $('meta[name="csrf-token"]').attr('content');

    ajax.setRequestHeader('X-CSRF-Token', csrfToken);
    ajax.setRequestHeader('Accept', 'application/json');

    ajax.send(uploaderForm);

    //Cancel button
    var _cancel = $('#cancel_' + fileId);
    _cancel.show();

    _cancel.on('click', function () {
        ajax.abort();
    })
}

$(document).ready(datasets_ready);
$(document).on('page:load', datasets_ready);