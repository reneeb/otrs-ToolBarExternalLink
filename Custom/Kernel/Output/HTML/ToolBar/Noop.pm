# --
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::ToolBar::Noop;

use strict;
use warnings;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    my $Priority = $Param{Config}->{'Priority'};
    my %Return   = ();

    my @Groups = split /\s*,\s*/, $Param{Config}->{Groups} // '';

    if ( @Groups ) {
        my $Found = grep{ my $Test = $LayoutObject->{"UserIsGroup[$_]"}; $Test && lc $Test eq 'yes' }@Groups;
        return if !$Found;
    }

    $Return{ $Priority++ } = {
        Block       => $Param{Config}->{Block},
        Description => $Param{Config}->{Description},
        Name        => $Param{Config}->{Name},
        Size        => $Param{Config}->{Size},
        Fulltext    => '',
        Image       => '',
        AccessKey   => '',
        %{ $Param{Config} },
    };

    return %Return;
}

1;
