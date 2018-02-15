%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       
%       UoYClosedExam.cls
%
%       A LaTeX Class for preparing University of York Examinations
%
%       Jeremy Jacob
%       <Jeremy.Jacob@c.york.ac.uk>
%
%       23 December 1997         Counting of marks alloted added
%       12 February 1998         Minor mod to presentation of counted marks
%       10 February 1999         Change to front page
%       19 August   2005         Changed base class from article to scrartcl
%                                Changed `Model answers' to `Marking Notes'
%       2006 Feb 10              Made changes to obey latest diktat
%                                (sans serif font, ragged-right)
%       2011 Feb 24              Small modifications to bring up to
%                                date for scrartcl
%       2011 Mar 18              Added `Page n of m'; fixed margins
%       2013 Apr 11              Cleaned up default font being sf
%       2016 Apr 05              Removed all logos
%       2016 Apr 05              Added watermark if answers are produced
%       2017 Mar 27              Updated for new rules about resits
%       2017 Apr 07              Changed default fontsize to Koma-Script default
%       2017 Dec 01-05           Major updates for new front page, etc.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The header code...
\def\UoYe@file@name{UoYClosedExam}
\def\UoYe@file@date{2017/12/01}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{\UoYe@file@name}[\UoYe@file@date\ Jeremy Jacob, Computer Science]
\newif\ifanswers
\newenvironment{answer}{}{}     % fiddle to allow redefinition...
% for answers
\newbox\theanswers
\DeclareOption{noanswers}{%
  \answersfalse%
  \long\def\UoYe@answer#1{}%
  \renewenvironment{answer}%
  {\global\setbox\theanswers=%
    \vbox\bgroup}%
  {\egroup}%
}
\DeclareOption{answers}{%
  \answerstrue%
  \long\def\UoYe@answer#1{%
    \global\setbox\theanswers%
    =\vbox{\unvbox\theanswers{\parindent=0pt#1}}}%
  \renewenvironment{answer}%
  {\global\setbox\theanswers=%
    \vbox\bgroup\unvbox\theanswers%
    \bgroup\parindent=0pt}%
  {\egroup\egroup}%
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ExecuteOptions{noanswers,fontsize=12pt}
\ProcessOptions
\LoadClass[twoside=true]{scrartcl}
\RequirePackage{UoYstyle}
\RequirePackage{ifthen}
\RequirePackage{geometry}
\RequirePackage{draftwatermark}
\definecolor{watermarkcolor}{cmyk}{0.05,0.1,0.01,0}
\SetWatermarkColor{watermarkcolor}
\ifanswers\SetWatermarkText{ANSWERS}\else\SetWatermarkText{}\fi

% end of header...

\let\UoYe@parbreak=\par         % fiddle to include \par in macros...

% a macro to create and intialise declarations.
% \#1 is the name of the declaration, \UoYe@#1 is the internal name
% If these are not set it gives a sensible(-ish) error message
\def\UoYe@var#1{%
  \expandafter\def\csname#1\endcsname##1{%
    \expandafter\def\csname UoYe@#1\endcsname{##1}}%
  \csname#1\endcsname{%
     \ClassError{UoYClosedExam}%
                {Missing `#1' declaration!}%
                {Insert a `#1' declaration and restart!}%
  }%
}

% To record obsolete declaration.

\def\UoYe@obsoletevar#1{%
  \expandafter\def\csname#1\endcsname##1{%
        \ClassWarning{UoYClosedExam}{The declaration `#1' is obsolete.}
        }%
}

% Some compulsory declarations

\UoYe@var{Examyear}
\UoYe@var{Maccode}
\UoYe@var{Title}

