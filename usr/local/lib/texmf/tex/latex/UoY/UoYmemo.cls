%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       UoYmemo
%
%       Jeremy Jacob
%               Dept Of Computer Science, The University of York
%
%       2008 Nov 17
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       An extension to [a4paper]{article}
%
%       Declarations
%
%               \date{date}
%               \to{name\\name\\name}
%               \from{name}
%               \fromaddress{simple address}
%               \fromext{telephone extension}
%               \fromemail{full email address}
%               \subject{string}
%               \copyto{name, name}
%
%               \date{...} has default of \today.
%               \to{...}, \from{...} and \subject{...} are compulsory.
%               Remainder are optional, default empty.
%
%               \begin{document} body of memorandum \end{document}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{UoYmemo}[2008/11/17 The University of York Memorandum Class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\LoadClass[a4paper]{scrartcl}
\RequirePackage{UoYstyle}

\addtolength{\textwidth}{3cm}
\addtolength{\evensidemargin}{-1.5cm}
\addtolength{\oddsidemargin}{-1.5cm}
\parindent=0pt
\parskip=1ex plus 1\fill minus 1\fill

\newenvironment{UoYm@tb}{\begin{tabular}[t]{@{}l@{}}}{\end{tabular}}

% A macro to skip printing empty variables
%       \long, because it can have an & in its argument.

\long\def\UoYm@pne#1#2#3{\ifx\@empty#2\relax\else#1#2#3\fi}

% A macro to declare declarations...
%       \UoYm@var{text} makes a declaration \text{value} that sets
%       \UoYm@text to value

\def\UoYm@var#1{%
        \expandafter\def\csname#1\endcsname##1%
                {\expandafter\def\csname UoYm@#1\endcsname{##1}}}

% A macro to set fields which *must* be set...

\def\UoYm@mf#1{%
  \ClassError{UoYmemo}%
  {You did not set the `#1' field.}%
  {Best to quit, set `#1' field and start again!}%
}
% new declaration       % default

\UoYm@var{date}         \date{\today}
\UoYm@var{to}           \to{\UoYm@mf{to}}
\UoYm@var{from}         \from{\UoYm@mf{from}}
\UoYm@var{fromaddress}  \fromaddress{}
\UoYm@var{department}   \department{}
\UoYm@var{fromext}      \fromext{}
\UoYm@var{fromemail}    \fromemail{}
\UoYm@var{subject}      \subject{\UoYm@mf{subject}}
\UoYm@var{copyto}       \copyto{}
\def\UoYm@CopyToText{\\[1ex]Copy to&\begin{UoYm@tb}\UoYm@copyto\end{UoYm@tb}}
\pagestyle{empty}
\AtBeginDocument{%
        \noindent%
        \begin{UoYm@tb}%
        \UoYbwlogo\hfill%
        \ifx\@empty\UoYm@department%
                \ % just a space to flush left UoY logo
        \else%
                {\scshape\bfseries Department of \UoYm@department}%
        \fi%
        \\[4ex]%
        \begin{tabular}[t]{@{}l@{\hspace{2ex}:\hspace{1ex}}l}%
                To&\begin{UoYm@tb}\UoYm@to\end{UoYm@tb}\\[1ex]%
                From&   \UoYm@from%
                        \footnotesize%
                        \UoYm@pne{, }\UoYm@fromaddress{}%
                        \UoYm@pne{, Ext: }\UoYm@fromext{}%
                        \UoYm@pne{, E-mail: $<$}\UoYm@fromemail{$>$}%
                        \\[1ex]%
                Date&\UoYm@date\\[1ex]%
                Re&\bfseries\begin{UoYm@tb}\UoYm@subject\end{UoYm@tb}%
                \ifx\@empty\UoYm@copyto\else\UoYm@CopyToText\fi%
        \end{tabular}%
        \\[2ex]%
        \rule{\textwidth}{1pt}\\[2ex]%
        \end{UoYm@tb}%
        \par
}
