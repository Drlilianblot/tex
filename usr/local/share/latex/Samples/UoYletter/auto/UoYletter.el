(TeX-add-style-hook "UoYletter"
 (lambda ()
    (LaTeX-add-environments
     "UoYl")
    (TeX-add-symbols
     "headcolour"
     "date"
     "HesWest"
     "HesEast"
     "national"
     "international"
     "grouptelext"
     "groupfaxext"
     "grouphead"
     "groupheadtitle"
     "namequal"
     "jobtitle"
     "extension"
     "loginid"
     "emaildomain"
     "website"
     "yourref"
     "ourref"
     "groupname"
     "department"
     "ComputerScience"
     "raisebody"
     "about"
     "re")
    (TeX-run-style-hooks
     "UoYstyle"
     "letter10"
     "letter"
     "a4paper")))

