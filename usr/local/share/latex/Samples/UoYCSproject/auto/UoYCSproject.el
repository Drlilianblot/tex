(TeX-add-style-hook "UoYCSproject"
 (lambda ()
    (TeX-add-symbols
     '("acknowledgements" 1)
     '("supervisor" 1)
     '("excludes" 1)
     '("includes" 1)
     '("wordcount" 1)
     "UoYCSP"
     "SWE"
     "SCSE"
     "MIP"
     "MIT"
     "MNC"
     "GTC")
    (TeX-run-style-hooks
     "hypcap"
     "all"
     "hyperref"
     "pdfusetitle"
     "natbib"
     "numbers"
     "sort&compress"
     "square"
     "comma"
     "ifthen"
     "fixltx2e"
     "babel"
     "british"
     "microtype"
     "courier"
     "mathpazo"
     "osf"
     "textcomp"
     "fontenc"
     "T1"
     "scrreprt10"
     "scrreprt"
     "a4paper"
     "twoside"
     "abstracton"
     "BCOR13mm")))

