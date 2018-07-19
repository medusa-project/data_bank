// work-around turbo links to trigger ready function stuff on every page.

var datasets_ready;
datasets_ready = function () {

    init();
    console.log("Inside datasets_ready");
}

function init() {
    var bHaveFileAPI = (window.File && window.FileReader);

    if (!bHaveFileAPI) {
        $(".fileselect").html("<p class='notice'>This browser does not support the HTML 5 File API, needed to upload files. Current versions of Chrome do, as do most modern browsers.</p>")
        return;
    }
    document.getElementById("selectedFiles").addEventListener("change", onFileChanged);
}

function onFileChanged(theEvt) {
    var files = theEvt.target.files;
    var totalBytes = 0;

    for (var i = 0; i < files.length; i++) {
        var fileInfo = "<p>File name: " + files[i].name + "; size: " + files[i].size + "; type: " + files[i].type + "</p>";
        totalBytes += files[i].size;
        document.getElementById('filedata').innerHTML += fileInfo;
    }
    document.getElementById('filedata').innerHTML += "<p>Total of " + files.length + " files, " + totalBytes + " bytes.";
}

$(document).ready(datasets_ready);
$(document).on('page:load', datasets_ready);