(TeX-add-style-hook "RefMan"
 (lambda ()
    (LaTeX-add-bibliographies
     "References")
    (LaTeX-add-labels
     "ClOpts:Sec"
     "NewDec:Sec"
     "GrpDec:SS"
     "PerDec:SS"
     "LetDec:SS"
     "Colour:SS"
     "NewCom:Sec"
     "ExampleInput:Fig"
     "Cls:Fig"
     "ExampleInpTwo:Fig")
    (TeX-add-symbols
     '("pcmd" 2)
     '("cmd" 1)
     '("cmdsty" 1)
     "nl")
    (TeX-run-style-hooks
     "harvard"
     "UoYstyle"
     "latex2e"
     "art12"
     "article"
     "12pt"
     "a4paper")))

