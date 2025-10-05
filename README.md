# geo_know

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Data Scraping:

## Wesbite

https://cliprun.com/online-beautiful-soup-compiler

## Code

from bs4 import BeautifulSoup

html = '''
<body>

</body>
'''

from bs4 import BeautifulSoup
import json

soup = BeautifulSoup(html, 'html.parser')

results = []
prefix = "https://www.plonkit.net/images/resize/600/80/"
for a in soup.find_all('a'):
href = a.get('href')
if href and not href.startswith("https://"):
href = None
img = a.find('img')
if img:
img_src = img.get('src')
if not img_src.startswith("http"):
img_src = prefix + img_src.lstrip('/images')
# Find sibling div with style 'flex: 0.5 1 0%;' or 'flex: 0.417 1 0%;'
sibling_div = None
for sibling in a.parent.find_all(recursive=False):
style = sibling.get('style')
if sibling.name == 'div' and (style == 'flex: 0.5 1 0%;' or style == 'flex: 0.417 1 0%;'):
sibling_div = sibling
break
# Extract all <p> text inside that div
p_texts = [p.get_text(strip=True) for p in sibling_div.find_all('p')] if sibling_div else []
results.append({
'locationUrl': href,
'imageUrl': img_src,
'body': " ".join(p_texts)
})

# Print JSON output
print(json.dumps(results, indent=2))