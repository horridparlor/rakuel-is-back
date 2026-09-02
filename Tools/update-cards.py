# update-cards.py
from collections import defaultdict
from pathlib import Path
import csv
import json
import re

CARD_TYPES = ["rock", "paper", "scissors", "gun"]

CARDS_DIR = Path("../Data/Cards")
ENUMS_FILE = Path("../Enums/card_enums.gd")
SQL_DIR = Path("Sql")
CSV_DIR = Path("Csv")

SQL_DIR.mkdir(exist_ok=True)
CSV_DIR.mkdir(exist_ok=True)

def sql_str(value):
    if value is None:
        return "NULL"
    return "'" + str(value).replace("\\", "\\\\").replace("'", "''") + "'"

def sql_bool(value):
    if value is None:
        return "NULL"
    return "1" if value else "0"

def parse_gd_keyword_info():
    text = ENUMS_FILE.read_text(encoding="utf-8")

    # TranslateKeyword: "name" -> Keyword.ENUM
    translate = {}
    in_block = False
    for line in text.splitlines():
        if "const TranslateKeyword" in line:
            in_block = True
            continue
        if in_block:
            m = re.match(r'\s+"([^"]+)":\s+Keyword\.(\w+)', line)
            if m:
                translate[m.group(1)] = m.group(2)
            elif "}" in line:
                break

    # KeywordNames: Keyword.ENUM -> "displayName"
    names = {}
    in_block = False
    for line in text.splitlines():
        if "const KeywordNames" in line:
            in_block = True
            continue
        if in_block:
            m = re.match(r'\s+Keyword\.(\w+):\s+"([^"]+)"', line)
            if m:
                names[m.group(1)] = m.group(2)
            elif "}" in line:
                break

    # KeywordDescriptions: Keyword.ENUM -> raw description
    descriptions = {}
    in_block = False
    for line in text.splitlines():
        if "const KeywordDescriptions" in line:
            in_block = True
            continue
        if in_block:
            m = re.match(r'\s+Keyword\.(\w+):\s+"([^"]+)"', line)
            if m:
                descriptions[m.group(1)] = m.group(2)
            elif "}" in line:
                break

    # KeywordTags: Keyword.ENUM -> KeywordTag.TAG_ENUM
    tags = {}
    in_block = False
    for line in text.splitlines():
        if "const KeywordTags" in line:
            in_block = True
            continue
        if in_block:
            m = re.match(r'\s+Keyword\.(\w+):\s+KeywordTag\.(\w+)', line)
            if m:
                tags[m.group(1)] = m.group(2)
            elif "}" in line:
                break

    # KeywordTagNames: KeywordTag.TAG_ENUM -> "tag name"
    tag_names = {}
    in_block = False
    for line in text.splitlines():
        if "const KeywordTagNames" in line:
            in_block = True
            continue
        if in_block:
            m = re.match(r'\s+KeywordTag\.(\w+):\s+"([^"]+)"', line)
            if m:
                tag_names[m.group(1)] = m.group(2)
            elif "}" in line:
                break

    result = {}
    for name, enum in translate.items():
        raw_desc = descriptions.get(enum, "")
        tag_enum = tags.get(enum, "")
        tag_name = tag_names.get(tag_enum, "")
        if raw_desc.startswith("..."):
            full_desc = tag_name + " " + raw_desc[3:]
        else:
            full_desc = f"[{tag_name}] {raw_desc}" if tag_name else raw_desc
        result[name] = {
            "displayName": names.get(enum, name),
            "description": full_desc,
        }
    return result

keyword_info = parse_gd_keyword_info()

cards = []
keywords = set()
keyword_earliest = defaultdict(lambda: "9999-99-99")

for path in sorted(CARDS_DIR.glob("*.json")):
    with path.open("r", encoding="utf-8") as f:
        card = json.load(f)

    for field in ["id", "name", "type", "power"]:
        if field not in card:
            raise ValueError(f"{path}: missing mandatory field {field}")

    if card["type"] not in CARD_TYPES:
        raise ValueError(f"{path}: unknown card type {card['type']}")

    kws = card.get("keywords") or []
    if len(kws) > 3:
        raise ValueError(f"{path}: max 3 keywords allowed")

    hide = set(card.get("hide_reminder_text") or [])

    padded = list(kws) + [None] * (3 - len(kws))
    reminder_visible = [
        None if kw is None else kw not in hide
        for kw in padded
    ]

    date = card.get("created_at") or "9999-99-99"
    for kw in kws:
        keywords.add(kw)
        if date < keyword_earliest[kw]:
            keyword_earliest[kw] = date

    alt_arts = card.get("alt_arts")

    cards.append({
        "id": int(card["id"]),
        "name": card["name"],
        "type": card["type"],
        "power": int(card["power"]),
        "keyword1": padded[0],
        "keyword2": padded[1],
        "keyword3": padded[2],
        "reminderVisible": reminder_visible[0],
        "reminder2Visible": reminder_visible[1],
        "reminder3Visible": reminder_visible[2],
        "altArts": int(alt_arts) if alt_arts is not None else None,
        "created_at": card.get("created_at"),
    })

