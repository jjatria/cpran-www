function LastModified() {
	var date = document.lastModified;
	patn = /\d{2}\/\d{2}\/\d{4}/;
	date = patn.exec(date);

	return date;
}
var last = LastModified();
if (last != null) {
    document.write( "Last modified on " +  last );
} else {
    document.write( "Unable to detect last modification.");
}