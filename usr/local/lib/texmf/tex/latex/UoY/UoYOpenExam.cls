%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       
%       UoYOpenExam.cls
%
%       A LaTeX Class for preparing University of York Open Examinations
%
%       Jeremy Jacob
%       <jeremy@minster.york.ac.uk>
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand*{\UoYe@filename}{UoYOpenExam}
\newcommand*{\UoYe@filedate}{2010/11/11}

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{\UoYe@filename}[\UoYe@filedate\space Jeremy Jacob, Computer Science]

\newif\ifUoYe@IsTeam
\DeclareOption{team}{\UoYe@IsTeamtrue}
\DeclareOption{single}{\UoYe@IsTeamfalse}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}

\ProcessOptions*

\LoadClass[a4paper,fontsize=12pt,DIV=calc]{scrartcl}
\RequirePackage{UoYstyle}
\typearea[current]{calc}

% A macro to create and intialise compulsory declarations.
% #1 is the name of the declaration, \UoYe@#1 is the internal name
% If these are not set it gives a sensible(-ish) error message
\def\UoYe@var#1{%
        \expandafter\def\csname#1\endcsname##1{%
                \expandafter\def\csname UoYe@#1\endcsname{##1}}%
        \csname#1\endcsname{%
          \ClassError{\UoYe@filename}%
                     {Missing `#1' declaration!}%
                     {Insert the `#1' declaration and restart!}%
        }%
}

% Some compulsory declarations
\UoYe@var{Part}
\UoYe@var{Degrees}
\UoYe@var{Examyear}
\UoYe@var{Maccode}
\UoYe@var{Courses}
\UoYe@var{Module}
\UoYe@var{Issue}
\UoYe@var{Due}
\UoYe@var{Setter}

\renewcommand*{\maketitle}{
  \begin{center}
    \UoYbwlogo\\[1ex]
    \UoYe@Degrees{} Examinations, \UoYe@Examyear\\[1ex]
    \textsc{\UoYe@Courses}\\
    Part \UoYe@Part\\[2ex]
    \textsc{\UoYe@Module}\\
    Open Examination\\[1ex]
    Issued at:\\\textbf{\UoYe@Issue}\\[1.5ex]
    Submission due:\\\textbf{\UoYe@Due}\\[2ex]
    \ifUoYe@IsTeam\else Your attention is drawn to the Guidelines on
    Mutual Assistance and Collaboration in the Student's Handbook and
    the Department's `Guide to Assessment Policies and Procedures'
    (\url{http://www.cs.york.ac.uk/exams/statementonassessment/}).\\[2ex]%
    \fi All queries on this assessment should be addressed to
    \textbf{\UoYe@Setter}.\\[2ex]
    \textbf{%
      Your examination number\ifUoYe@IsTeam s\else\fi\ must be written
      on the front of your submission.\\
      You must not identify yoursel\ifUoYe@IsTeam ves\else f\fi\ in
      any other way.
    }\\[2ex]
    Should you wish to request an extension see the appropriate section
    of the Department's `Guide to Assessment Policies and Procedures'.
  \end{center}
  \rule{\textwidth}{1pt}
}

\AtBeginDocument{\maketitle}

\newcommand*{\UoYe@EndOfText}{\vfill\begin{center}\Woodcut\end{center}}

\newcommand*{\ModelSolution}{%
  \UoYe@EndOfText\newpage\cleardoublepage\newpage\section*{Marking Notes}%
}

\AtEndDocument{\UoYe@EndOfText}

% set page style

\def\ps@openexam %
  {%
   \def\@evenhead{\hfill\UoYe@Maccode}%
   \def\@oddhead{\hfill\UoYe@Maccode}%
   \def\@evenfoot{\hfill\thepage\hfill}%
   \def\@oddfoot{\hfill\thepage\hfill}%
   }

\pagestyle{openexam}

% % change width and height of text.

% \newlength{\UoYe@extrawidth}
% \setlength{\UoYe@extrawidth}{1cm}
% \addtolength{\textwidth}{2\UoYe@extrawidth}
% \addtolength{\evensidemargin}{-\UoYe@extrawidth}
% \addtolength{\oddsidemargin}{-\UoYe@extrawidth}

% \newlength{\UoYe@extraheight}
% \setlength{\UoYe@extraheight}{1cm}
% \addtolength{\textheight}{\UoYe@extraheight}
% \addtolength{\topmargin}{-\UoYe@extraheight}
