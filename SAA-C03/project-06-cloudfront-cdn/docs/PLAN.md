# Plan — CloudFront CDN (Outline)

## Phase A — Origin

- [ ] S3 bucket + static site files (HTML/CSS/JS)
- [ ] Block public access (chỉ CloudFront)

## Phase B — CDN

- [ ] ACM certificate
- [ ] CloudFront distribution + OAC
- [ ] Update S3 bucket policy

## Phase C — Security

- [ ] WAF Web ACL attach to CloudFront
- [ ] Test blocked request (SQLi pattern)

## Phase D — DNS

- [ ] Route 53 alias → CloudFront (optional custom domain)

## Done khi

Truy cập qua CloudFront OK, direct S3 URL bị deny, WAF block malicious pattern.
