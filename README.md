# HDI_4DWP_InsertPictureExpression

A 4D **HDI** (How Do I) example demonstrating how to insert **picture expressions** into a **4D Write Pro** document — pictures whose content is not stored inline but is instead evaluated on demand from a 4D field, variable, or method call.

## What This Demo Shows

- **`ST INSERT EXPRESSION`** — inserting a live 4D expression (rather than a static picture) at the current selection/highlight range of a 4D Write Pro area, so the picture is re-evaluated whenever the document is displayed or printed.
- Three different expression sources, one per demo button:
  - **`[DOC]SamplePict`** — a picture stored in a database field.
  - **`vPicture`** — a picture loaded into a process variable at form load time via `LoadPicture()`, a method written to be embeddable as a 4D Write Pro expression.
  - **`TimestampPicture()`** — a method with no stored picture at all: it renders an SVG text stamp of the current timestamp to a picture, on every evaluation, using the [4D SVG component](https://github.com/4d/4D-SVG).
- **`WP New`** — creating an in-memory 4D Write Pro area (`WParea`) to host the inserted expressions without needing a document on disk.

## Points of Interest

This repository was modernised end-to-end against 4D 21.1 conventions. Points worth a look if you're browsing the source:

- **Picture-expression methods** (`Project/Sources/Methods/LoadPicture.4dm`, `TimestampPicture.4dm`) — written to be callable both as ordinary project methods and as inline 4D Write Pro expressions (`#DECLARE` with an optional trailing parameter resolved via `Count parameters`, and a named `#DECLARE->$result : Picture` return value).
- **Startup pattern** (`Project/Sources/Methods/00_Start.4dm`, `Forms/HDI/method.4dm`, `Forms/HDI/ObjectMethods/BtnDemo.4dm`) — uses `CALL WORKER` + non-blocking `DIALOG(...; *)` instead of `New process`/`CLOSE WINDOW`, detects and refocuses an already-open splash window instead of opening a duplicate, and threads quit state through `Form.quit` rather than an interprocess variable.
- **Modern variable declarations** — every `C_LONGINT`/`C_TEXT`/`C_OBJECT`/... directive has been migrated to `var`/`#DECLARE`, including the `Compiler_Variables`/`Compiler_Methods`/`Compiler_Arrays` metadata files; genuinely unused legacy declarations were removed outright rather than converted.
- **Method visibility** — subroutines and form-context-dependent methods (`LoadPicture`, `TimestampPicture`, the `Compiler_*` files) are flagged `invisible` so they don't clutter the Run > Method... dialog; `00_Start` remains visible as the entry point.
- **XLIFF localisation** — all form text/labels/titles and user-facing method strings are resolved via `:xliff:` references / `Localized string()`, with English and Japanese translations under `Resources/en.lproj` and `Resources/ja.lproj`.
- **Dark mode & Liquid Glass** — `Project/Sources/styleSheets.css` adapts text/background colours to `prefers-color-scheme`, and `styleSheets_mac.css` sizes buttons for macOS Tahoe's Liquid Glass rendering via `form-theme` media queries.

## Project Structure

| Path | Purpose |
|------|---------|
| `Project/Sources/Methods/00_Start.4dm` | Application entry point; opens the splash window. |
| `Project/Sources/Forms/HDI/` | Splash form (license/version gate, "Demo" button). |
| `Project/Sources/Forms/HDI2/` | Main demo form: Info tab plus the Demo tab hosting the three picture-expression buttons and the in-memory `WParea` write area. |
| `Project/Sources/Methods/LoadPicture.4dm` | Loads a picture file from the resources folder; usable as a 4D Write Pro expression. |
| `Project/Sources/Methods/TimestampPicture.4dm` | Renders a current-timestamp SVG stamp to a picture via the 4D SVG component; usable as a 4D Write Pro expression. |
| `Project/Sources/TableForms/1/Form1/`, `TableForms/1/Output/` | Input/output forms for the `DOC` table, whose `SamplePict` field supplies one of the three expressions. |
| `Resources/*.lproj/*.xlf` | XLIFF translation files (English, Japanese). |
| `Project/Sources/styleSheets*.css` | Dark mode and Liquid Glass button styling. |

## Requirements

- 4D 21.1 or later (project uses `compatibilityVersion: 2101`; simplified command names and `#DECLARE`/`var` syntax require 4D 20 R7+).
- A valid 4D Write Pro license to run the demo beyond the splash screen.
- The [4D SVG component](https://github.com/4d/4D-SVG) installed in the project's `Components` folder, required for `TimestampPicture()` to resolve its `SVG_*` commands.

## Getting Started

1. Open `Project/HDI_4DWP_InsertPictureExpression.4DProject` in 4D.
2. Run the `00_Start` method (or the "Demo" menu item) to launch the splash window.
3. Click **Demo** to open the main form, then switch to the Demo tab.
4. Click any of the three buttons to insert the corresponding picture expression into the write area, and observe that the timestamp expression re-renders on every evaluation.

## References

- **Blog post:** https://blog.4d.com/4d-write-pro-now-supports-picture-expressions/
- **Original download:** https://download.4d.com/Demos/4D_v16_R5/HDI_4DWP_InsertPictureExpression.zip
- **`ST INSERT EXPRESSION`:** https://developer.4d.com/docs/commands/st-insert-expression
- **`WP New`:** https://developer.4d.com/docs/commands/wp-new
- **4D SVG component:** https://github.com/4d/4D-SVG

## Origin

This project started as a binary `.4DB` example database originally distributed with 4D v16 R5. It was converted to the modern project architecture (`.4DProject`) using 4D 21's built-in binary-to-project conversion tool, then updated and cleaned up with the help of **GitHub Copilot**.
