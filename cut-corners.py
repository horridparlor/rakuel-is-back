from pathlib import Path
from PIL import Image, ImageDraw
import hashlib
import json
import os

RADIUS = 32
LOG_FILE = Path("processed.log")

def sha256_file(path):
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()

def load_log():
    if LOG_FILE.exists():
        try:
            return json.loads(LOG_FILE.read_text())
        except json.JSONDecodeError:
            return {}
    return {}

def save_log(log):
    LOG_FILE.write_text(json.dumps(log, indent=2, sort_keys=True))

def round_corners(path):
    img = Image.open(path).convert("RGBA")
    w, h = img.size

    # Supersampling gives GIMP/Godot-like smooth edges
    scale = 4
    big_size = (w * scale, h * scale)
    big_radius = RADIUS * scale

    mask = Image.new("L", big_size, 0)
    draw = ImageDraw.Draw(mask)
    draw.rounded_rectangle(
        (0, 0, big_size[0] - 1, big_size[1] - 1),
        radius=big_radius,
        fill=255
    )

    mask = mask.resize((w, h), Image.Resampling.LANCZOS)

    old_alpha = img.getchannel("A")
    new_alpha = Image.new("L", (w, h), 0)

    # Keep existing transparency, but cut outside rounded rect
    new_alpha = Image.composite(old_alpha, new_alpha, mask)
    img.putalpha(new_alpha)

    tmp = path.with_suffix(".tmp.png")
    img.save(tmp)
    os.replace(tmp, path)

def main():
    log = load_log()

    for path in sorted(Path(".").glob("*.png")):
        if path.name == LOG_FILE.name:
            continue

        before = sha256_file(path)

        if log.get(path.name) == before:
            print(f"Skipping {path.name}")
            continue

        print(f"Processing {path.name}")
        round_corners(path)

        after = sha256_file(path)
        log[path.name] = after
        save_log(log)

if __name__ == "__main__":
    main()
