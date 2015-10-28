function assignIcons() {
  var links = document.querySelectorAll("a.icon");
  for (var i=0; i<links.length; i++) {
    var parent = links[i].parentNode;

    var extension = links[i].getAttribute('href').match(/.*\.(\w+)$/);
    extension = extension[extension.length-1];

//     var nobreak = document.createElement('span');
//     nobreak.className = "no-break";

    var fa = document.createElement('span');

    if (extension === "pdf") {
      fa.className = "fa fa-file-pdf-o";
    }
    else if (extension === "zip") {
      fa.className = "fa fa-file-zip-o";
    }
    else if (extension.match("(mp3|ogg|wav)")) {
      fa.className = "fa fa-file-sound-o";
    }
//     parent.appendChild(nobreak);
    parent.appendChild(fa);
    parent.appendChild(links[i]);
  }
}
assignIcons();
