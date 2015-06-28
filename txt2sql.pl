#!/usr/bin/env perl -n
$|++;

sub cleanit {
    ($x) = @_; 
    $x =~ s/^\s+|\s+$//g;
    if ($x) {
	return "'$x'";	
    }
    else {
	return "NULL";
    }

}

sub checkit {
    my $x = int($_); 
    if ($x) {
	return $x;
    } 
    else {
	return "NULL";
    }} 

sub fixit {
    return join(",",map checkit, @_);
} 

while (<>) {
    $_ =~ s/,//g;
    $_ =~ s/'/''/g;    
    $_=~m/(.{1})(.{9})(.{20})(.{4})(.{15})(.{15})(.{1})(.{2})(.{2})(.{4})(.{2})(.{2})(.{4})(.{2})(.{2})(.+)/;
    print ",\n" if ($i);
    printf "INSERT INTO deaths VALUES (NULL,%s,%s,%s,%s,%s,%s,%s);\n", 
	$2*1,
	cleanit($3),
	cleanit($4),
	cleanit($5),
	cleanit($6),
	cleanit($7),
	fixit($8,$9,$10,$11,$12,$13);	
}


