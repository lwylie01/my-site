# Deployment Guide
## Quarto Website → GitHub Pages → Namecheap Custom Domain

---

## PART 1 — Local setup (do this once)

### Step 1: Install prerequisites

You need three things installed:

**Quarto CLI**
Download from https://quarto.org/docs/get-started/
Verify: open Terminal and run `quarto --version`

**Git**
Mac: run `git --version` — if not installed, macOS will prompt you.
Windows: download from https://git-scm.com

**GitHub CLI (optional but much easier)**
Mac: `brew install gh`
Windows: download from https://cli.github.com
Verify: `gh --version`

---

### Step 2: Organise your project folder

Your site folder should look exactly like this:

```
my-site/
├── _quarto.yml              ← site config (already built)
├── site-theme.scss          ← visual theme (already built)
├── index.qmd                ← home page (already built)
├── projects/
│   └── index.qmd            ← projects gallery (already built)
├── teaching/
│   └── index.qmd            ← teaching page (already built)
├── writing/
│   └── index.qmd            ← writing page (already built)
└── hiphop/
    ├── hiphop_dashboard.qmd ← your dashboard (already built)
    └── custom.scss          ← dashboard theme (already built)
```

IMPORTANT: The hiphop dashboard uses `format: dashboard` in its own YAML,
which overrides the site's `format: html`. That's correct — leave it as is.
Quarto handles mixed formats within one site automatically.

---

### Step 3: Edit _quarto.yml with your real details

Open `_quarto.yml` and replace every placeholder:

```yaml
website:
  title: "Your Actual Name"
  site-url: https://youractualdomain.com

  navbar:
    right:
      - href: https://github.com/youractualusername
      - href: https://linkedin.com/in/youractualprofile
```

Also update `index.qmd`:
- Replace "Your Name" in the hero section
- Replace "YN" initials in the avatar placeholder
- Update bio text, credentials, and email

---

### Step 4: Test locally before publishing

In Terminal, navigate to your site folder and run:

```bash
cd path/to/my-site
quarto preview
```

This opens a live-reloading preview at http://localhost:4949
Check every page and link before publishing.

To do a full render without previewing:
```bash
quarto render
```

This creates a `_site/` folder with all the HTML — that's what gets published.

---

## PART 2 — GitHub setup (do this once)

### Step 5: Create a GitHub repository

**Option A — GitHub CLI (easiest)**
```bash
cd path/to/my-site
gh auth login        # follow prompts, choose HTTPS, authenticate in browser
gh repo create my-site --public --source=. --remote=origin
```

**Option B — GitHub website**
1. Go to https://github.com/new
2. Repository name: `my-site` (or anything you like)
3. Set to Public
4. Do NOT initialise with README (your folder already has files)
5. Click Create repository
6. Back in Terminal:
```bash
cd C:\Users\lwylie\OneDrive - National Center for State Courts\Desktop\My ART\my-site
git init
git add .
git commit -m "Initial site"
git remote add origin https://github.com/lwylie01/my-site.git
git push -u origin main
```

---

### Step 6: Publish to GitHub Pages

Run this single command from your site folder:

```bash
quarto publish gh-pages
```

What this does automatically:
1. Renders your entire site to `_site/`
2. Creates a `gh-pages` branch in your repo
3. Pushes all the rendered HTML to that branch
4. GitHub Pages serves it at:
   https://YOURUSERNAME.github.io/my-site/

Quarto will ask "Publish update to: https://YOURUSERNAME.github.io/my-site/? (Y/n)"
→ Press Y

Your site is now live at the github.io URL. Test it before connecting the domain.

---

### Step 7: Enable GitHub Pages in repo settings

After the first publish, confirm the settings:
1. Go to your repo on github.com
2. Click Settings → Pages (left sidebar)
3. Source should show "Deploy from a branch"
4. Branch should show "gh-pages / (root)"
5. If not, set it manually and Save

---

## PART 3 — Namecheap DNS (the fun part)

### Step 8: Tell GitHub about your custom domain

