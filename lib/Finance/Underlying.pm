package Finance::Underlying;
# ABSTRACT: Represents an underlying financial asset
use strict;
use warnings;

our $VERSION = '0.001';

=head1 NAME

Finance::Underlying - Object representation of a financial asset

=head1 SYNOPSIS

    use Finance::Underlying;

    my $fa        = Finance::Underlying->instance;
    my $sym_props = $fa->get_parameters_for('frxEURUSD');
    print $sym_props->{pip_size}, "\n";

=head1 DESCRIPTION

This module implements functions to access information from
underlyings.yml.  The class is a singleton. You do not need to
explicitly initialize the class, it will be initialized automatically
when you try to get an instance. By default it reads information
from C<share/underlyings.yml>.

=cut

use MooseX::Singleton;
use namespace::autoclean;
use YAML::XS qw(LoadFile);
use File::ShareDir ();

my $param = LoadFile(File::ShareDir::dist_file('Finance-Underlying', 'underlyings.yml'));

has all_parameters => (
    is      => 'ro',
    default => sub { $param },
);

has _cached_underlyings => (
    is      => 'ro',
    default => sub { {} },
);

=head2 asset

The asset being quoted, for example C<USD> for the C<frxUSDJPY> underlying.

=cut

has asset => (
	is => 'ro',
);

=head2 display_name

User-friendly English name used for display purposes.

=cut

has display_name => (
	is => 'ro',
);

=head2 exchange_name

The symbol of the exchange this underlying is traded on.

See L<Finance::Exchange> for more details.

=cut

has exchange_name => (
	is => 'ro',
);

=head2 instrument_type

Categorises the underlying, available values are:

=over 4

=item * commodities

=item * forex

=item * future

=item * individualstock

=item * smart_fx

=item * stockindex

=item * synthetic

=back

=cut

has instrument_type => (
	is => 'ro',
);

=head2 market

The type of market for this underlying, for example C<forex> for foreign exchange.

This will be one of the following:

=over 4

=item * commodities

=item * forex

=item * futures

=item * indices

=item * stocks

=item * volidx

=back

=cut

has market => (
	is => 'ro',
);

=head2 market_convention

These should mirror Bloomberg's Composite vol data conventions.

For further information, see C<Foreign Exchange option pricing>, by Iain J Clark, pages
47 onwards.

Types of volatility conventions available:

=head3 atm_setting

There are three types:

=over 4

=item * B<atm_delta_neutral_straddle> - strike so that call delta = -put delta

=item * B<atm_forward> - strike = forward price

=item * B<atm_spot> - strike = spot

=back

=head3 delta_premium_adjusted

There are two types:

=over 4

=item * 1 for premium adjusted . Premium adjusted means the actual hedge
quantity must be adjusted by the premium received if the premium is
paid in foreign currency.

=item * 0 for no premium adjusted - for futher explanation please refer to Wystup C<FX Volatility Smile Construction> April 2010 paper, pg 5 and 6.

=back

=head3 delta_style

There are two delta convention available:

=over 4

=item * B<spot_delta> - with a hedge in the spot market.

=item * B<forward_delta> - with a hedge in FX forward market

=back

=head3 rr

Risk reversal:

=over 4

=item * call-put

=item * put-call

=back

=head3 bf

There are three types of butterfly available in Bloomberg setting:

=over 4

=item * B<(call+put)/2-atm>  (which is quoted 1 vol strangle for Composite
sources and 2 vol (a.k.a smile strangle) for BGN sources)

=item * B<Base currency strangle> - ATM (which is (base currency call + base
currency put)- ATM)

=item * B<Foreign currency strangle> - ATM (which is (foreign currency call +
foreign currency put)- ATM)

=back

=cut

has market_convention => (
	is => 'ro',
);

=head2 pip_size

=cut

has pip_size => (
	is => 'ro',
);

=head2 quoted_currency

=cut

has quoted_currency => (
	is => 'ro',
);

=head2 submarket

=cut

has submarket => (
	is => 'ro',
);

=head2 symbol

The symbol of the underlying, for example C<frxUSDJPY> or C<

=cut

has symbol => (
	is => 'ro',
);


=head2 $self->cached_underlyings

Return reference to the hash containing previously created underlying objects.
If underlyings.yml changed, cache will be flushed.

=cut

sub cached_underlyings {
    my $self = shift;
    return $self->_cached_underlyings;
}

=head2 $self->symbols

Return list of all underlyings from the db

=cut

sub symbols {
    my $self = shift;
    return keys %{$self->all_parameters};
}

=head2 $self->get_parameters_for($symbol)

Return reference to hash with parameters for given symbol.

=cut

sub get_parameters_for {
    my ($self, $underlying) = @_;
    return $self->all_parameters->{$underlying};
}

=head2 $self->available_contract_categories

Return list of all available contract categories

=cut

sub available_contract_categories {
    return qw(asian digits callput endsinout touchnotouch staysinout);
}

=head2 $self->available_expiry_types

Return list of all available bet sub types

=cut

sub available_expiry_types {
    return qw(intraday daily tick);
}

=head2 $self->available_start_types

Return list of all available start types

=cut

sub available_start_types {
    return qw(spot forward);
}

=head2 $self->available_barrier_categories

Return list of all available barrier_categories

=cut

sub available_barrier_categories {
    return qw(euro_atm euro_non_atm american non_financial asian);
}

=head2 $self->available_iv_categories

Return list of all available iv contract categories

=cut

sub available_iv_categories {
    return qw(callput endsinout touchnotouch staysinout);
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;

=head1 SEE ALSO

=over 4

=item * L<Finance::Contract> - represents a financial contract

=back

=head1 AUTHOR

binary.com

=cut
