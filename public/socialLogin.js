function socialLoginLoad() {
  if (typeof(window.socialid) !== "object") window.socialid = {};
  socialid.onLoad = function() {
    socialid.login.init(301, {
      loginType: "event"
    });
    socialid.login.renderLoginWidget("login­c6ab6f67", {
      "providers": ["facebook", "gplus", "twitter", "linkedin"],
      "theme": "bricks",
      "showSocialIdLink": true
    });
    socialid.events.onLoginSuccess.addHandler(function(data) {
      $.ajax({
        type: "POST",
        url: '/login',
        data: data,
        cache: false,
        success: function(data) {
          if (data == "ok") {
            window.location = "/profile";
          } else {
            alert(data)
          }
        },
        error: function(e) {
          alert("ERROR (" + e.status + " - " + e.statusText + "): " + e.responseText);
        }
      });
    });
    document.getElementById("signupbutton").onclick = function () {
      socialid.login.logout();
      window.location = '/signup';
    };
  };
}
