# Security Policy

## Supported Versions

We provide security updates for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 0.2.x   | :white_check_mark: |
| 0.1.x   | :x:                |

## Reporting a Vulnerability

If you discover a security vulnerability, please report it by:

1. **Do NOT** open a public issue
2. Email the maintainer or open a private security advisory on GitHub
3. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

## Security Considerations

### File Output
- The mod writes to the Factorio script-output directory
- Files are created with default system permissions
- Consider file access controls in multi-user environments

### Performance
- Malicious settings could cause performance issues
- Collection intervals are bounded (60-18000 ticks)

### Data Privacy
- No personal data is collected or transmitted
- All data is game statistics only
- Files remain local unless external tools are used

## Best Practices

When using CloudMonitoring:
- Review file permissions in the script-output directory
- Monitor disk usage if running long sessions
- Use appropriate security for any external monitoring systems
- Keep mod updated to latest version

## Response Time

- We aim to acknowledge reports within 48 hours
- Security updates will be prioritized
- Public disclosure after fix is available (coordinated disclosure)
