# Betriebsanweisungen Generator - Project Plan

## Project Overview

A simple web application that generates legally compliant **Betriebsanweisungen** (Operating Instructions) from **Sicherheitsdatenblätter** (Safety Data Sheets).

---

## Core Problem

1. We have Safety Data Sheets (Sicherheitsdatenblätter) for our products
2. German law requires us to create Operating Instructions (Betriebsanweisungen) from this data
3. We need a shareable link to each Betriebsanweisung for easy distribution

---

## Project Structure

```
/project-root
│
├── /assets
│   └── /pictograms          # GHS hazard pictograms (fixed set)
│
├── /sicherheitsdatenblaetter
│   └── *.md                  # Source data in Markdown format
│
├── /templates
│   └── betriebsanweisung.template   # Fixed layout with colors & structure
│
└── /output
    └── /betriebsanweisungen  # Generated documents (web-viewable)
```

---

## Data Flow

```
Sicherheitsdatenblatt (.md)
         ↓
    [Template Engine]
         ↓
   Betriebsanweisung (styled, web-viewable)
         ↓
    Shareable Link
```

---

## Key Constraints

1. **Fixed Layout** — Betriebsanweisungen follow a legally defined structure
2. **Fixed Colors** — Specific color coding for different sections (e.g., blue header, red for hazards)
3. **Fixed Pictograms** — Standard GHS symbols stored in `/assets/pictograms`
4. **Dynamic Content** — Product-specific data pulled from Sicherheitsdatenblätter

---

## Feature Requirements

| # | Feature | Description |
|---|---------|-------------|
| 1 | Pictogram Storage | All GHS pictograms saved in `/assets/pictograms` |
| 2 | Source Data Format | Sicherheitsdatenblätter stored as `.md` files |
| 3 | Template System | Reusable template with fixed layout, colors, sections |
| 4 | Dynamic Generation | Parse `.md` source → populate template → output Betriebsanweisung |
| 5 | Web Display | View generated Betriebsanweisungen in browser |
| 6 | Shareable Links | Copy/paste URL for each document |

---

## Betriebsanweisung Sections (Standard Layout)

1. **Header** — Company name, product name, workplace/area
2. **Gefahrstoffbezeichnung** — Substance identification
3. **Gefahren für Mensch und Umwelt** — Hazards (with pictograms)
4. **Schutzmaßnahmen und Verhaltensregeln** — Protective measures
5. **Verhalten im Gefahrfall** — Emergency procedures
6. **Erste Hilfe** — First aid measures
7. **Sachgerechte Entsorgung** — Proper disposal
8. **Footer** — Date, signature, revision info

---

## Out of Scope (for now)

- User authentication
- Database storage
- PDF export
- Editing UI for Sicherheitsdatenblätter
- Version control / audit trail

---

## Next Steps

1. Define the exact Sicherheitsdatenblatt `.md` schema
2. Design the Betriebsanweisung template (HTML/CSS)
3. Choose minimal tech stack
4. Build MVP with one example product
