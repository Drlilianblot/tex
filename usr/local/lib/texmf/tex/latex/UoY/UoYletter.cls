%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Uni of York, letter head                                %
%                                                               %
%                                                               %
%       Jeremy Jacob                                            %
%                                                               %
%       original version 20 September 1994                      %
%       QAPFHE support added 20 February 1997                   %
%       \website{...} added 27 February 1997                    %
%       Colour support added 27 February 1997                   %
%       Alan Burns as HoD 24 August 1999                        %
%       Removed unused options 6 March 2000                     %
%       QAPFHE no longer default 7 Feb 2001                     %
%       Bug in empty `website' fixed 4 July 2001                %
%       Michael Harrison as HoD 12 August 2003                  %
%       Alan Burns as HoD 2004 Nov 18                           %
%       John McDermid as HoD 2006 Nov 13                        %
%       modified phone nos for Hes East 2010 Aug 31             %
%       added HesEast (default) & HesWest declarations          %
%       add THES Uni of Year option                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Options:
%       qapfhe                  Print QAPFE logo at end of header.
%       woodcut                 Prints woodcut at end of header.
%       thesuoy                 Prints THES University of the Year logo
%       nowoodcut               Prints nothing at the end of the
%                               header.
%       polychrome              Uses colour versions of the logotypes.
%
%  Declarations:
%
%
%       \signature{name}        As in ordinary letter style.
%       \date{whatever}
%
%       \extension{dddd}        To set extension number,
%                               if absent no direct number printed.
%
%
%       \department{Name}       For departments...
%       \ComputerScience        (telephone number & fax set by default)
%       \groupname{Name\\Name}  and anything else.
%
%       \grouptelext{dddd}      To set group telephone extension,
%                               if any.
%
%       \groupfaxext{dddd}      To set fax extension number,
%                               if any.
%
%       \grouphead{Name}        For the head of Group's name
%       \groupheadtitle{Title}  For his/her title.
%
%       \loginid{user}          For email address ``user@site'',
%       \emaildomain{site}      if either are unset no email
%                               address printed.
%       \website{url}           For URL ``url''
%
%       \namequal{name}         For your name and qualifications...
%       \jobtitle{job}          ...and what you do.
%
%       \headcolour{colour}     Set the colour of the heading
%
%       \national               For letters going to home and abroad,
%       \international          default is \national.
%
%       \yourref{string}        For setting references, if any.
%       \ourref{string}         Default for both is empty.
%
%  Other Macros:
%
%       \about{one-line}        for giving the subject of
%       \re{one-line}           letter, possibly preceeded by ``Re:''
%                               Not declarations, use in place.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% identification part %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{UoYletter}[2006/11/13 Jeremy Jacob The University of York Letter Head]

% initial code %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\relax          % None!

% declaration of options %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\DeclareOption{monochrome}{%
  \def\UoYl@QAPFHE{\QAPFHEthreeMC}%
  \def\UoYl@thesuoy{\THESgrey}%
  \def\UoYl@UoYlogo{\UoYbwlogo}%
  \def\headcolour#1{\def\UoYl@headcolour{black}}% disable colour changing
  \headcolour{black}%
  }
\DeclareOption{polychrome}{%
  \def\UoYl@QAPFHE{\QAPFHEthreePC}%
  \def\UoYl@thesuoy{\THESrgb}%
  \def\UoYl@UoYlogo{\UoYbluelogo}%
  \def\headcolour#1{\def\UoYl@headcolour{#1}}%
  \headcolour{black}%
  }
\DeclareOption{qapfhe}{%
  \def\UoYl@woodcut{\\[2.4ex]\UoYl@QAPFHE}%
  \def\UoYl@srb{\global\UoYl@raisebody = 40mm}}
\DeclareOption{thesuoy}{%
  \def\UoYl@woodcut{\\[2.4ex]\UoYl@thesuoy[14mm]}%
  \def\UoYl@srb{\global\UoYl@raisebody = 10ex}}
\DeclareOption{woodcut}{%
  \def\UoYl@woodcut{\\[2.4ex]\Woodcut[14mm]}%
  \def\UoYl@srb{\global\UoYl@raisebody = 10ex}}
\DeclareOption{nowoodcut}{%
  \def\UoYl@woodcut{}%
  \def\UoYl@srb{\global\UoYl@raisebody = 5ex}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}

% execution of options %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ExecuteOptions{monochrome,woodcut}
\ProcessOptions

% package loading %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\LoadClass[a4paper]{letter}     % gets standard letter stuff, or local
                                % replacement, and sets on A4 paper.
\RequirePackage{UoYstyle}
\urlstyle{sf}

% main code %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\UoYl@pne#1#2{\ifx\@empty#2\else#1#2\fi}

% Widths of heading...

\addtolength{\textwidth}{2cm}
\addtolength{\evensidemargin}{-1cm}
\addtolength{\oddsidemargin}{-1cm}

% Move text up on page, and lengthen page
\addtolength{\topmargin}{-4.5cm}
\addtolength{\textheight}{4.5cm}

% Take control of date

\def\@date{}    % set normal date mechanism to empty
\def\date#1{\def\UoYl@date{#1}}
\date{\today}

% an environment for making components of the address.

\newenvironment{UoYl@addbox}{\begin{tabular}[t]{@{}l@{}}}{\end{tabular}}

%       Standard settings, either National or International style.
\def\UoYl@std{1904}

\def\HesWest{\def\UoYl@campusaddress{Heslington,~YORK,~YO10~~5DD}}
\def\HesEast{\def\UoYl@campusaddress{Deramore Lane,~YORK,~YO10~~5GH}}
\HesEast % default

\def\national{%
        \def\UoYl@telpfx{(0\UoYl@std)~32}%
        \def\UoYl@address{\UoYl@campusaddress}}
\def\international{%
        \def\UoYl@telpfx{+44--\UoYl@std--32}%
        \def\UoYl@address{%
                \begin{UoYl@addbox}%
                        \UoYl@campusaddress,\\England%
                \end{UoYl@addbox}}}

\national               % the default

%       Group information

\def\grouptelext#1{\def\UoYl@grptelextension{#1}}
\grouptelext{}

\def\groupfaxext#1{\def\UoYl@grpfaxextension{#1}}
\groupfaxext{}

\def\grouphead#1{\def\UoYl@grouphead{#1}}
\grouphead{}

\def\groupheadtitle#1{\def\UoYl@groupheadtitle{#1}}
\groupheadtitle{}

%       User's information

\def\namequal#1{\def\UoYl@namequal{#1}}
\namequal{}

\def\jobtitle#1{\def\UoYl@jobtitle{#1}}
\jobtitle{}

\def\extension#1{\def\UoYl@extension{#1}}
\extension{}

\def\loginid#1{\def\UoYl@loginid{#1}}
\loginid{}
\def\emaildomain#1{\def\UoYl@emaildomain{#1}}
\emaildomain{}
\def\website#1{%
  \def\UoYl@tmp{#1}%
  \ifx\@empty\UoYl@tmp%
     \def\UoYl@website{}%
   \else%
     \def\UoYl@website{\url{#1}}%
   \fi%
   }
\website{http://www.york.ac.uk/}

\def\yourref#1{\def\UoYl@yourref{#1}}
\yourref{}

\def\ourref#1{\def\UoYl@ourref{#1}}
\ourref{}

%      Colour settings


% Now for the title strip...

\def\groupname#1%
        {\def\UoYl@grpaddress{%
                {\scshape\begin{UoYl@addbox}#1\end{UoYl@addbox}}}}

\def\department#1{\groupname{Department of\\\textbf{#1}}}
\def\ComputerScience{%
        \department{Computer Science}%
        \groupheadtitle{Head of Department}\grouphead{Prof. John McDermid}%
        \grouptelext{5500}\groupfaxext{5599}\emaildomain{cs.york.ac.uk}%
        \website{http://www.cs.york.ac.uk/}}

% Next macros define how the head of the front page should look.

\def\UoYl@rhheader{%
        \mbox{\rmfamily%
        \begin{UoYl@addbox}%
          {\large\UoYl@grpaddress}\\%
          {\upshape\footnotesize%
            \begin{UoYl@addbox}%
              \UoYl@address\\[.3ex]%
              \UoYl@pne{\\URL:\ }{\UoYl@website}%
              \UoYl@pne{\\[1ex]\textbf{\UoYl@groupheadtitle:}\\}%
                       {\UoYl@grouphead}%
              \UoYl@pne{\\[.6ex]Telephone: \UoYl@telpfx}%
                       {\UoYl@grptelextension}%
              \UoYl@pne{\\[.6ex]Facsimile: \UoYl@telpfx}%
                       {\UoYl@grpfaxextension}%
              \\[1ex]%
              \ifx\@empty\UoYl@namequal%
                  \UoYl@pne{\bfseries}{\UoYl@jobtitle}%
              \else%
                  \\[.6ex]\textbf\UoYl@namequal%
                  \UoYl@pne{\mdseries, }{\UoYl@jobtitle}%
              \fi%
              \UoYl@pne{\\[.6ex]Direct telephone: \UoYl@telpfx}%
                       {\UoYl@extension}%
              \ifx\@empty\UoYl@loginid%
                  \relax%
              \else\ifx\@empty\UoY@emaildomain%
                  \relax%
              \else%
                  \\[.6ex]E-mail: %
                  $<$\UoYl@loginid{@}\UoYl@emaildomain$>$%
              \fi\fi%
              \UoYl@woodcut%
            \end{UoYl@addbox}}
        \end{UoYl@addbox}}%
}

\def\UoYl@lhheader{%
  \begin{UoYl@addbox}%
    \normalsize%
    \UoYl@UoYlogo[8mm]%
    \ifx\@empty\UoYl@yourref%
      \UoYl@pne{\\[7ex]Our ref: }\UoYl@ourref%
    \else%
      \\[7ex]Your ref: \textbf{\UoYl@yourref}%
      \UoYl@pne{\\[.5ex]Our ref: }\UoYl@ourref%
    \fi%  
    \\[7ex]\UoYl@date%
  \end{UoYl@addbox}%
  }

% declaration and length for raising body

\newlength{\UoYl@raisebody}
\def\raisebody#1{\global\UoYl@raisebody = #1}
\UoYl@srb                       % declared by woodcut/nowoodcut options

\def\UoYl@header{%
  {%
    \color{\UoYl@headcolour}
    \hspace*{-\tabcolsep}%
    \begin{minipage}{\textwidth}%
      \UoYl@lhheader%
      \hfill%
      \UoYl@rhheader%
    \end{minipage}%
    \hspace*{-\tabcolsep}%
    \vspace*{-\UoYl@raisebody}%
    }%
  }

% now tell letter.sty what the correct address is:

\address{\UoYl@header}

% Added goodies

\def\about#1{\begin{center}\bfseries#1\end{center}}
\def\re#1{\about{Re: #1}}
