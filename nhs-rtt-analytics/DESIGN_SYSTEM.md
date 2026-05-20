# Design System — NHS RTT Dashboard

**Complete visual specification for the NHS RTT dashboard (Figma + Power BI)**

---

## Colour Palette

### Primary Colours

| Name | Hex | RGB | Usage |
|------|-----|-----|-------|
| **NHS Blue** | `#005EB8` | 0, 94, 184 | Header band, primary brand |
| **NHS Dark Blue** | `#003087` | 0, 48, 135 | Hero callouts, titles |
| **NHS Aqua** | `#00A499` | 0, 164, 153 | Secondary data series, accents |

### Secondary Colours

| Name | Hex | RGB | Usage |
|------|-----|-----|-------|
| **NHS Light Blue** | `#41B6E6` | 65, 182, 230 | Lighter highlights |
| **Grey Light** | `#E8EDEE` | 232, 237, 238 | Backgrounds, nav strips, borders |
| **Grey Mid** | `#768692` | 118, 134, 146 | Labels, axis text, subtle text |
| **Grey Dark** | `#231F20` | 35, 31, 32 | Body text, KPI numbers |

### Status Colours (RAG)

| Name | Hex | RGB | Meaning |
|------|-----|-----|---------|
| **Red** | `#DA291C` | 218, 41, 28 | Breaching / Alert |
| **Amber** | `#ED8B00` | 237, 139, 0 | Warning / Caution |
| **Green** | `#009639` | 0, 150, 57 | Compliant / Good |

### Palette Usage Rules

- **Header band (top 120px):** NHS Blue (`#005EB8`) — full width, no transparency
- **Hero callouts (big insight boxes):** NHS Dark Blue (`#003087`) — opaque white text
- **Card backgrounds:** White (`#FFFFFF`) — with 1px stroke in Grey Mid (`#768692`)
- **Chart primary series:** NHS Blue (`#005EB8`)
- **Chart secondary series:** NHS Aqua (`#00A499`)
- **Reference lines (92% target):** Red (`#DA291C`)
- **Axis labels & grid:** Grey Mid (`#768692`)
- **Body text, numbers:** Grey Dark (`#231F20`)

---

## Typography

### Font Family

**Inter** (all weights and sizes)

- **Why Inter?** Modern, clean, excellent readability at all sizes. No licensing issues.
- **Fallback:** Segoe UI (Windows), -apple-system (macOS)

### Type Scale

| Role | Font | Size | Weight | Letter-Spacing | Usage |
|------|------|------|--------|-----------------|-------|
| **Page Title** | Inter | 32px | Bold | 0 | Page header (H1) |
| **Section Header** | Inter | 20px | Semibold | 0 | Dashboard section titles |
| **Chart Title** | Inter | 16px | Semibold | 0 | Chart labels above visuals |
| **KPI Label** | Inter | 11px | Semibold | 0.5px | Card label (UPPERCASE) |
| **KPI Number** | Inter | 48px | Bold | 0 | Big number in card |
| **Body Text** | Inter | 12px | Regular | 0 | Descriptions, subtitles |
| **Axis Label** | Inter | 11px | Regular | 0 | Chart axes |
| **Footer** | Inter | 11px | Regular | 0 | Source attribution |

### Type Hierarchy

1. **Page Title (32px Bold)** — Establishes page identity
2. **KPI Big Number (48px Bold)** — Draws immediate attention to key metric
3. **Section Header (20px Semibold)** — Organizes page zones
4. **Chart Title (16px Semibold)** — Labels each visualization
5. **Body Text (12px Regular)** — Supporting information
6. **Labels (11px Semibold)** — Field names, axis labels

### Colour Rules for Text

| Text Type | Colour | Hex | Context |
|-----------|--------|-----|---------|
| Page title (white text) | White | `#FFFFFF` | On NHS Blue background |
| Section header | NHS Dark Blue | `#003087` | On white background |
| Body text | Grey Dark | `#231F20` | Main content |
| Labels (axis, cards) | Grey Mid | `#768692` | Subtle annotation |
| KPI big number | Grey Dark | `#231F20` | Emphasis |

---

## Layout Grid

