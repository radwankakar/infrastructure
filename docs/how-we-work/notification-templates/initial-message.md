The following should be used as a message template when sending notifications via email about system outages and this is the first email letting people know.

## When to Use
If an issue is determined to be P0 or P1 based on <span class="x x-first x-last">[our Support Process doc definition](</span>support-process.md<span class="x x-first x-last">).</span>

## Recipients
alana.buroff@acf.hhs.gov, headstart-hosting@truss.works, nate.price@gsa.gov, townley.knudson@hendall.com, scott.weinfeld@hendall.com, samuel.nevares@hendall.com, lsoaterna@zerotothree.org, daytonra@uw.edu, corvin@uw.edu

## Subject
`<Site or Application Name> <Outage|Partial Outage|Security Incident> - <timestamp in ET>`

## Body
  `<Site or Application Name> is experiencing a <total outage|partial outage|security incident>.`
  
  Description of impact of issue, i.e. no users can access site, no users can access a particular application, some users cannot access site, etc.
  
  `Slack thread: <link to Slack thread>`
  
  `Ticket: <link to ticket>`
  
  ```
  The team is working on it and will provide updates every hour until it is resolved.
  
  Please contact headstart-hosting@truss.works if you need more information.
  
  Thank you.
  ```
