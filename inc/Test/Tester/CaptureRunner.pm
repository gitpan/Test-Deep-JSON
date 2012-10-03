#line 1
# $Header: /home/fergal/my/cvs/Test-Tester/lib/Test/Tester/CaptureRunner.pm,v 1.3 2003/03/05 01:07:55 fergal Exp $
use strict;

package Test::Tester::CaptureRunner;

use Test::Tester::Capture;
require Exporter;

sub new
{
	my $pkg = shift;
	my $self = bless {}, $pkg;
	return $self;
}

sub run_tests
{
	my $self = shift;

	my $test = shift;

	capture()->reset;

	$self->{StartLevel} = $Test::Builder::Level;
	&$test();
}

sub get_results
{
	my $self = shift;
	my @results = capture()->details;

	my $start = $self->{StartLevel};
	foreach my $res (@results)
	{
		next if defined $res->{depth};
		my $depth = $res->{_depth} - $res->{_level} - $start - 3;
#		print "my $depth = $res->{_depth} - $res->{_level} - $start - 1\n";
		$res->{depth} = $depth;
	}

	return @results;
}

sub get_premature
{
	return capture()->premature;
}

sub capture
{
	return Test::Tester::Capture->new;
}

__END__

#line 76
