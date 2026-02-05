#!/usr/bin/env python3

import sys
import re

if len(sys.argv) != 3:
    print(f"Usage: {sys.argv[0]} <input markdown_file> <output markdown_file>")
    sys.exit(1)

path = sys.argv[1]
out_path = sys.argv[2]

with open(path, "r", encoding="utf-8") as f:
    lines = f.readlines()

out = []

# Regex to match: ![](xxx){yyy}
md_img_re = re.compile(
    r'^(\s*)!\[\]\(([^)]+)\)\{[^}]*\}\s*$'
)

for line in lines:
    m = md_img_re.match(line)
    if not m:
        out.append(line)
        continue

    indent = m.group(1)
    img_path = m.group(2)

    # 1. Comment original Markdown image
    out.append(f"{indent}<!-- {line.rstrip()} -->\n")

    # 2. Insert HTML block below
    out.append(f"""{indent}<div align="center">
{indent}    <img src="{img_path}" width="40%" height="40%">
{indent}</div>
""")

with open(out_path, "w", encoding="utf-8") as f:
    f.writelines(out)

print("Done: Markdown images converted to centered HTML blocks.")
