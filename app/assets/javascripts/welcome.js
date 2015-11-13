function socialLoginLoad() {
  if (typeof(window.socialid) !== "object") window.socialid = {};
  socialid.onLoad = function() {
    socialid.login.init(303, {
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
        url: 'users/login',
        data: data,
        cache: false,
        success: function(data) {
          window.location = "/profile";
        },
        error: function(e) {
          alert("ERROR (" + e.status + " - " + e.statusText + "): " + e.responseText);
        }
      });
    });
    document.getElementById("signupbutton").onclick = function() {
      socialid.login.logout();
      window.location = '/signup';
    };
  };
}

function socialEmailLogin() {
  var passphrase = document.getElementById("passphrase").value
  var email = document.getElementById("email").value

  $.ajax({
    type: "POST",
    url: 'users/login',
    data: {
      email: email,
      password: passphrase
    },
    cache: false,
    success: function(data) {
      window.location = "/profile";
    },
    error: function(e) {
      alert("ERROR (" + e.status + " - " + e.statusText + "): " + e.responseText);
    }
  });
}