% Macros for degree lists
\def\UoYe@DegreeList{}
\newif\ifUoYe@lastdeg%
\UoYe@lastdegfalse%
\def\UoYe@DegreeList{}
\newcommand*{\Degrees}[1]{\edef\UoYe@DegreeList{\UoYe@DegreeList{}#1}}
\def\UoYe@Deg#1{% macro to declare an award
  \expandafter\def\csname #1\endcsname{%
    \ifx\UoYe@DegreeList\empty%
    \Degrees{#1}%
  \else%
    \ifUoYe@lastdeg%
      \Degrees{\ and #1}%
    \else%
      \Degrees{, #1}%
    \fi
  \fi}%
}%
\def\UoYe@Degrees{
  \ifx\UoYe@DegreeList\empty%
    \ClassError{UoYClosedExam}%
               {Missing Degree(s) declaration(s).}%
               {Enter at least one Degree declaration and restart!}%
  \else%
    \UoYe@DegreeList%
  \fi%
}

\UoYe@Deg{BSc}
\UoYe@Deg{BEng}
\UoYe@Deg{MEng}
\UoYe@Deg{MSc}
%\UoYe@Deg{DEng}
\UoYe@Deg{MMath}
\newcommand*{\AND}{\UoYe@lastdegtrue}

% Macros for durations
\UoYe@var{Duration}
\newcommand*{\OneHour}{\Duration{ONE~hour}}
\newcommand*{\OneHourHalf}{\Duration{ONE~hour and THIRTY~minutes}}
\newcommand*{\TwoHour}{\Duration{TWO~hours}}
\newcommand*{\TwoHourHalf}{\Duration{TWO~hours and THIRTY~minutes}}
\newcommand*{\ThreeHour}{\Duration{THREE~hours}}

% Macros for supplies.
% These are split into two: optional for calculator, graph paper, etc
% and at most one of booklet type.

\def\UoYe@SuppliesList{}
\newcommand*{\Supplies}[1]{%
  \edef\UoYe@SuppliesList{\UoYe@SuppliesList{}#1\par}}
\newcommand*{\Calculator}{\Supplies{Calculator}}
\newcommand*{\GraphPaper}{\Supplies{Graph paper}}
\newcommand*{\ScrapPaper}{\Supplies{Scrap paper}}

\UoYe@var{Booklet}
\newcommand*{\GreenBooklet}{\Booklet{One Green Booklet}} % large
\newcommand*{\BluePerQ}{\Booklet{One Blue Booklet per question}}
\newcommand*{\BluePerS}{\Booklet{One Blue Booklet per section}}

% A non-standard compulsory declaration
\long\def\Rubric#1{\def\UoYe@Rubric{#1}}
\Rubric{%
  \ClassError{UoYClosedExam}%
             {Missing `Rubric' declaration!}%
             {Insert the `Rubric' declaration and restart!}%
}

% macros for resit papers
\newif\ifUoYe@resitpaper
\UoYe@resitpaperfalse
\newcommand*{\Resit}{\UoYe@resitpapertrue}

% macros for secure papers
\newif\ifUoYe@securepaper
\UoYe@securepaperfalse
\newcommand*{\Secure}{\UoYe@securepapertrue}

% a non-compulsory declaration
\newif\ifsectioned
\def\Sectioned{\sectionedtrue}
\sectionedfalse

% now obsolete, once compulsory, declarations.

\UoYe@obsoletevar{Part}

\newcommand*{\lastpage}{\pageref{lastpage}}

% a command and associated gubbins for numbering sections:

\newcounter{UoYe@sectionno}
\def\theUoYe@sectionno{\Alph{UoYe@sectionno}}
\long\def\section#1#2{%
        \newpage%
        \refstepcounter{UoYe@sectionno}%
        \UoYe@answer{%
                \penalty -10000%
                \hspace*{-\UoYe@numwidth}%
                \hbox{\bfseries\large %
                        Answers for Section~\theUoYe@sectionno: #1}\par}%
        \addtocontents{toc}{\theUoYe@sectionno: #1\protect\\}%
        \hspace*{-\UoYe@numwidth}%
        {\large Section~\theUoYe@sectionno: #1}%
        \par#2\par\UoYe@interQskip%
}

\def\SeparateAnswerBook{You must answer this section in a %
                        \textbf{separate} booklet.}

\newcommand{\UoYe@EndMarker}{\textbf{\large End of examination paper}}%{\rule{0.66\textwidth}{2ex}}

% Environments for questions
%
% The UoYe@question environment is a primitive for internal use only.
% Environments ``question'' and ``miniq'' are for the user; they only
% differ in the way parts are numbered.  ``miniq'' is intended for
% ``lots of short answer questions'', and ``question'' for a long
% question, with, possibly, several parts.
% These commands and environments take a parameter which is the number
% of marks, as appropriate.  miniq also takes a parameter stating how
% many questions to answer

\newcounter{UoYe@questionno}
\newcounter{UoYe@partno}[UoYe@questionno]
\newlength{\UoYe@numwidth}
\settowidth{\UoYe@numwidth}{(viii)~}
\newlength{\UoYe@qpwidth}
\setlength{\UoYe@qpwidth}{\textwidth}
\addtolength{\UoYe@qpwidth}{-\UoYe@numwidth}

\newcounter{UoYe@marksavailable}

\def\UoYe@marktext#1{#1~mark\ifthenelse{\equal{#1}{1}}{}{s}}

\def\UoYe@qorphead#1#2#3#4#5{%
        \vrule width 0pt height 0pt depth 0pt%  To force horizontal mode
        \hspace*{-\UoYe@numwidth}%
        \hbox to \UoYe@numwidth{#1\hskip 0pt plus 1fil}%
        \ifthenelse{\equal{}{#3}}{}%
                {\hbox spread 1.5em{%
                        \hbox{#2\UoYe@marktext{#3}#4}\hskip 0pt plus 1fil}}%
        \penalty #5%
}
\def\UoYe@interQskip{\vskip 10ex plus 3ex minus 1ex}

\newenvironment{UoYe@question}[3]{%
        \pagestyle{UoYe@withinqs}%
        \setcounter{UoYe@marksavailable}{#1}
        \def\theUoYe@partno{(#2{UoYe@partno})}%
        \refstepcounter{UoYe@questionno}%
        \vbox{\UoYe@qorphead{\theUoYe@questionno}({#1}){10000}%
                #3\nobreak}%
        \UoYe@answer{%
                \newpage%
                \hspace*{-\UoYe@numwidth}%
                {\bfseries Question~\theUoYe@questionno~(\UoYe@marktext{#1})}%
                \hskip 2em plus 1em minus 1pt #3}%
        }%
        {%
        \par\pagestyle{UoYe@betweenqs}%
        \UoYe@panda{\UoYe@interQskip}%
        \typeout{}%
        \ClassWarning{UoYClosedExam}{Question \theUoYe@questionno: Mark excess of \arabic{UoYe@marksavailable}}%
        \typeout{}
        }

\newenvironment{question}[2]%
        {\begin{UoYe@question}{#1}{\roman}{#2}}%
        {\end{UoYe@question}}

\newenvironment{miniq}[2]%
        {\begin{UoYe@question}{#1}{\alph}%
                {Give brief answers to not more than \textbf{#2} of %
                the following questions.%
%Each is worth \UoYe@marktext{#3}.% commented out for DGB
                }%
        }%
        {\end{UoYe@question}}   

\renewcommand*{\part}[1][]{%
        \par%
        \refstepcounter{UoYe@partno}%
        \addtocounter{UoYe@marksavailable}{-#1}%
        \UoYe@qorphead{\theUoYe@partno}[{#1}]{8000}%
        \UoYe@answer{%
                \hspace*{-\UoYe@numwidth}%
                {\bfseries%
                 Part~\theUoYe@partno%
                 \ifthenelse{0=#1}{}{~[\UoYe@marktext{#1}]}%
                }}%
}

% for miniparts
\newcounter{UoYe@optpartno}[UoYe@partno]
\def\theUoYe@optpartno{(\alph{UoYe@optpartno})}
\newenvironment{options}%
        {\begin{list}{\theUoYe@optpartno}{\usecounter{UoYe@optpartno}}}%
        {\end{list}}
\def\opt{%
        \item\hspace{1em}%
        \UoYe@answer{%
                \hspace*{-\UoYe@numwidth}%
                \textbf{Option~\theUoYe@optpartno}%
        }%
}

\newcounter{UoYe@seqpartno}[UoYe@partno]
\def\theUoYe@seqpartno{(\alph{UoYe@seqpartno})}
\newenvironment{sequence}%
        {\begin{list}{\theUoYe@seqpartno}{\usecounter{UoYe@seqpartno}}}%
        {\end{list}}
\def\bit#1{%
        \item\relax[\UoYe@marktext{#1}]\hspace{1em}%
        \UoYe@answer{%
                \hspace*{-\UoYe@numwidth}%
                \textbf{Sub-part~\theUoYe@seqpartno~[\UoYe@marktext{#1}]}%
        }%
}

% Get page styles right.  MAC code & optional "RESIT" at top RH corner
% of each page.
% Page number at bottom.  Either ``turn over'' or ``continued'' at
% bottm RH corner depending on whether it is in the middle of a
% question or not.

% In the main part of the paper
% headings only depend on evenness or oddness of page
\def\@oddhead{%
  \hskip 0pt plus 1fil minus 0pt%
  \ifUoYe@resitpaper%
    \begin{tabular}{c}\UoYe@Maccode\\RESIT\end{tabular}%
  \else%
    \UoYe@Maccode%
  \fi%
}
\def\@evenhead{\hskip 0pt plus 1fil minus 0pt}

% and even feet are always the same                     
\def\@evenfoot{\hskip 0pt plus 1fil Page~\thepage~of~\lastpage\hskip 0pt plus 1fil\relax}

% but odd feet depend on many other things...
\def\UoYe@oddfoot#1#2#3{%
        \expandafter\def\csname ps@UoYe@#1\endcsname{%
                \def\@oddfoot{\hbox to \textwidth{\hskip 0pt plus 1fil%
                                #2%
                                \hskip 0pt plus 1fil}%
                                \kern -\textwidth%
                                \hbox to \textwidth{\hskip 0pt plus 1fil #3}%
                                }%
        }%
}
%\UoYe@oddfoot{firstpage}{}{}
\UoYe@oddfoot{lastpage}{Page~\thepage~of~\lastpage}{}
\UoYe@oddfoot{withinqs}{Page~\thepage~of~\lastpage}{Continued.}
\UoYe@oddfoot{betweenqs}{Page~\thepage~of~\lastpage}{Turn over.}

% Occasionally TeX gets it wrong...if it cuts the scroll after reading
% the end of Question.  So we provide declarations to fix it

\def\TurnOver{\thispagestyle{UoYe@betweenqs}}
\def\Continued{\thispagestyle{UoYe@withinqs}}

\def\ps@UoYe@answerpages{%
        \def\@evenhead{Marking Notes\hskip 0pt plus 1fil}%
        % odd heads do not change
        \def\@evenfoot{\hskip 0pt plus 1fil\thepage\hskip 0pt plus 1fil}%
        \def\@oddfoot{\hskip 0pt plus 1fil\thepage\hskip 0pt plus 1fil}%
}

% Extra definitions for answers

\let\ans=\UoYe@answer%
\def\UoYe@panda#1{#1\UoYe@answer{#1}}%


% Set TeX & LaTeX style parameters
\renewcommand{\familydefault}{\sfdefault}
\parindent=0pt
\parskip=2ex plus 0.1pt
\typearea[current]{calc}
\pagestyle{UoYe@betweenqs}

% at begin and end of document...
\AtBeginDocument{%
  \raggedright%
  \TurnOver%\thispagestyle{UoYe@firstpage}%
  \begin{center}%
    \UoYblack[12ex]\\[2ex]%
    {\bfseries \UoYe@Degrees~Degree Examinations~\UoYe@Examyear}\\[4ex]%
    {\Large\mdseries\scshape Department of Computer Science}\\[4ex]%
    {\LARGE\bfseries\UoYe@Title}\\[4ex]%
    \ifUoYe@securepaper{\Large\mdseries\scshape Secure~Paper}\\[4ex]\fi
    Time allowed: \textbf{\UoYe@Duration}\\[4ex]%
  \end{center}%
  \paragraph*{Marking scheme}%
  \begin{quotation}
    \ifsectioned%
      This paper consists of the following Sections:\\%
      \@starttoc{toc}%
      Answer each Section in a \textbf{separate} %
      answer booklet.\\[4ex]%%
    \fi%

    \UoYe@Rubric%
  \end{quotation}
  \paragraph*{Supplies}%
  \begin{quotation}
    \UoYe@Booklet%

    \UoYe@SuppliesList%
  \end{quotation}
  \sffamily%
  \newpage%
  \UoYe@resitpaperfalse%
}
\AtEndDocument{%
  \hspace{5em}
  \begin{center}\UoYe@EndMarker\end{center}%
  \label{lastpage}
  \thispagestyle{UoYe@lastpage}%
  \ifanswers%
    \cleardoublepage%
    \clubpenalty=1000%
    \pagestyle{UoYe@answerpages}%
    \begin{center}%
      {\scshape University of York}\\[1ex]%
      {\Large\mdseries\scshape Department of Computer Science}\\[4ex]%
      Degree~Examinations~\UoYe@Examyear\\[2ex]%
      {\bfseries\UoYe@Title}\\[7ex]%
      {\Large Marking Notes}%
    \end{center}%
    \vskip 6ex plus 2ex minus 1ex%
    \unvbox\theanswers%
    \vskip 0pt plus 1fill%
    \begin{center}\UoYe@EndMarker\end{center}%
  \fi%
}

\geometry{inner=3.5cm,outer=3cm}

% end of file
