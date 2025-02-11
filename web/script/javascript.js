document.addEventListener("DOMContentLoaded", function() {
    window.onscroll = function() {
        var navbar = document.getElementsByTagName("nav")[0];
        if (document.body.scrollTop > 50 || document.documentElement.scrollTop > 50) {
            navbar.classList.add("scrolled");
        } else {
            navbar.classList.remove("scrolled");
        }
    };
});