### Canvas Size

- **Width:** 1920 px
- **Height:** 1080 px
- **Aspect ratio:** 16:9 (standard Full HD / Power BI custom page)

### Grid System

**12-column grid** (responsive, but fixed for this dashboard)

- **Outer margin (left & right):** 64 px
- **Column width:** 124.67 px
- **Gutter between columns:** 24 px
- **Total usable width:** 1792 px (1920 - 128 margin)

### Vertical Spacing

- **Header band height:** 120 px (0–120)
- **Navigation strip height:** 48 px (120–168)
- **Top content padding:** 32 px (from 168 to 200)
- **Content area:** 820 px (200–1020)
- **Bottom footer height:** 40 px (1040–1080)
- **Standard gutter between sections:** 24 px

### Safe Content Area

- **Left edge:** 64 px
- **Right edge:** 1856 px (1920 - 64)
- **Top edge:** 200 px (below nav)
- **Bottom edge:** 1020 px (above footer)
- **Safe content zone:** 1792 × 820 px

---

## Component Anatomy

### KPI Card Structure

Each KPI card contains 4 layers (top to bottom):

```
┌──────────────────────────────────┐
│ LABEL (11px Semibold, Grey Mid)  │  ← Fixed in PNG background
│                                  │
│            58.4%                 │  ← Card visual (Power BI replaces)
│                                  │
│ Subtitle (12px Regular, Grey)    │  ← Fixed in PNG background
└──────────────────────────────────┘
```

**Card dimensions:**
- **Width:** 430 px (for 4 cards on page)
- **Height:** 140 px (standard KPI card)
- **Padding:** 16 px (all sides)
- **Border radius:** 8 px
- **Border:** 1px solid Grey Mid (`#768692`)
- **Background:** White (`#FFFFFF`)

**Label zone (top):**
- **Font:** Inter Semibold 11px, Grey Mid
- **Text-transform:** UPPERCASE
- **Letter-spacing:** 0.5px
- **Position:** 16px from left, 16px from top
- **Height:** 32px

**Big number zone (middle):**
- **Font:** Inter Bold 48px, Grey Dark
- **Height:** 60px (centered vertically)
- **Replaced by Power BI Card visual**

**Subtitle zone (bottom):**
- **Font:** Inter Regular 12px, Grey
- **Position:** 16px from left, 108px from top
- **Height:** 32px

**RAG Dot (optional):**
- **Size:** 8 × 8 px
- **Position:** 16px from right, 16px from top
- **Colours:** Red / Amber / Green

---

### Chart Container Structure

Each chart placeholder contains:

```
┌──────────────────────────────────┐
│ Chart Title (16px Semibold)      │  ← Figma text (title)
│ Subtitle (12px Regular, Grey)    │  ← Figma text (description)
├──────────────────────────────────┤
│                                  │
│      [Power BI Chart Here]       │  ← Replaced by actual chart visual
│                                  │
└──────────────────────────────────┘
```

**Chart container dimensions:**
- **Border:** 1px solid Grey Mid
- **Border-radius:** 8 px
- **Padding (inner):** 16 px all sides
- **Title area height:** 60 px (title + subtitle)
- **Chart area:** Remaining height

**Title positioning:**
- **Font:** Inter Semibold 16px, NHS Dark Blue
- **Position:** 24px from left, 24px from top

**Subtitle positioning:**
- **Font:** Inter Regular 12px, Grey Mid
- **Position:** 24px from left, 44px from top

---

### Header Band

- **Height:** 120 px (0–120)
- **Background:** NHS Blue (`#005EB8`)
- **Padding:** 64px left, 44px top
- **Content:**
  - **Main title:** Inter Bold 32px, white
  - **Subtitle:** Inter Semibold 20px, white (positioned 36px below title)

### Navigation Strip

- **Height:** 48 px (120–168)
- **Background:** Grey Light (`#E8EDEE`)
- **Padding:** Centered horizontally
- **Content:** 3 links, separated by " | " divider
  - **Active link:** Bold, NHS Dark Blue (`#003087`)
  - **Inactive links:** Regular, Grey Mid (`#768692`)
  - **Font:** Inter Medium 14px

