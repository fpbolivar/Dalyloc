 $(function () {
        jQuery.validator.addMethod("validate_email", function (value, element) {

            if (/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(value)) {
                return true;
            } else {
                return false;
            }
        }, "Please enter a valid Email");

        jQuery.validator.addMethod("lettersonly", function(value, element) {
            return this.optional(element) || /^[a-z\s]+$/i.test(value.trim());
        }, "The field must be alphabetical characters");  

         jQuery.validator.addMethod("alpha", function(value, element) {
            return this.optional(element) || /^[a-zA-Z]+$/.test(value);
        }, "The field must be alphabetical characters");      

        jQuery.validator.addMethod("alphanumeric", function(value, element) {
            return this.optional(element) || /^[\w.]+$/i.test(value);
        }, "The field must be alphanumeric characters");   

});