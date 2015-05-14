TARGET   = final_report
TEXFILES = $(wildcard *.tex)
#FIGURES = all_rt_plus_fav_count all_frac_endorsements_count_in_top all_frac_endorsements_count_in_top_per_bucket_points all_fcount rt_count_original_tweets_experts_vs_twitter


.SUFFIXES:	.plot .eps .fig

all: $(TARGET).pdf

$(TARGET).aux: $(TEXFILES)
	pdflatex $(TARGET).tex

$(TARGET).bbl: $(TARGET).aux $(TARGET).bib
	bibtex $(TARGET)

$(TARGET).pdf: $(TEXFILES)   $(addprefix figs/, $(addsuffix .eps, $(FIGURES))) $(TARGET).bbl
	pdflatex $(TARGET).tex
	pdflatex $(TARGET).tex
	evince $(TARGET).pdf

view:: $(TARGET).pdf
	open $(TARGET).pdf

see:: $(TARGET).dvi
	xdvi $(TARGET)

spell::
	ispell *.tex

clean::
	rm -fv *.dvi *.aux *.log *~ *.bbl *.blg *.toc *.ps *.pdf *.ent

fresh::
	rm -fv *.dvi *.aux *.log *~ *.bbl *.blg *.toc *.ps *.pdf

distclean:: clean
	rm $(TARGET).ps