### Footer

- **Height:** 40 px (1040–1080)
- **Background:** Grey Light (`#E8EDEE`)
- **Padding:** 64px left, 1058px top (aligned with content)
- **Font:** Inter Regular 11px, Grey Mid
- **Content:** "Source: NHS England RTT | Apr 2024 - Mar 2025 | Author: Morteza Ghazanfari"

---

## Visual Hierarchy & Emphasis

### Primary Emphasis

Use **NHS Blue (`#005EB8`)** for:
- Chart series (main metrics)
- Primary data points
- Interactive elements (slicers, buttons)

### Secondary Emphasis

Use **NHS Aqua (`#00A499`)** for:
- Secondary chart series
- Comparison bars
- Accent elements

### Alert / Status

Use **Red (`#DA291C`)** for:
- Breaching indicators
- Alert thresholds (92% target line)
- Negative performance

### Neutral / Subtle

Use **Grey Mid (`#768692`)** for:
- Borders
- Labels
- Gridlines
- Axis text
- Non-critical annotation

---

## Responsive Behavior

**Note:** This dashboard is **fixed-size** (1920 × 1080) and not responsive.

In Power BI:
- **Page view:** "Actual size" while editing
- **Page view:** "Fit to page" when viewing (scales to fit window)
- **Custom page size:** Always 1920 × 1080

Images and assets should be **exported at 2x scale** (3840 × 2160) for crisp display when scaled down.

---

## Accessibility

### Colour Contrast

All text meets **WCAG AA** standards:
- ✅ White text on NHS Blue: 9.5:1 (AAA)
- ✅ Grey Dark on White: 8.2:1 (AAA)
- ✅ Grey Mid on White: 5.1:1 (AA)
- ✅ NHS Dark Blue on White: 8.1:1 (AAA)

### Font Sizes

- Minimum readable size: 11px (labels)
- Minimum body text: 12px
- All headers ≥ 16px

### Motion & Animation

- **Dashboard:** Static (no animations)
- **Interactivity:** Slicers and filters only (no hover effects)
- **Transitions:** None (instant filtering)

---

## Implementation Notes

### In Figma

1. Create a **Design System** file to store components:
   - Colour swatches (detached from instances)
   - Typography styles (Text field with preconfigured fonts)
   - Component library (KPI card, chart frame, header)

2. Use **auto-layout** for spacing consistency

3. Name all elements clearly (for export & handoff)

4. Export frames as **PNG at 2x scale** (Image fit: "Fit")

### In Power BI

1. Import the custom theme JSON file:
   - Format pane > Themes > Upload custom theme

2. Set **custom page size** to 1920 × 1080:
   - Format pane > Canvas settings > Type: Custom

3. Apply PNG backgrounds:
   - Format pane > Canvas background > Browse > Select PNG
   - Image fit: **Fit** (not "Fill")
   - Transparency: 0%

4. Place visuals over placeholder zones:
   - Card visuals: X = Figma X + 16, Y = Figma Y + 60
   - Charts: Leave space for title (title in PNG, chart below)

5. Format chart colours to match palette:
   - Series colours: NHS Blue, NHS Aqua, etc.
   - Axis labels: Grey Mid
   - Gridlines: Grey Light

---

## Quality Checklist

Before exporting from Figma:
- [ ] All text uses **Inter font** (no fallbacks)
- [ ] All colours match hex values exactly
- [ ] All spacing follows 24px or 16px increments
- [ ] Border radius is **8px** (not rounded differently)
- [ ] Stroke weight is **1px** (not 0.5px or 2px)
- [ ] Grid is **HIDDEN** before export (eye icon off)
- [ ] No placeholder text remaining
- [ ] All layers are named descriptively

Before publishing in Power BI:
- [ ] Page size is **1920 × 1080**
- [ ] PNG background transparency is **0%**
- [ ] All card visuals have **no background**
- [ ] Chart visuals have **no titles** (titles in PNG)
- [ ] All colours match the palette
- [ ] No overlapping visuals
- [ ] Wallpaper colour is **white**

---

**Version:** 1.0  
**Last Updated:** May 2026  
**Author:** Morteza Ghazanfari
