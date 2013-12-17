jQuery(
  function() {
    if (window.mozCipher) {
      $('.insecure-passphrase-placeholder').each(function(offset, placeholder) {
        var id = $(placeholder).attr('data-id');
        var name = $(placeholder).attr('data-name');
        $(placeholder).html(
          "<label for='" + id + "'>Passphrase</label> <input type='password' id='" + id + "' name='" + name + "' class='insecure-passphrase-field'>"
        );
        $(placeholder).parent().parent().on('submit', function() {
          window.mozCipher.hash.SHA256(
            $('#' + id).val(), function(sha){ $('#' + id).val(sha) }
          );
        });
      });
    }
  }
);
