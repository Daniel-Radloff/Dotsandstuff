# App Sec
#hacking 

## Checklist

[[Useful Websites]]

### Definitions

> User controlled input can come from:
> - The url
> - The headers
> - The body of the request
> 	- Input fields in the app maybe

### Vuln checklist
#### Automated background
- [ ] run nikto
- [ ] run nmap on inscope items
- [ ] start something like gobuster for dir enum and dir listing

#### Passive
##### Start of assesment
- [[HTTP Strict Transport Policy Vulnerability]]: Check for the `Strict-Transport-Security` header in responses.
- check banners for versions if nikto and others said nothing
- check for shitty account verification
- If cookies are used, check flags
- user enum if obvious
- robots.txt or similar
- Cross origin resource sharking vulns
- check that resources outside of domain are enforcing sub-resource integrity checks
- if in scope, check domains [[Domain Information Gathering]]. could be worth checking anyway for a weird reason i guess
- check for path confusion, if there is, test web cache poisoning later
- test for s3 buckets and other [[Cloud Resources]]
##### Later
- password policy

#### Active
- [[Cross Site Scripting (XSS)]]: check for any user input that is displayed back to us on the site
- [[SQL Injection]]: check for user inputs that modify the state or database of the application (not really state but whatever jonno wont see this)
- [[Cross Site Request Forgery (CSRF)]]: Look for requests that wont get preflighted and dont have CSRF tokens and even better if there is bad CORS
- check for file upload
- check for MFA bypasses
- check auth bypasses especially on endpoints that look enumerable (idor ahh)
- check software in the banners for CVE's
- command injection: iffy and context dependant. its probably worth flinging some shit at the walls and seeing if it sticks but be aware of what your throwing shit onto cause if its doing sensitive logic then its probably worth checking with client first cause this would be infra
- path traversal: look for API calls that take paths. anything in a html tag wont work cause its fetching from webroot so whatever
- check session fixation
- [[Server Side Include Injection Payload (SSIIP)]]

#### Later or end

- check for absurdly stupid admin passwords

#### End of assessment
- ask permission to test DOS conditions if on testing infra
- ask permission maybe to test spraying
- check lockout on our accounts

> - If cookies are used, check flags
> - 

#### Language/Framework Specific
##### PHP
Check for file inclusion