1. In your GitHub repo → Settings → Pages
2. Scroll to "Custom domain"
3. Type your domain exactly: `yourdomain.com` (no https://, no www)
4. Click Save
5. Check "Enforce HTTPS" (may take a few minutes to become available)

GitHub will create a file called `CNAME` in your gh-pages branch automatically.
You'll also need it in your source — create a file called `CNAME` (no extension)
in your site root folder containing just your domain name:

```
yourdomain.com
```

Then re-run `quarto publish gh-pages` to include it.

---

### Step 9: Namecheap DNS — exact click-by-click

1. Log in to namecheap.com
2. Click "Domain List" in the left sidebar
3. Click "Manage" next to your domain
4. Click the "Advanced DNS" tab at the top

You'll see a table of DNS records. You need to:

**Delete any existing A records and CNAME records for @ and www**
(There may be default parking page records — delete them)

**Add these four A records** (click "Add New Record" four times):

| Type | Host | Value              | TTL      |
|------|------|--------------------|----------|
| A    | @    | 185.199.108.153    | Automatic |
| A    | @    | 185.199.109.153    | Automatic |
| A    | @    | 185.199.110.153    | Automatic |
| A    | @    | 185.199.111.153    | Automatic |

**Add one CNAME record:**

| Type  | Host | Value                              | TTL      |
|-------|------|------------------------------------|----------|
| CNAME | www  | YOURUSERNAME.github.io.            | Automatic |

NOTE: Include the trailing dot after `.github.io` — Namecheap requires it.

Click the green checkmark to save each record.

---

### Step 10: Wait and verify

DNS propagation typically takes 5–60 minutes (occasionally up to 48 hours).

To check if it's working without waiting, open Terminal and run:
```bash
dig yourdomain.com +short
```
When you see the four GitHub IP addresses returned, DNS has propagated.

To check from a browser:
- Try https://yourdomain.com — should show your site
- Try https://www.yourdomain.com — should redirect to the same site
- The padlock (HTTPS) should be green — if not, wait 10 more minutes

---

## PART 4 — Ongoing workflow

### How to update your site after the first publish

Every time you edit content:

```bash
# 1. Make your changes in RStudio
# 2. Preview locally
quarto preview

# 3. When happy, publish
quarto publish gh-pages
```

That's the entire workflow. Quarto re-renders only changed files (because
of `freeze: auto` in `_quarto.yml`) and pushes the update.

### Adding a new page

1. Create a new `.qmd` file anywhere in the site folder
2. Add a link to it in `_quarto.yml` navbar or in `projects/index.qmd`
3. Run `quarto publish gh-pages`

### Adding a new project like the hip-hop dashboard

1. Create a new subfolder: e.g. `projects/project2/`
2. Put your `.qmd` file there
3. Add a card to `projects/index.qmd` linking to it
4. Publish

---

## Troubleshooting

**"Site not found" after setting custom domain**
→ DNS hasn't propagated yet. Wait and run `dig yourdomain.com +short`

**HTTPS padlock missing / "Not secure"**
→ Go to GitHub repo → Settings → Pages → check "Enforce HTTPS"
→ May take 10–30 mins after DNS propagates

**Dashboard page shows wrong layout / missing styles**
→ Make sure `custom.scss` is in the same folder as `hiphop_dashboard.qmd`
→ Check the dashboard YAML references `custom.scss` correctly

**`quarto publish gh-pages` asks for credentials repeatedly**
→ Run `gh auth login` and authenticate — Quarto uses git credentials

**Local preview works but published site has broken links**
→ Check `site-url` in `_quarto.yml` matches your actual domain exactly

**Namecheap CNAME "already exists" error**
→ You have an existing CNAME for www — delete it first, then add the new one

---

## Quick reference card

```bash
# Preview locally
quarto preview

# Full render (no preview)
quarto render

# Publish / update live site
quarto publish gh-pages

# Check DNS propagation
dig yourdomain.com +short

# GitHub CLI login (if needed)
gh auth login
```

GitHub IPs (for Namecheap A records):
185.199.108.153
185.199.109.153
185.199.110.153
185.199.111.153
