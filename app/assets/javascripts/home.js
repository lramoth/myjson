var home = {
    init: function() {
        $("#home textarea.data").linedtextarea();
        $("#home #uri").click(function() {
            this.select();
        });
    }
}

$(document).ready(function() {
    home.init();
});
