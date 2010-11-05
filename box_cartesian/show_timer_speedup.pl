#!/usr/bin/perl
#
# Read *two* GETM output files and copare getm_timer readings.
# Compute speedup from one to the other.
#

my $numArgs = $#ARGV + 1;

if ($numArgs != 2){
    print "Must have exactly 2 arguments. Got ",$numArgs,".\n";
    exit 2;
}

my $infilenam0 = $ARGV[0];
my $infilenam1 = $ARGV[1];

my %timings0 = ();
my %timings1 = ();


print "Open $infilenam0 and $infilenam1 for read\n";

unless(open(IN0,'<',$infilenam0)){
    print "Unable to open $infilenam0: $!\n";
    exit 3;
}
unless(open(IN1,'<',$infilenam1)){
    print "Unable to open $infilenam1: $!\n";
    exit 3;
}

# Parse each file in turn:
for my $innum (0,1){
    my $INFILE=undef;
    $INFILE=IN0 if $innum==0;
    $INFILE=IN1 if $innum==1;
    my %timings = {};
    my $parse_now = 0;
    while(<$INFILE>){
	chomp;
	my $thisline=$_;
	# Skip to interseting part - look for "Timername"
	if ($parse_now==0 && $thisline =~ m/^\s*Timername/){
	    #print " GOT TO TIMERNAME: $_\n";
	    $parse_now=1;
	    next;
	}
	# Look for line - to stop parsing timers.
	if($parse_now && $thisline =~ m/^\s*-----+\s*$/){
	    $parse_now=0;
	    last;
	}
	# Actually parse - if that is what we should do:
	if($parse_now){
	    # Keep *initial* spacing:
	    if ($thisline=~m/\s*(.*\S)\s+(\d+\.\d+)\s+(\d+)\s+(\d+\.\d+)\s*$/){
		#print "TESTA $thisline\n";
		#print "TESTB $1 $2 $3 $4\n";
		my $timername = $1;
		my $timerclock= $2;
		#print "Found $timername : $timerclock .... $3 x $4\n";
		$timername =~ s/\s/_/g; # Replace spaces with underscores
		$timings0{$timername}=$timerclock if $innum==0;
		$timings1{$timername}=$timerclock if $innum==1;
	    }
	    else{
		print "Unrecognized line:\n$thisline\nFailed to parse\n";
		exit 4;
	    }
	}
    }
}

# Now start to compare data.
# Sort after timer0 importance:
#        gotm                     33.20   33.41      0.99
print " Timername                tim0[s] tim1[s]  Speed-up\n";
foreach my $tname (sort { $timings0{$b} <=> $timings0{$a} } keys %timings0){
    $tim0 = $timings0{$tname};
    $tim1 = $timings1{$tname};
    if ($tim0==0 || $tim1==0){
	printf("  %-20s   %7.2f %7.2f       ---\n",$tname,$tim0,$tim1);
    }
    else{
	printf("  %-20s   %7.2f %7.2f   %7.2f\n",$tname,$tim0,$tim1,$tim0/$tim1);
    }
}
