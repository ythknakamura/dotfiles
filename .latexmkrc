#!/usr/bin/env perl
$pdf_mode		= 3; # generates pdf via dvipdf
$latex			= "platex -shell-escape -synctex=1 -interaction=nonstopmode %O %S";
$dvipdf			= "dvipdfmx %O %S";
$pdflatex		= "lualatex -synctex=1 -interaction=nonstopmode %O %S";
$bibtex			= "pbibtex %O %B";
$pdf_previewer		= "start qpdfview %O %S";
#$pdf_previewer		= "evince";
