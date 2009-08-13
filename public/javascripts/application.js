  function EncMail(base,host) {
    return ('<a href=\"mailto:' + 
      base + '@' + host + '\">' + 
      base + ' @ ' + host + '</a>');
  }