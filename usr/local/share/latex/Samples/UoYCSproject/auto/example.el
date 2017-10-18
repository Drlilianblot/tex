(TeX-add-style-hook "example"
 (lambda ()
    (LaTeX-add-bibliographies
     "file1"
     "file2"
     "references")
    (LaTeX-add-environments
     '("mq" 1)
     "protocol"
     "PROTOCOL"
     "prot")
    (LaTeX-add-labels
     "sec:start"
     "cha:Introduction"
     "sec:whatislatex"
     "sec:advantagesoftex"
     "sec:advantagesoflatex"
     "sec:advantagesofprogrammable"
     "cha:usefulrefs"
     "sec:books"
     "sec:papers"
     "sec:webresources"
     "cha:editprocess"
     "sec:middle"
     "cha:anatomy"
     "cha:dand"
     "sec:declarations"
     "sec:individualdeclarations"
     "sec:packages"
     "sec:definitions"
     "sec:commands"
     "sec:environments"
     "cha:body"
     "sec:bodyanatomy"
     "sec:splitting"
     "sec:textelements"
     "sec:modes"
     "fig:textasmath"
     "sec:simpleparas"
     "sec:characters"
     "sec:reserved"
     "tab:forbidden"
     "sec:ellipses"
     "sec:dashes"
     "tab:dash"
     "sec:spaces"
     "sec:cahrattributes"
     "tab:fontstyle"
     "tab:fontsize"
     "sec:emphasis"
     "sec:lists"
     "sec:quotations"
     "sec:bibliographies"
     "sec:floats"
     "sec:tabular"
     "sec:theorems"
     "thm:otwayrees"
     "sec:mathematics"
     "fig:mathematics"
     "sec:crossrefs"
     "sec:brief"
     "sec:pictures"
     "sec:end"
     "cha:UoYCSproject"
     "sec:uoycsp:ante"
     "sec:uoycsp:decs"
     "tab:UoYCSpdeclarations"
     "sec:uoycsp:diy"
     "sec:nonstandard"
     "sec:citations"
     "sec:labels"
     "cha:usefulpackages"
     "sec:presentationpackages"
     "cha:gotchas"
     "sec:BibTeXgotchas"
     "cha:deptfac"
     "sec:GNU/Linux"
     "sec:MSW"
     "cha:quoteex")
    (TeX-add-symbols
     '("tc" 1)
     '("fs" 1)
     '("hding" 1)
     '("enc" 2)
     '("msg" 3)
     '("wwwr" 2)
     "uoy"
     "cl"
     "phrase"
     "beware"
     "tmp")
    (TeX-run-style-hooks
     "listings"
     "name"
     "package"
     "class name10"
     "class name"
     "class"
     "options"
     "latex2e"
     "UoYCSproject10"
     "UoYCSproject"
     "authoryearcitations"
     "<file>"
     "joyce")))
