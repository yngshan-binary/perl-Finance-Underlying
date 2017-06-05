# NAME

Finance::Underlying - Object representation of a financial asset

# SYNOPSIS

    use Finance::Underlying;

    my $fa        = Finance::Underlying->instance;
    my $sym_props = $fa->get_parameters_for('frxEURUSD');
    print $sym_props->{pip_size}, "\n";

# DESCRIPTION

This module implements functions to access information from
underlyings.yml.  The class is a singleton. You do not need to
explicitly initialize the class, it will be initialized automatically
when you try to get an instance. By default it reads information
from `share/underlyings.yml`.

## asset

The asset being quoted, for example `USD` for the `frxUSDJPY` underlying.

## display\_name

User-friendly English name used for display purposes.

## exchange\_name

The symbol of the exchange this underlying is traded on.

See [Finance::Exchange](https://metacpan.org/pod/Finance::Exchange) for more details.

## instrument\_type

Categorises the underlying, available values are:

- commodities
- forex
- future
- individualstock
- smart\_fx
- stockindex
- synthetic

## market

The type of market for this underlying, for example `forex` for foreign exchange.

This will be one of the following:

- commodities
- forex
- futures
- indices
- stocks
- volidx

## market\_convention

These should mirror Bloomberg's Composite vol data conventions.

For further information, see `Foreign Exchange option pricing`, by Iain J Clark, pages
47 onwards.

Types of volatility conventions available:

### atm\_setting

There are three types:

- **atm\_delta\_neutral\_straddle** - strike so that call delta = -put delta
- **atm\_forward** - strike = forward price
- **atm\_spot** - strike = spot

### delta\_premium\_adjusted

There are two types:

- 1 for premium adjusted . Premium adjusted means the actual hedge
quantity must be adjusted by the premium received if the premium is
paid in foreign currency.
- 0 for no premium adjusted - for futher explanation please refer to Wystup `FX Volatility Smile Construction` April 2010 paper, pg 5 and 6.

### delta\_style

There are two delta convention available:

- **spot\_delta** - with a hedge in the spot market.
- **forward\_delta** - with a hedge in FX forward market

### rr

Risk reversal:

- call-put
- put-call

### bf

There are three types of butterfly available in Bloomberg setting:

- **(call+put)/2-atm**  (which is quoted 1 vol strangle for Composite
sources and 2 vol (a.k.a smile strangle) for BGN sources)
- **Base currency strangle** - ATM (which is (base currency call + base
currency put)- ATM)
- **Foreign currency strangle** - ATM (which is (foreign currency call +
foreign currency put)- ATM)

## pip\_size

## quoted\_currency

## submarket

## symbol

The symbol of the underlying, for example `frxUSDJPY` or `WLDAUD`.

## $self->cached\_underlyings

Return reference to the hash containing previously created underlying objects.
If underlyings.yml changed, cache will be flushed.

## $self->symbols

Return list of all underlyings from the db

## $self->get\_parameters\_for($symbol)

Return reference to hash with parameters for given symbol.

## $self->available\_contract\_categories

Return list of all available contract categories

## $self->available\_expiry\_types

Return list of all available bet sub types

## $self->available\_start\_types

Return list of all available start types

## $self->available\_barrier\_categories

Return list of all available barrier\_categories

## $self->available\_iv\_categories

Return list of all available iv contract categories

# SEE ALSO

- [Finance::Contract](https://metacpan.org/pod/Finance::Contract) - represents a financial contract

# AUTHOR

binary.com