# Sort by earliest card using that keyword, then alphabetically for ties
keywords = sorted(keywords, key=lambda kw: (keyword_earliest[kw], kw))
keyword_ids = {kw: i + 1 for i, kw in enumerate(keywords)}
cards.sort(key=lambda c: c["id"])

# CSV files for quick checking
with (CSV_DIR / "isBack_cardType.csv").open("w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)
    writer.writerow(["id", "name"])
    for i, name in enumerate(CARD_TYPES, start=1):
        writer.writerow([i, name])

with (CSV_DIR / "isBack_keyword.csv").open("w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)
    writer.writerow(["id", "name", "displayName", "description"])
    for kw in keywords:
        info = keyword_info.get(kw, {})
        writer.writerow([keyword_ids[kw], kw, info.get("displayName", kw), info.get("description", "")])

with (CSV_DIR / "isBack_card.csv").open("w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=[
        "id", "name", "type", "power",
        "keyword1", "keyword2", "keyword3",
        "reminderVisible", "reminder2Visible", "reminder3Visible",
        "altArts", "created_at",
    ])
    writer.writeheader()
    writer.writerows(cards)

# SQL update file
lines = []

lines.append("-- Auto-generated from Cards/*.json")
lines.append("START TRANSACTION;")
lines.append("SET FOREIGN_KEY_CHECKS = 0;")
lines.append("")

lines.append("INSERT INTO isBack_cardType (id, name) VALUES")
lines.append("(1, 'rock'),")
lines.append("(2, 'paper'),")
lines.append("(3, 'scissors'),")
lines.append("(4, 'gun')")
lines.append("ON DUPLICATE KEY UPDATE name = VALUES(name);")
lines.append("")

lines.append("DELETE FROM isBack_keyword;")
for kw in keywords:
    info = keyword_info.get(kw, {})
    display_name = info.get("displayName", kw)
    description = info.get("description", "")
    lines.append(
        f"INSERT INTO isBack_keyword (id, name, displayName, description) VALUES "
        f"({keyword_ids[kw]}, {sql_str(kw)}, {sql_str(display_name)}, {sql_str(description)});"
    )

lines.append("")

for c in cards:
    created_at_value = (
        sql_str(c["created_at"])
        if c["created_at"]
        else "CURRENT_TIMESTAMP"
    )

    values = [
        str(c["id"]),
        sql_str(c["name"]),
        f"(SELECT id FROM isBack_cardType WHERE name = {sql_str(c['type'])})",
        str(c["power"]),
        f"(SELECT id FROM isBack_keyword WHERE name = {sql_str(c['keyword1'])})" if c["keyword1"] else "NULL",
        f"(SELECT id FROM isBack_keyword WHERE name = {sql_str(c['keyword2'])})" if c["keyword2"] else "NULL",
        f"(SELECT id FROM isBack_keyword WHERE name = {sql_str(c['keyword3'])})" if c["keyword3"] else "NULL",
        sql_bool(c["reminderVisible"]),
        sql_bool(c["reminder2Visible"]),
        sql_bool(c["reminder3Visible"]),
        str(c["altArts"]) if c["altArts"] is not None else "NULL",
        created_at_value,
    ]

    lines.append(f"""
INSERT INTO isBack_card (
    id, name, cardTypeId, power,
    keywordId, keyword2Id, keyword3Id,
    reminderVisible, reminder2Visible, reminder3Visible,
    altArts, created_at
) VALUES (
    {", ".join(values)}
)
ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    cardTypeId = VALUES(cardTypeId),
    power = VALUES(power),
    keywordId = VALUES(keywordId),
    keyword2Id = VALUES(keyword2Id),
    keyword3Id = VALUES(keyword3Id),
    reminderVisible = VALUES(reminderVisible),
    reminder2Visible = VALUES(reminder2Visible),
    reminder3Visible = VALUES(reminder3Visible),
    altArts = VALUES(altArts);
""".strip())

lines.append("")
lines.append("SET FOREIGN_KEY_CHECKS = 1;")
lines.append("COMMIT;")

(SQL_DIR / "updateCards.sql").write_text("\n".join(lines), encoding="utf-8")

print("Created:")
print(SQL_DIR / "updateCards.sql")
print(CSV_DIR / "isBack_cardType.csv")
print(CSV_DIR / "isBack_keyword.csv")
print(CSV_DIR / "isBack_card.csv")
