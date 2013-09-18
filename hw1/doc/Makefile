all: p1 p2 p3 p4 p5 p6

p1: rmp1 p1.pdf
rmp1:
	rm -f p1.pdf
p1.pdf: p1.tex
	pdflatex $<
	rm -f p1.aux; rm -f p1.log; rm -f p1.blg; rm -f p1.bbl

p2: rmp2 p2.pdf
rmp2:
	rm -f p2.pdf
p2.pdf: p2.tex
	pdflatex $<
	rm -f p2.aux; rm -f p2.log; rm -f p2.blg; rm -f p2.bbl

p3: rmp3 p3.pdf
rmp3:
	rm -f p3.pdf
p3.pdf: p3.tex
	pdflatex $<
	rm -f p3.aux; rm -f p3.log; rm -f p3.blg; rm -f p3.bbl

p4: rmp4 p4.pdf
rmp4:
	rm -f p4.pdf
p4.pdf: p4.tex
	pdflatex $<
	rm -f p4.aux; rm -f p4.log; rm -f p4.blg; rm -f p4.bbl

p5: rmp5 p5.pdf
rmp5:
	rm -f p5.pdf
p5.pdf: p5.tex
	pdflatex $<
	rm -f p5.aux; rm -f p5.log; rm -f p5.blg; rm -f p5.bbl

p6: rmp6 p6.pdf
rmp6:
	rm -f p6.pdf
p6.pdf: p6.tex
	pdflatex $<
	rm -f p6.aux; rm -f p6.log; rm -f p6.blg; rm -f p6.bbl

clean:
	rm -f *.pdf

.PHONY: clean


## ================================
## old ideas:

#main.pdf: main.tex main.bib
	#pdflatex $<
	#bibtex main 
	#pdflatex $<
	#pdflatex $<

#clean:
	#rm -f *.aux; rm -f *.log; rm -f *.blg; rm -f *.bbl

#spotless: clean
	#rm -f *.pdf

#.PHONY: clean spotless
