# Interoperating with Legacy Systems

> **Warning:** Legacy systems typically fail to meet modern security standards and compliance frameworks. We strongly recommend upgrading or replacing legacy endpoints whenever possible.

## Removed SSL Protocols

* **SSL 2.0:** Removed in OpenSSL 1.1.0.
* **SSL 3.0:** Removed in OpenSSL 4.0.0.

Only TLS 1.0 through TLS 1.3 are supported in current OpenSSL releases.

## The OpenSSL Legacy Provider

OpenSSL 3.0+ relocates obsolete algorithms to a separate [legacy provider](https://docs.openssl.org/3.4/man7/OSSL_PROVIDER-legacy/). 

To re-enable these algorithms in TaurusTLS:
1. Call the [`LoadLegacyProvider`](/taurustls/TaurusTLS/LoadLegacyProvider) procedure at startup.
2. Ensure the legacy provider module is included when [deploying your application](./deployapps.md).

## Managing Security Levels

OpenSSL enforces algorithm strength via [security levels](https://docs.openssl.org/3.0/man3/SSL_CTX_set_security_level/). Weak or legacy algorithms are blocked by default on higher levels.

In TaurusTLS, you can control this via:
* **Property:** [`TTaurusTLSContext.SecurityLevel`](/taurustls/TaurusTLS/TTaurusTLSContext.SecurityLevel)
* **Event:** [`TTaurusTLSIOHandlerSocket.OnSecurityLevel`](/taurustls/TaurusTLS/TTaurusTLSIOHandlerSocket.OnSecurityLevel)

Setting `SecurityLevel = 0` accepts all supported algorithms. **Note:** This includes NULL cipher suites, which transmit data in plaintext without confidentiality.
