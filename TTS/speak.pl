#!/usr/bin/perl

use List::Util qw(max);
use List::Util qw(min);
use strict;

# *** update these variables with your own info ***
my $USERNAME = "kmh2151";
my $TOPIC    = "color";

# arguments 
my $input = shift;    # input string
my $wav_file = shift; # absolute path and name of the output wav file
my $BASEDIR = shift;

# checks the parameters, printing an error message if anything is wrong.
if (!$input || !$wav_file) {
	die  "This script converts an input string into a wav file"

		."Usage: color.pl INPUT WAVFILE \n"
		."Where: \n"
		." INPUT:   a string \n"
		." WAVFILE: spoken language of that string\n";
}


# full path to the TTS: partc
# (update if necessary)
#my $BASEDIR = "TTS";


# creates a Festival script
my $filename = "/tmp/temp_".time().".scm";
open OUTPUT, ">$filename" or die "Can't open '$filename' for writing.\n";

print OUTPUT '(load "'.$BASEDIR.'/festvox/SLP_'.$TOPIC.'_xyz_ldom.scm")' . "\n";
print OUTPUT '(voice_SLP_'.$TOPIC.'_xyz_ldom)' . "\n";
print OUTPUT '(Parameter.set \'Audio_Method \'Audio_Command)' . "\n";
print OUTPUT '(Parameter.set \'Audio_Required_Rate 16000)' . "\n";
print OUTPUT '(Parameter.set \'Audio_Required_Format \'wav)' . "\n";
print OUTPUT '(Parameter.set \'Audio_Command "cp $FILE '.$wav_file.'")' . "\n";
print OUTPUT '(SayText "'. $input .'")' . "\n";

close OUTPUT;


# tells Festival to execute the script we just created
system "cd $BASEDIR; festival --batch $filename";


# deletes the temporary script
unlink $filename;

