% miuaproc.cls:
% LaTeX document class for MIUA Proceedings
% Written by Nick Efford <nde@scs.leeds.ac.uk>

\def\fileversion{v1.00}
\def\filedate{1998/03/19}
\def\fileauthor{NDE}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{miuaproc}[\filedate\space\fileversion\space
 MIUA Proceedings (\fileauthor)]
\RequirePackage{cite}
\LoadClass{article}

% Set up page layout

\newlength{\@abstractwidth}
\setlength{\topmargin}{0mm}
\setlength{\headheight}{0mm}
\setlength{\headsep}{0mm}
\setlength{\footskip}{0mm}
\setlength{\oddsidemargin}{0mm}
\setlength{\textwidth}{160mm}
\setlength{\textheight}{247mm}
\setlength{\@abstractwidth}{140mm}

\setlength{\parskip}{\baselineskip}
\setlength{\parindent}{0pt}
\pagestyle{empty}

% Use PostScript fonts

% These _should_ be available, if you have a recent, properly-installed
% LaTeX.  In the event of problems, check with your local LaTeX maintainer.
% If necessary, the font files required can be obtained from any CTAN site,
% e.g. ftp://ftp.tex.ac.uk/tex-archive/fonts/psfonts/lw35nfss.zip

% PostScript fonts are preferred, but if you really can't manage to use
% them, the Computer Modern fonts are an acceptable substitute.  These are
% enabled by using % (percent) to comment out the three lines below.

\renewcommand{\rmdefault}{ptm}  % Times Roman
\renewcommand{\sfdefault}{phv}  % Helvetica
\renewcommand{\ttdefault}{pcr}  % Courier

% Font selection for title, abstract, principal headings, subheadings

\def\@titlefont{\fontsize{16}{19.2}\fontseries{b}\selectfont}
\def\@abstractfont{\fontsize{9}{10.8}\selectfont}
\def\@mainheadfont{\fontsize{12}{14.4}\fontseries{b}\selectfont}
\def\@subheadfont{\fontsize{11}{13.2}\fontseries{b}\selectfont}
\def\@reffont{\fontsize{9}{10.8}\selectfont}

% Title and authors

\newcommand{\corr}[1]{\thanks{#1}}
\newcommand{\aff}[1]{\raisebox{0.8ex}[0pt][0pt]{\footnotesize\textrm{#1}}}

\renewcommand{\maketitle}{\par
  \begingroup
    \renewcommand{\thefootnote}{\fnsymbol{footnote}}%
    \def\@makefnmark{\hbox to\z@{$\m@th^{\@thefnmark}$\hss}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hbox to1.8em{\hss$\m@th^{\@thefnmark}$}##1}%
    \newpage
    \global\@topnum\z@   % Prevents figures from going at top of page.
    \@maketitle
    \@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \let\thanks\relax
  \let\maketitle\relax\let\@maketitle\relax
  \gdef\@thanks{}\gdef\@author{}\gdef\@title{}}

\def\@maketitle{%
  \newpage
  \null
  \vspace*{-36pt}% move title to top of page
  \begin{center}%
    {\@titlefont \@title \par}%
    \vskip 0.5ex%
    \begin{tabular}[t]{c}%
      \@author
    \end{tabular}%
  \end{center}
  \par
  \vskip -2ex}

% Abstract

\renewenvironment{abstract}{%
  \@abstractfont\begin{center}\begin{minipage}{\@abstractwidth}
  {\bfseries \abstractname.}}%
 {\end{minipage}\end{center}}

% Headings

\renewcommand{\section}{\@startsection
  {section}{1}{0pt}{-1pt}{1pt}% 
  {\normalfont\@mainheadfont\raggedright}}

\renewcommand{\subsection}{\@startsection
  {subsection}{2}{0pt}{-1pt}{1pt}%
  {\normalfont\@subheadfont\raggedright}}

\renewcommand{\subsubsection}{\@startsection
  {subsubsection}{3}{0pt}{-1pt}{1pt}%
  {\normalfont\normalsize\bfseries\raggedright}}

% Figure and table captions

\long\def\@makecaption#1#2{%
   %\vskip 10pt
   \setbox\@tempboxa\hbox{{\bfseries #1. }#2} % bold with period
   \ifdim \wd\@tempboxa >\hsize
      {\bfseries #1. }#2\par                  % bold with period
   \else
      \hbox to\hsize{\hfil\box\@tempboxa\hfil}%
   \fi}

% References

\newcommand{\miuarefs}[1]{\bibliographystyle{miuaproc}\bibliography{#1}}

\def\@biblabel#1{#1.}

\renewenvironment{thebibliography}[1]
     {\section*{\refname
        \@mkboth{\uppercase{\refname}}{\uppercase{\refname}}}%
      \@reffont
      \list{\@biblabel{\arabic{enumiv}}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand{\theenumiv}{\arabic{enumiv}}}%
      \renewcommand{\newblock}{\hskip .11em \@plus.33em \@minus.07em}%
      \setlength{\parskip}{0pt}\setlength{\itemsep}{0pt}%  squash up refs
      \sloppy\clubpenalty4000\widowpenalty4000%
      \sfcode`\.=\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}

\setlength{\bibindent}{5mm}

%%% end of miuaproc.cls


