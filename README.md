#jprjr/dbmail

**This is still very experimental - do not use this in production!**


## Ports

* 24 - LMTP
* 143 - The standard IMAP port

## Environment Variables

### The complete list:

* `MYSQL_HOST`
* `MYSQL_USER`
* `MYSQL_PASS`
* `DB_USER`
* `DB_PASS`
* `SKIP_DB_SETUP`
* `SKIP_DBMAIL_SETUP`

### Details on each variable

* `MYSQL_HOST` - use this to specify your MySQL server.
* `MYSQL_USER` - use this to specify your root MySQL user (optional)
* `MYSQL_PASS` - use this to specify your root MySQL password (optional)

If `MYSQL_HOST` is set (or you have a linked container named `mysql`), then
that MySQL server will be used for querying users.

If `MYSQL_USER` and `MYSQL_PASS` are set, then I'll create the needed
database for dbmail. If these are blank, I skip that step.

* `DB_USER`
* `DB_PASS`

These drive what database name to use, as well as a username and password
for that database. These are required variables.

* `SKIP_DB_SETUP` - if this is set to anything, then the entire DB setup
process will be skipped. This is useful if you already have a db of users
you want to use, and don't want me trying to create tables.

* `SKIP_DBMAIL_SETUP` - Disables creating the /etc/dovecot folder.

