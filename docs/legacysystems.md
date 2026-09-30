# Interoperating with Legacy Systems

Before going into details, you really need to ask yourself if it really is a good idea to support legacy systems since those systems may not meet most modern standards and institutional requirements.  We urge system administrators to upgrade or replace their legacy systems.

## SSL Protocol is Dropped

In OpenSSL 1.1, the SSL 2.0 protocol was removed.  In OpenSSL 4.0, the SSL 3.0 Protocol support was removed.  You may only be able to get versions of TLS from 1.0 to 1.3.

## Legacy Algorithms have been moved to the legacy Provider

In OpenSSL 3.0 and later, the [legacy provider](https://docs.openssl.org/3.4/man7/OSSL_PROVIDER-legacy/) was introduced and algorithms were moved there.

To use these algorithms, you need to call the [[/taurustls/TaurusTLS/LoadLegacyProvider]] procedure and [deploy](./deployapps.md) the legacy provider with your application.

## Security Levels were introduced

In OpenSSL 1.1.0, a new feature, [security levels](https://docs.openssl.org/3.0/man3/SSL_CTX_set_security_level/) was introduced to accept or reject algorithms by strength.   The legacy algorithms will be rejected because they are not strong enough for most security levels.

TaurusTLS exposes the API with the [[/taurustls/TaurusTLS/TTaurusTLSContext.SecurityLevel]] property plus the [[/taurustls/TaurusTLS/TTaurusTLSIOHandlerSocket.OnSecurityLevel]]   and [[/taurustls/TaurusTLS/TTaurusTLSIOHandlerSocket.OnSecurityLevel]] events.  For legacy systems, you can set the [[/taurustls/TaurusTLS/TTaurusTLSContext.SecurityLevel]] to 0 to accept anything.  That does mean accepting NUL Cipher Suites that do not provide confidentiality that may be required.
