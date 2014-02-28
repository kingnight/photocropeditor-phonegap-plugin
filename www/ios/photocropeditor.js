
var exec = require("cordova/exec");
var PhotoCropEditor = function() {};    

PhotoCropEditor.prototype.takePicture = function(success,fail,width,height) {

    if(parseInt(width)==0 || parseInt(height)==0 || isNaN(width) || isNaN(height))
    {
        width=320;
        height=320;
    }
    exec(success,fail, 'PhotoCropEditor', 'takePicture', [width,height]);
};

module.exports =new PhotoCropEditor();

