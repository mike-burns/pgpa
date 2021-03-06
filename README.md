# Experiments in sign in

This app is a proof of concept spike. The idea:

## PGP-based sign in

Sign up:

1. Sign up using your PGP key id.
2. You are then prompted to confirm each email address by following
one-time URLs sent in encrypted, signed emails.

Sign in:

1. Sign in using a recognized email address.
2. You are then sent a one-time sign in URL in an encrypted, signed
email.

Security concerns: since the one-time URL stores data in the params, the
one-time hash is stored in the browser history. This exposes not just
how often the user signs in, but also a history of the hashes that can
be analyzed.

## Time-based one-time password sign in

Sign up:

1. Sign up using your email address.
2. You are shown a secret key for your TOTP. Add this to your TOTP app
   (Authy, Google Authenticator, etc.).

Sign in:

1. Sign in using your email addres and the TOTP as generated by your
   app.

Security concerns: we store the secret key in plain text in the database.
Anyone with access to the secret key can generate a TOTP trivially.

## Passphrase sign in

Sign up:

1. If you have DOMCrypt support, you are presented with a email +
   passphrase prompt.
2. When you submit the form, your passphrase is encoded in SHA256 before
   being sent to the server.
3. On the server we use BF-CBC with a 64-bit hex salt to hash the
   encoded passphrase before inserting into the database.

Sign in:

1. If you have DOMCrypt support, you are presented with a email +
   passphrase prompt.
2. When you submit the form, your passphrase is encoded in SHA256 before
   being sent to the server.
3. On the server we hash the submitted (encoded) passphrase with the
   known salt and then compare it against the record in the database.

Security concerns: should someone access the database directly and crack
the hashed passphrase, they would recover the SHA256-encoded passphrase.
This is sufficient to log into this service.

However, the SHA256-encoded passphrase is a layer of indirection to help
prevent users from leaking their passphrase. It also helps reduce the
need for the user to trust us with their passphrase.

## Setup

Set the following environment variables:

- `PGPPATH` (or `GNUPGHOME`) - the full path to your PGP root directory.
- `EMAIL_SIGNER` - the email address used to sign the server's keys.
- `SECRET_KEY_SOURCE` - the absolute path to a file containing the
  server's secret key. This is cleared after it is used.

The `$PGPPATH` directory must have a keyring with, at minimum, the
secret key for `$EMAIL_SIGNER`.

For example:

    export PGPPATH=/tmp/gpg-$$
    export EMAIL_SIGNER=frank@example.com
    export SECRET_KEY_SOURCE=$PWD/secret-key.asc

    rails s
    # creates $PGPPATH, sets its permission correctly, and imports the
    # secret key

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
