lec3.pdf: clean compile
	rm -f lec3.aux
	rm -f lec3.log
	rm -f lec3.blg
	rm -f lec3.bbl

compile: lec3.tex
	pdflatex $<
	pdflatex $<
	pdflatex $<

clean:
	rm -f lec3.pdf

.PHONY: clean
