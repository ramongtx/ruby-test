function socialSignup() {
  var username = document.getElementById("username").value
  var passphrase = document.getElementById("passphrase").value
  var email = document.getElementById("email").value
  $.ajax({
    type: "POST",
    url: '/signup',
    data: {
      username: username,
      password: passphrase,
      email_address: email
    },
    cache: false,
    success: function(data) {
      if (data == "ok") {
        window.location = "/";
      } else {
        alert(data)
      }
    },
    error: function(e) {
      alert("ERROR (" + e.status + " - " + e.statusText + "): " + e.responseText);
    }
  });
}
