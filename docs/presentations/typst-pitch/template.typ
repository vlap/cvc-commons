// Blueprint / BSC Theme — Clean Technical & Scientific Design
// Tailored for BSC (Barcelona Supercomputing Center) with official brand blue #213970.
// Touying 0.7.4 compatible.

#import "@preview/touying:0.7.4": *


// ═══ Color Palette (BSC Brand) ═══

#let palette = (
  bg: rgb("#FFFFFF"),
  ink: rgb("#0F172A"),
  blue: rgb("#213970"), // BSC Official Navy Blue
  gray: rgb("#64748B"),
  red: rgb("#D92D20"),
  wash: rgb("#F8FAFC"),
  blue-light: rgb("#213970").transparentize(85%),
  blue-faint: rgb("#213970").transparentize(94%),
  ink-muted: rgb("#0F172A").transparentize(60%),
  grid-line: rgb("#213970").transparentize(92%),
  construction: rgb("#213970").transparentize(90%),
)


// ═══ SVG Definitions ═══

// Clean minimal top rule for slides
#let _blueprint-grid-svg = ```
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 960 540" preserveAspectRatio="none">
</svg>```.text

// Corner registration marks (minimal)
#let _registration-marks-svg = ```
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 960 540" preserveAspectRatio="none">
</svg>```.text

// Dimension arrow (horizontal)
#let _dimension-arrow-svg = ```
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 20" preserveAspectRatio="none">
  <line x1="8" y1="10" x2="192" y2="10" stroke="#213970" stroke-width="0.8" opacity="0.6"/>
  <polygon points="5,10 12,7 12,13" fill="#213970" opacity="0.6"/>
  <polygon points="195,10 188,7 188,13" fill="#213970" opacity="0.6"/>
  <line x1="5" y1="3" x2="5" y2="17" stroke="#213970" stroke-width="0.6" opacity="0.4"/>
  <line x1="195" y1="3" x2="195" y2="17" stroke="#213970" stroke-width="0.6" opacity="0.4"/>
</svg>```.text

// Clean construction lines (empty to remove distracting noise)
#let _construction-lines-svg = ```
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 960 540" preserveAspectRatio="none">
</svg>```.text

// Section divider
#let _section-divider-svg = ```
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 24">
  <line x1="0" y1="12" x2="170" y2="12" stroke="#213970" stroke-width="1" opacity="0.6"/>
  <line x1="230" y1="12" x2="400" y2="12" stroke="#213970" stroke-width="1" opacity="0.6"/>
  <rect x="175" y="4" width="50" height="16" fill="none" stroke="#213970" stroke-width="1" opacity="0.5" rx="2"/>
  <circle cx="200" cy="12" r="3" fill="#213970" opacity="0.4"/>
