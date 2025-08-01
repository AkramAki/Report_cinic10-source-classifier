\ProvidesClass{tudothesis}[2015/08/31 v0.9 wrapper to scrbook for thesis at TUDo]
% Option for tu colors:
\newif\if@tucolor\@tucolorfalse
\DeclareOption{tucolor}{\@tucolortrue}

% All other Options go to KOMA-Script
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}
\PassOptionsToPackage{bibliography=totoc}{biblatex}
\ProcessOptions\relax

\LoadClass[
  headsepline,            % line  between header and text body
  bibliography=totoc,     % bibliography as unnumbered chapter in toc
  numbers=noenddot,       % no dot after figure/table number
  captions=tableheading,  % correct spacing for table headings
  titlepage=firstiscover, % symmetrical margins on titlepage
  headings=normal         % size of chapter headings slightly smaller
]{scrartcl}


% Define our beloved tu colour:
\RequirePackage{xcolor}
\xdefinecolor{tugreen}{RGB}{132, 184, 25}

\RequirePackage{caption}
\RequirePackage{subcaption}

% add some Color to structural elements if option tucolor was given
\RequirePackage{scrlayer-scrpage}
\pagestyle{scrheadings}

\KOMAoption{headsepline}{0.5pt}
\if@tucolor%
  \addtokomafont{title}{\color{tugreen}}          % title on titlepage
  \addtokomafont{section}{\color{tugreen}}     % headlines of the chapters, sections etc. 
  \setkomafont{headsepline}{\color{tugreen}}        % line between header and text body
  \DeclareCaptionFont{tugreen}{\color{tugreen}}
  \captionsetup{%
              labelfont={bf,tugreen},     % bold label in tu colour
              format=plain,               % no indentation under the label
              width=0.9\textwidth,        % slightly smaller width than text
              font=small,                 % font slightly smaller than text
            }
\else
  \captionsetup{%
              labelfont=bf,               % bold label
              format=plain,               % no indentation under the label
              width=0.9\textwidth,        % slightly smaller width than text
              font=small,                 % font slightly smaller than text
            }
\fi

% equation numbers of form chapter.equationnumber
\RequirePackage{amsmath}%
\renewcommand{\theequation}{\thechapter{}.\arabic{equation}}%
\numberwithin{equation}{section}%

% store the title in \thetitle, so one can access it in the document
\let\oldtitle\title%
\renewcommand{\title}[1]{\oldtitle{#1}\newcommand{\thetitle}{#1}}

% Provide all translations through the "translations" package
\RequirePackage{translations}

\DeclareTranslation{German}{thesisclass}{Arbeit zur Erlangung des akademischen Grades} % Not translated because no german version here needed
\DeclareTranslation{English}{thesisclass}{Course Report}

\DeclareTranslation{German}{birthplace}{geboren in}
\DeclareTranslation{English}{birthplace}{born in}

\DeclareTranslation{German}{firstcorrector}{Erstgutachter}
\DeclareTranslation{English}{firstcorrector}{First reviewer}

\DeclareTranslation{German}{secondcorrector}{Zweitgutachter}
\DeclareTranslation{English}{secondcorrector}{Second reviewer}

\DeclareTranslation{German}{submissiondate}{Abgabedatum}
\DeclareTranslation{English}{submissiondate}{Submission date}

\DeclareTranslation{German}{university}{Technische Universität Dortmund}
\DeclareTranslation{English}{university}{Technische Universität Dortmund} 


% initialize commands:
\newcommand\thebirthplace{}
\newcommand\thechair{}
\newcommand\thedivision{}
\newcommand\thethesisclass{}
\newcommand\thesubmissiondate{}
\newcommand\thefirstcorrector{}
\newcommand\thesecondcorrector{}

% new commands for information about the thesis
\newcommand\birthplace[1]{\renewcommand\thebirthplace{#1}}
\newcommand\chair[1]{\renewcommand\thechair{#1}}
\newcommand\division[1]{\renewcommand\thedivision{#1}}
\newcommand\thesisclass[1]{\renewcommand\thethesisclass{#1}}
\newcommand\submissiondate[1]{\renewcommand\thesubmissiondate{#1}}
\newcommand\firstcorrector[1]{\renewcommand\thefirstcorrector{#1}}
\newcommand\secondcorrector[1]{\renewcommand\thesecondcorrector{#1}}

% set title page elements
\subject{\GetTranslation{thesisclass} \\ \thethesisclass}
\publishers{\thechair \\ \thedivision \\ \GetTranslation{university}}

% page for the correctors
\newcommand{\makecorrectorpage}{%
  \thispagestyle{empty}
  \vspace*{\fill}
  \begin{tabular}{@{}l@{\hspace{2em}}l@{}}
      \GetTranslation{firstcorrector}:  & \thefirstcorrector \\
      \GetTranslation{secondcorrector}: & \thesecondcorrector \\
      \GetTranslation{submissiondate}:  & \thesubmissiondate
  \end{tabular}
  \newpage
}

% add birthplace to author
\let\oldauthor\author
\renewcommand\author[1]{%
  \oldauthor{#1 \\ \GetTranslation{birthplace} \thebirthplace}
}
