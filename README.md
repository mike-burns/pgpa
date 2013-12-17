# PGP Authenticated Sign In

This app is a proof of concept spike. The idea:

Sign up:

1. Sign up using your PGP key id.
2. You are then prompted to confirm each email address by following
one-time URLs sent in encrypted, signed emails.

Sign in:

1. Sign in using a recognized email address.
2. You are then sent a one-time sign in URL in an encrypted, signed
email.

## Setup

Set the following environment variables:

- `PGPPATH` (or `GNUPGHOME`) - the full path to your PGP root directory.
- `EMAIL_SIGNER` - the email address used to sign the server's keys.

The `$PGPPATH` directory must have a keyring with, at minimum, the
secret key for `$EMAIL_SIGNER`.

For example:

    export PGPPATH=/tmp/gpg-$$
    export EMAIL_SIGNER=frank@example.com

    rails s # will create $PGPPATH and set its permission correctly
    
    gpg --homedir $PGPPATH --import secret-key.asc

You should also familarize yourself with
`config/environments/development.rb`. Of note, it uses `:msmtp` to send
emails locally.

## Meta

Copyright 2013 Mike Burns. Licensed under BSD license.

If you think this is interesting, send me an encrypted email saying so.

    Key id: 0x3E6761F72846B014
    Fingerprint: 5FD8 2CE6 A646 3285 538F  C3A5 3E67 61F7 2846 B014

Also consider donating:

[1KfA9S19ozuBurdZjCNvNqmkafMQrsKkdq](bitcoin:1KfA9S19ozuBurdZjCNvNqmkafMQrsKkdq)