</svg>```.text


// ═══ Helper Components ═══

#let blueprint-grid() = {
  // Clean background: no noisy grid
}

#let registration-marks() = {}
#let construction-lines() = {}

#let dimension-arrow(width: 100%) = {
  box(width: width, height: 10pt, image(bytes(_dimension-arrow-svg), width: 100%, height: 100%))
}

#let section-divider(width: 60%) = {
  box(width: width, height: 14pt, image(bytes(_section-divider-svg), width: 100%, height: 100%))
}

#let grid-ref(label) = {
  box(
    inset: (x: 5pt, y: 2pt),
    stroke: 0.5pt + palette.blue.transparentize(50%),
    radius: 3pt,
    fill: palette.wash,
    text(size: 0.6em, fill: palette.blue, weight: "bold", font: "DejaVu Sans Mono", label)
  )
}

#let blueprint-tag(body, fill: palette.wash, stroke: palette.blue) = {
  box(
    inset: (x: 8pt, y: 4pt),
    stroke: 0.5pt + stroke.transparentize(40%),
    fill: fill,
    radius: 3pt,
    text(size: 0.7em, weight: "bold", fill: stroke, body)
  )
}


// ═══ Content Components ═══

/// concept-card: Clean technical specification card
#let concept-card(title, body, zone: none) = {
  block(
    width: 100%,
    stroke: (left: 3pt + palette.blue, rest: 0.5pt + rgb("#E2E8F0")),
    fill: palette.wash,
    radius: (right: 4pt),
    inset: (x: 14pt, y: 12pt),
    [
      #grid(
        columns: (1fr, auto),
        align: (left + horizon, right + horizon),
        text(weight: "bold", fill: palette.blue, size: 0.95em, title),
        if zone != none { grid-ref(zone) },
      )
      #v(0.35em)
      #text(fill: palette.ink, size: 0.85em, body)
    ]
  )
}

/// spec-card: Card with header accent bar
#let spec-card(title, body, rev: none) = {
  block(
    width: 100%,
    stroke: 0.5pt + rgb("#CBD5E1"),
    radius: 4pt,
    clip: true,
    [
      #block(
        width: 100%,
        fill: palette.blue,
        inset: (x: 12pt, y: 6pt),
        grid(
          columns: (1fr, auto),
          align: (left + horizon, right + horizon),
          text(weight: "bold", fill: white, size: 0.85em, title),
          if rev != none {
            text(fill: white.transparentize(20%), size: 0.65em, font: "DejaVu Sans Mono", weight: "bold", [Rev. #rev])
          }
        )
      )
      #block(
        fill: palette.wash,
        width: 100%,
        inset: (x: 12pt, y: 10pt),
        text(fill: palette.ink, size: 0.85em, body)
      )
    ]
  )
}

/// stat-card: Large metric display
#let stat-card(value, caption, unit: none) = {
  block(
    width: 100%,
    stroke: 0.5pt + rgb("#E2E8F0"),
    fill: palette.wash,
    radius: 4pt,
    inset: (x: 10pt, y: 10pt),
    [
      #text(size: 1.8em, weight: "bold", fill: palette.blue, value)
      #if unit != none {
        h(2pt)
        text(size: 0.8em, fill: palette.gray, unit)
      }
      #v(0.2em)
      #line(length: 100%, stroke: 0.5pt + rgb("#CBD5E1"))
      #v(0.2em)
      #text(size: 0.7em, fill: palette.gray, weight: "semibold", upper(caption))
    ]
  )
}

/// insight-box: Clean highlighted callout box
#let insight-box(body) = {
  block(
    width: 100%,
    fill: palette.wash,
    stroke: 1pt + palette.blue,
    radius: 4pt,
    inset: (x: 14pt, y: 9pt),
    text(fill: palette.ink, size: 0.85em, body)
  )
}

/// callout-box: Alert box
#let callout-box(title, body, accent: palette.blue) = {
  block(
    width: 100%,
    fill: accent.transparentize(94%),
    stroke: (left: 3pt + accent, rest: 0.5pt + rgb("#E2E8F0")),
    radius: (right: 4pt),
    inset: (x: 14pt, y: 10pt),
    [
      #text(weight: "bold", fill: accent, size: 0.9em, title)
      #v(0.25em)
      #text(fill: palette.ink, size: 0.85em, body)
    ]
  )
}

/// dimension-box: Callout with dimension line
#let dimension-box(title, body) = {
  block(
    width: 100%,
    stroke: 0.5pt + rgb("#E2E8F0"),
    fill: palette.wash,
    radius: 4pt,
    inset: (x: 14pt, y: 10pt),
    [
      #dimension-arrow(width: 100%)
      #v(0.3em)
      #text(weight: "bold", fill: palette.red, size: 0.85em, title)
      #v(0.25em)
      #text(fill: palette.ink, size: 0.85em, body)
    ]
  )
}

/// schematic-card: Neutral technical card
#let schematic-card(title, body) = {
  concept-card(title, body)
}

/// quote-card: Elegant quote card
#let quote-card(body, attribution: none) = {
  block(
    width: 100%,
    fill: palette.wash,
    stroke: (left: 3.5pt + palette.blue, rest: 0.5pt + rgb("#E2E8F0")),
    radius: (right: 4pt),
    inset: (x: 16pt, y: 12pt),
    [
      #text(style: "italic", size: 0.92em, fill: palette.ink, body)
      #if attribution != none {
        v(0.4em)
        align(right)[
          #text(size: 0.72em, fill: palette.gray, font: "DejaVu Sans Mono", [\u{2014} #attribution])
        ]
      }
    ]
  )
}

#let title-frame() = {}
#let blueprint-divider() = {
  line(length: 100%, stroke: 0.5pt + rgb("#E2E8F0"))
}


// ═══ Background Atmosphere ═══

#let _content-atmosphere() = {
  // Clean white canvas
}


// ═══ Slide Functions ═══

/// slide: Content slide with BSC blue header and official BSC logo
#let slide(title: auto, align: auto, ..args) = touying-slide-wrapper(self => {
  if title != auto {
    self.store.title = title
  }
  if align != auto {
    self.store.align = align
  }
  let header(self) = {
    set std.align(top)
    show: block.with(width: 100%, inset: (x: 2.4em, top: 1.6em, bottom: 0.4em))
    grid(
      columns: (1fr, auto),
      align: (left + horizon, right + horizon),
      {
        set text(fill: palette.blue, size: 1.3em, weight: "bold")
        if self.store.title != none {
          utils.call-or-display(self, self.store.title)
        } else {
          utils.display-current-heading(level: 2)
        }
      },
      {
        image("assets/bsc-blue.svg", height: 18pt)
      }
    )
    v(0.35em)
    line(length: 100%, stroke: 0.75pt + rgb("#CBD5E1"))
  }
  let footer(self) = {
    set std.align(bottom)
    show: block.with(width: 100%, inset: (x: 2.4em, top: 0.4em, bottom: 1.4em))
    set text(fill: palette.gray, size: 0.65em)
    grid(
      columns: (1fr, 1fr),
      {
        if self.store.footer != none {
          utils.call-or-display(self, self.store.footer)
        }
      },
      {
        set std.align(right)
        context { text(fill: palette.gray, size: 0.9em, font: "DejaVu Sans Mono")[#utils.slide-counter.display() / #utils.last-slide-number] }
      }
    )
  }
  let setting(body) = {
    show: std.align.with(self.store.align)
    _content-atmosphere()
    body
  }
  self = utils.merge-dicts(
    self,
    config-page(
      fill: palette.bg,
      header: header,
      footer: footer,
      header-ascent: 0%,
      footer-descent: 0%,
      margin: (x: 2.4em, top: 4.8em, bottom: 2.8em),
    ),
  )
  touying-slide(self: self, setting: setting, ..args)
})

/// title-slide: Full professional BSC presentation cover
#let title-slide(..args) = touying-slide-wrapper(self => {
  let info = self.info + args.named()
  let body = {
    place(top + left, block(width: 100%, height: 100%, fill: palette.bg))
    place(top + left, rect(width: 100%, height: 5pt, fill: palette.blue))
    
    set std.align(center + horizon)
    pad(x: 3em)[
      #v(0.8em)
      #image("assets/bsc-blue.svg", width: 160pt)
      #v(1.4em)
      #text(size: 2.3em, weight: "bold", fill: palette.blue, info.title)
      #v(0.5em)
      #if info.subtitle != none {
        text(size: 1.05em, fill: palette.gray, weight: "medium", info.subtitle)
      }
      #v(1.2em)
      #line(length: 140pt, stroke: 1.5pt + palette.blue)
      #v(1.2em)
      #text(size: 0.95em, weight: "semibold", fill: palette.ink, info.author)
      #v(0.4em)
      #text(size: 0.75em, fill: palette.gray)[#datetime.today().display("[year]-[month]-[day]")]
    ]
  }
  self = utils.merge-dicts(
    self,
    config-page(header: none, footer: none, margin: 0pt),
  )
  touying-slide(self: self, body)
})

/// new-section-slide: Section break slide
#let new-section-slide(self: none, body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(header: none, footer: none, margin: 0pt),
  )
  let main-body = {
    place(top + left, block(width: 100%, height: 100%, fill: palette.bg))
    place(top + left, rect(width: 100%, height: 5pt, fill: palette.blue))
    set std.align(center + horizon)
    pad(x: 4em)[
      #image("assets/bsc-blue.svg", width: 100pt)
      #v(1em)
      #text(size: 2.2em, weight: "bold", fill: palette.blue)[
        #utils.display-current-heading(level: 1, numbered: false)
      ]
    ]
  }
  touying-slide(self: self, main-body)
})

/// focus-slide: High contrast emphasis — BSC blue background with white text
#let focus-slide(body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(
      fill: palette.blue,
      margin: 2em,
      header: none,
      footer: none,
    ),
  )
  let main-body = {
    set std.align(center + horizon)
    pad(x: 3em)[
      #image("assets/bsc-white.svg", width: 130pt)
      #v(1.4em)
      #set text(fill: white, size: 1.6em, weight: "bold")
      #set par(leading: 0.6em)
      #body
    ]
  }
  touying-slide(self: self, main-body)
})

/// ending-slide: Clean BSC close-out frame
#let ending-slide(body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(header: none, footer: none, margin: 0pt),
  )
  let main-body = {
    place(top + left, block(width: 100%, height: 100%, fill: palette.bg))
    place(top + left, rect(width: 100%, height: 5pt, fill: palette.blue))
    set std.align(center + horizon)
    pad(x: 4em)[
      #image("assets/bsc-blue.svg", width: 150pt)
      #v(1.2em)
      #text(size: 2.2em, weight: "bold", fill: palette.blue, body)
      #v(0.6em)
      #text(size: 1.0em, fill: palette.gray)[Almost-Zero-Cost Maintenance & Documentation for Climate Workflows]
      #v(1.0em)
      #line(length: 140pt, stroke: 1.5pt + palette.blue)
      #v(0.8em)
      #text(size: 0.85em, font: "DejaVu Sans Mono", fill: palette.blue)[gitlab.earth.bsc.es/cvc/cvc-shared-tools.git]
      #v(1.0em)
      #text(size: 0.95em, weight: "bold", fill: palette.ink)[Questions & Discussion]
    ]
  }
  touying-slide(self: self, main-body)
})


// ═══ Theme Entry Point ═══

#let blueprint-theme(
  aspect-ratio: "16-9",
  align: horizon,
  footer: none,
  ..args,
  body,
) = {
  set text(size: 14pt, fill: palette.ink)
  set par(leading: 0.6em)
  show raw: set text(font: "DejaVu Sans Mono")
  set heading(numbering: (..args) => none)

  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      header-ascent: 0%,
      footer-descent: 0%,
      margin: (x: 2.4em, top: 4.8em, bottom: 2.8em),
      fill: palette.bg,
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
    ),
    config-methods(alert: utils.alert-with-primary-color),
    config-colors(
      primary: palette.blue,
      neutral-lightest: palette.bg,
      neutral-darkest: palette.ink,
    ),
    config-store(
      title: none,
      align: align,
      footer: footer,
    ),
    ..args,
  )

  body
}
