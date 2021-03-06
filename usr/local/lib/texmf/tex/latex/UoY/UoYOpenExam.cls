%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       
%       UoYOpenExam.cls
%
%       A LaTeX Class for preparing University of York Open Examinations
%
%       Jeremy Jacob
%       <jeremy@minster.york.ac.uk>
%
%				Lilian Blot
%				<lilian.blot@york.ac.uk>
%
%       2017 Oct 19               Updated for new rules about open assessment 
%																	- added Component field \Componenet
%																	- added Demonstration date \Demonstration
%																	- added Special paper S after MacCode 
%																	  \Special
%																	- Added text for individual and group 
%																	  assessments
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage{xstring}

% The header code...
\def\UoYe@file@name{UoYOpenExam}
\def\UoYe@file@date{2017/10/19}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{UoYOpenExam}[2017/10/19 Lilian Blot, Computer Science]


\DeclareOption{final}{\def\UoYe@drafthead{}\def\UoYe@draftbanner{}}
\DeclareOption{rough}{%
  \def\UoYe@drafthead{\fbox{Draft: \today}}%
  \def\UoYe@draftbanner{{\LARGE DRAFT: \today}\\[4ex]}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ExecuteOptions{final}
\ProcessOptions
\LoadClass[twoside=true]{scrartcl}
\RequirePackage{UoYstyle}
\RequirePackage{ifthen}
\RequirePackage{geometry}
\RequirePackage{draftwatermark}
\definecolor{watermarkcolor}{cmyk}{0.05,0.1,0.01,0}
\SetWatermarkColor{watermarkcolor}


% end of header...

\let\UoYe@parbreak=\par         % fiddle to include \par in macros...

% a macro to create and intialise declarations.
% \#1 is the name of the declaration, \UoYe@#1 is the internal name
% If these are not set it gives a sensible(-ish) error message
\def\UoYe@var#1{%
  \expandafter\def\csname#1\endcsname##1{%
    \expandafter\def\csname UoYe@#1\endcsname{##1}}%
        \csname#1\endcsname{%
          \ClassError{UoYOpenExam}%
                     {Missing `#1' declaration!}%
                     {Insert the `#1' declaration and restart!}%
        }%
}

% To record obsolete declaration.

\def\UoYe@obsoletevar#1{%
  \expandafter\def\csname#1\endcsname##1{%
        \ClassWarning{UoYOpenExam}{The declaration `#1' is obsolete.}
        }%
}

% Some compulsory declarations

\UoYe@var{Maccode}
\UoYe@var{Degrees}
\UoYe@var{Examyear}
\UoYe@var{Module}
\UoYe@var{Component}
\UoYe@var{Issued}
\UoYe@var{Due}
\UoYe@var{Demonstration}
\UoYe@var{Marksdue}
\UoYe@var{Setter}
\UoYe@var{Setteremail}
\Component{None}
\Demonstration{None}

% A non-standard compulsory declaration
\long\def\Rubric#1{\def\UoYe@Rubric{#1}}
\Rubric{%
  \ClassError{UoYOpenExam}%
             {Missing `Rubric' declaration!}%
             {Insert the `Rubric' declaration and restart!}%
        
}

\newcommand*{\lastpage}{\pageref{lastpage}}

\newcommand{\UoYe@EndMarker}{\textbf{\large End of examination paper}}%{\rule{0.66\textwidth}{2ex}}

\newif\ifresitpaper
\resitpaperfalse
\newcommand*{\Resit}{\resitpapertrue}

\newif\ifspecialpaper
\specialpaperfalse
\newcommand*{\Special}{\specialpapertrue}

\newif\ifUoYe@IsTeam
{\UoYe@IsTeamtrue}
\newcommand*{\Team}{\UoYe@IsTeamtrue}



% set page style

% Get page styles right.  MAC code & optional "RESIT" at top RH corner
% of each page.
% Page number at bottom.  Either ``turn over'' or ``continued'' at
% bottm RH corner depending on whether it is in the middle of a
% question or not.

% In the main part of the paper
% headings only depend on evenness or oddness of page
\def\@oddhead{%
  \UoYe@drafthead%
  \hskip 0pt plus 1fil minus 0pt%
  \ifresitpaper%
		\ifspecialpaper%
			\begin{tabular}{c}\UoYe@Maccode--S\\RESIT\end{tabular}%
		\else%
			\begin{tabular}{c}\UoYe@Maccode\\RESIT\end{tabular}%
		\fi
  \else%
		\ifspecialpaper%
			\UoYe@Maccode--S%
		\else
			\UoYe@Maccode%
		\fi
  \fi%
}
\def\@evenhead{%
  \UoYe@drafthead%
  \hskip 0pt plus 1fil minus 0pt%
  \ifresitpaper%
		\ifspecialpaper%
			\begin{tabular}{c}\UoYe@Maccode--S\\RESIT\end{tabular}%
		\else%
			\begin{tabular}{c}\UoYe@Maccode\\RESIT\end{tabular}%
		\fi
  \else%
		\ifspecialpaper%
			\UoYe@Maccode--S%
		\else
			\UoYe@Maccode%
		\fi
  \fi%
}

% odd and even feet are always the same                     
\def\@evenfoot{\hskip 0pt plus 1fil Page~\thepage~of~\lastpage\hskip 0pt plus 1fil\relax}
\def\@oddfoot{\hskip 0pt plus 1fil Page~\thepage~of~\lastpage\hskip 0pt plus 1fil\relax}

% Set TeX & LaTeX style parameters
\renewcommand{\familydefault}{\sfdefault}
\parindent=0pt
\parskip=2ex plus 0.1pt
\typearea[current]{calc}
%\pagestyle{UoYe@betweenqs}

% at begin and end of document...
\AtBeginDocument{%
	\centering
  %\raggedright%
  %\begin{center}%
    %{\scshape University of York}\\[2ex]%
		\UoYbwlogo[8ex]\\[4ex]
		
    {\bfseries \UoYe@Degrees{} Degree Examinations \UoYe@Examyear}\\[2ex]%
    {\large\mdseries\scshape DEPARTMENT OF COMPUTER SCIENCE}\\[4ex]%
		\IfStrEq{\UoYe@Component}{None}{{\Large\bfseries\UoYe@Module}}{{\Large\bfseries\UoYe@Module} \\[1ex] \textbf{\UoYe@Component}}\\[2ex]

    \ifUoYe@IsTeam Open Group Assessment\else Open Individual Assessment\fi\\[2ex]
		
  %\end{center}%
		
  \raggedright%
    \textbf{Issued:~\UoYe@Issued}\\[.5ex]
    \textbf{Submission due:~\UoYe@Due}\\[.5ex]
    \IfStrEq{\UoYe@Demonstration}{None}{}{\textbf{Demonstration:~\UoYe@Demonstration}\\[.5ex]}
    \textbf{Feedback and marks due:~\UoYe@Marksdue}\\[2ex]

    \UoYe@draftbanner%
		
		All students should submit their answers through the electronic submission system: \url{http://www.cs.york.ac.uk/student/assessment/submit/} by \UoYe@Due. An assessment that has been submitted after this deadline will be marked initially as if it had been handed in on time, but the Board of Examiners will normally apply a lateness penalty.\\[1.5ex]
		
Your attention is drawn to the section about Academic Misconduct in your Departmental Handbook: \url{https://www.cs.york.ac.uk/student/handbook/}.\\[1.5ex]

Any queries on this assessment should be addressed by email to \UoYe@Setter ~at \UoYe@Setteremail. Answers that apply to all students will be posted on the VLE.
		
		{\large \bfseries Rubric:}\\
    \UoYe@Rubric%
  \sffamily%
	\label{firstpage}
	\vfill
	\ifUoYe@IsTeam {\bfseries The name of all your group members should be on the front cover of your assessment. Do not include exam numbers as these are private to individuals.} 
	\else {\bfseries Your exam number should be on the front cover of your assessment. You should not be otherwise identified anywhere on your submission.}
	\fi
  \clearpage%
}

\AtEndDocument{%
  \hspace{5em}
  \begin{center}\UoYe@EndMarker\end{center}%
  \label{lastpage}
}

\geometry{inner=3.5cm,outer=3cm}

% end of file

